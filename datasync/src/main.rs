use std::{error::Error, path::Path};

use git2::Repository;
use simple_logger::SimpleLogger;

mod db;
mod types;

const REPOSITORY_URL: &str = "https://github.com/xivapi/ffxiv-datamining";

fn main() {
    SimpleLogger::from_env().init().unwrap();

    let mut datamining_path = std::env::temp_dir();
    datamining_path.push("ffxiv-datamining");

    let mut items_path = datamining_path.clone();
    items_path.push("csv");
    items_path.push("Item");
    items_path.set_extension("csv");

    log::info!("Cloning repository {}", REPOSITORY_URL);
    clone_repository(&datamining_path);

    let client = db::Client::new(
        "host=localhost port=1231 user=postgres password=postgres dbname=craftup_dev",
    )
    .unwrap();
    let items = read_data_file::<types::Item>(&items_path).unwrap();

    client.add_items(items).unwrap();
    log::info!("Done! Bye!");
}

fn read_data_file<T>(file_source: &Path) -> Result<Vec<T>, Box<dyn Error>>
where
    T: for<'de> serde::Deserialize<'de>,
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
        .map(|x| x.unwrap())
        .collect::<Vec<T>>();

    Ok(results)
}

fn clone_repository(destination: &Path) {
    log::info!("Removing path {}", destination.to_str().unwrap());
    std::fs::remove_dir_all(&destination).unwrap();

    log::info!("Creating path {}", destination.to_str().unwrap());
    std::fs::create_dir(&destination).unwrap();

    log::info!(
        "Cloning repository {} into {}",
        REPOSITORY_URL,
        destination.to_str().unwrap()
    );
    Repository::clone(REPOSITORY_URL, &destination).unwrap();
}
