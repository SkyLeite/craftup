use serde::{self, Deserialize, Deserializer};

mod item;
mod recipe;
mod recipe_level;

pub use item::Item;
pub use recipe::Recipe;
pub use recipe_level::RecipeLevel;

pub trait GameItem {
    fn is_valid(&self) -> bool;
}

fn bool_from_string<'de, D>(deserializer: D) -> Result<bool, D::Error>
where
    D: Deserializer<'de>,
{
    match String::deserialize(deserializer)?.as_str() {
        "False" => Ok(false),
        "True" => Ok(true),
        other => Err(serde::de::Error::invalid_value(
            serde::de::Unexpected::Str(other),
            &"False or True",
        )),
    }
}
