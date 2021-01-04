use crate::types::GameItem;
use serde::{self, Deserialize};

#[derive(Debug, Deserialize)]
pub struct RecipeLevel {
    pub id: i64,
    pub class_job_level: i32,
    pub stars: i32,
    pub suggested_craftsmanship: i32,
    pub suggested_control: i32,
    pub difficulty: i32,
    pub quality: i32,
    pub durability: i32,
    pub unknown: i32,
}

impl GameItem for RecipeLevel {
    fn is_valid(&self) -> bool {
        self.class_job_level > 0
    }
}
