use serde::{self, Deserialize, Deserializer};

#[derive(Debug, Deserialize)]
pub struct Item {
    pub id: i64,
    pub singular: String,
    pub adjective: String,
    pub plural: String,
    pub possessive_pronoun: String,
    pub starts_with_vowel: String,
    pub blank1: String,
    pub pronoun: String,
    pub article: String,
    pub description: String,
    pub name: String,
    pub icon: String,
    pub level_item: i32,
    pub rarity: String,
    pub filter_group: String,
    pub additional_data: String,
    pub item_u_i_category: String,
    pub item_search_category: String,
    pub equip_slot_category: String,
    pub item_sort_category: String,
    pub blank2: String,
    pub stack_size: i32,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_unique: bool,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_untradable: bool,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_indisposable: bool,
    pub lot: String,
    pub price_mid: String,
    pub price_low: String,
    pub can_be_hq: String,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_dyeable: bool,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_crest_worthy: bool,
    pub item_action: String,
    pub blank3: String,
    pub cooldown: String,
    pub class_job_repair: String,
    pub item_repair: String,
    pub item_glamour: String,
    pub desynth: String,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_collectable: bool,
    pub always_collectable: String,
    pub aetherial_reduce: String,
    pub unknown54: String,
    pub level_equip: String,
    pub blank4: String,
    pub equip_restriction: String,
    pub class_job_category: String,
    pub grand_company: String,
    pub item_series: String,
    pub base_param_modifier: String,
    pub model_main: String,
    pub model_sub: String,
    pub class_job_use: String,
    pub blank5: String,
    pub damage_phys: String,
    pub damage_mag: String,
    pub delay_ms: String,
    pub blank6: String,
    pub block_rate: String,
    pub block: String,
    pub defense_phys: String,
    pub defense_mag: String,
    pub base_param0: String,
    pub base_param_value0: String,
    pub base_param1: String,
    pub base_param_value1: String,
    pub base_param2: String,
    pub base_param_value2: String,
    pub base_param3: String,
    pub base_param_value3: String,
    pub base_param4: String,
    pub base_param_value4: String,
    pub base_param5: String,
    pub base_param_value5: String,
    pub item_special_bonus: String,
    pub item_special_bonus_param: String,
    pub base_param_special0: String,
    pub base_param_value_special0: String,
    pub base_param_special1: String,
    pub base_param_value_special1: String,
    pub base_param_special2: String,
    pub base_param_value_special2: String,
    pub base_param_special3: String,
    pub base_param_value_special3: String,
    pub base_param_special4: String,
    pub base_param_value_special4: String,
    pub base_param_special5: String,
    pub base_param_value_special5: String,
    pub materialize_type: String,
    pub materia_slot_count: String,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_advanced_melding_permitted: bool,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_pv_p: bool,
    pub blank: i32,

    #[serde(deserialize_with = "bool_from_string")]
    pub is_glamourous: bool,
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
