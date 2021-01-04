use crate::types::{bool_from_string, GameItem};
use serde::{self, Deserialize};

#[derive(Debug, Deserialize)]
pub struct Recipe {
    pub id: i64,
    pub number: i32,
    pub craft_type: i32,
    pub recipe_level_table: i64,
    pub item_result: i64,
    pub amount_result: i32,
    pub item_ingredient_0: i64,
    pub amount_ingredient_0: i32,
    pub item_ingredient_1: i64,
    pub amount_ingredient_1: i32,
    pub item_ingredient_2: i64,
    pub amount_ingredient_2: i32,
    pub item_ingredient_3: i64,
    pub amount_ingredient_3: i32,
    pub item_ingredient_4: i64,
    pub amount_ingredient_4: i32,
    pub item_ingredient_5: i64,
    pub amount_ingredient_5: i32,
    pub item_ingredient_6: i64,
    pub amount_ingredient_6: i32,
    pub item_ingredient_7: i64,
    pub amount_ingredient_7: i32,
    pub item_ingredient_8: i64,
    pub amount_ingredient_8: i32,
    pub item_ingredient_9: i64,
    pub amount_ingredient_9: i32,
    pub blank_1: String,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_secondary: bool,

    pub material_quality_factor: i32,
    pub difficulty_factor: i32,
    pub quality_factor: i32,
    pub durability_factor: i32,
    pub blank_2: String,
    pub required_craftsmanship: i32,
    pub required_control: i32,
    pub quicksynth_craftsmanship: i32,
    pub quicksynth_control: i32,
    pub secrret_recipe_book: i32,
    pub blank_3: String,

    #[serde(deserialize_with = "bool_from_string")]
    pub can_quicksynth: bool,

    #[serde(deserialize_with = "bool_from_string")]
    pub can_hq: bool,

    #[serde(deserialize_with = "bool_from_string")]
    pub exp_rewarded: bool,

    pub status_required: i32,
    pub item_required: i32,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_specialization_required: bool,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_expert: bool,

    pub patch_number: i32,
}

impl GameItem for Recipe {
    fn is_valid(&self) -> bool {
        self.number > 0
    }
}
