use std::path::Path;

use git2::Repository;
use simple_logger::SimpleLogger;

mod db;
mod types;

const REPOSITORY_URL: &str = "https://github.com/xivapi/ffxiv-datamining";

fn main() {
    SimpleLogger::from_env()
        .with_module_level("tokio_postgres", log::LevelFilter::Warn)
        .init()
        .unwrap();

    let mut datamining_path = std::env::temp_dir();
    datamining_path.push("ffxiv-datamining");

    log::info!("Cloning repository {}", REPOSITORY_URL);
    clone_repository(&datamining_path);

    let mut client = db::Client::new(
        "host=localhost port=1231 user=postgres password=postgres dbname=craftup_dev",
    )
    .unwrap();

    add_entity::<types::Item>(&mut client, "Item", db::Client::add_items).unwrap();
    add_entity::<types::RecipeLevel>(
        &mut client,
        "RecipeLevelTable",
        db::Client::add_recipe_levels,
    )
    .unwrap();
    add_entity::<types::Recipe>(&mut client, "Recipe", db::Client::add_recipes).unwrap();

    log::info!("Done! Bye!");
}

fn add_entity<T>(
    client: &mut db::Client,
    entity_name: &str,
    f: fn(&mut db::Client, Vec<T>) -> Result<(), Box<dyn std::error::Error>>,
) -> Result<(), Box<dyn std::error::Error>>
where
    T: for<'de> serde::Deserialize<'de>,
    T: types::GameItem,
{
    let mut datamining_path = std::env::temp_dir();
    datamining_path.push("ffxiv-datamining");

    let mut entity_path = datamining_path.clone();
    entity_path.push("csv");
    entity_path.push(entity_name);
    entity_path.set_extension("csv");

    log::debug!("Parsing {}", entity_path.to_str().unwrap());
    let entities = read_data_file::<T>(&entity_path)?;

    log::info!("Synchronizing {} {}s", entities.len(), entity_name);
    f(client, entities)?;

    log::info!("{}s synchronized.", entity_name);
    Ok(())
}

fn read_data_file<T>(file_source: &Path) -> Result<Vec<T>, Box<dyn std::error::Error>>
where
    T: for<'de> serde::Deserialize<'de>,
    T: types::GameItem,
{
    let contents: &str = &std::fs::read_to_string(file_source)
        .unwrap()
        .splitn(5, "\n")
        .skip(4)
        .collect::<Vec<&str>>()
        .join("\n");

    let results = csv::ReaderBuilder::new()
        .has_headers(false)
        .from_reader(contents.as_bytes())
        .deserialize()
        .map(|x| -> T { x.unwrap() })
        .filter(|x| x.is_valid())
        .collect::<Vec<T>>();

    Ok(results)
}

fn clone_repository(destination: &Path) {
    if destination.exists() {
        log::info!("Removing path {}", destination.to_str().unwrap());
        std::fs::remove_dir_all(&destination).unwrap();
    }

    log::info!("Creating path {}", destination.to_str().unwrap());
    std::fs::create_dir(&destination).unwrap();

    log::info!(
        "Cloning repository {} into {}",
        REPOSITORY_URL,
        destination.to_str().unwrap()
    );
    Repository::clone(REPOSITORY_URL, &destination).unwrap();
}
