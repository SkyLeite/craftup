use postgres;

pub struct Client {
    db: postgres::Client,
}

impl Client {
    pub fn new(connect_string: &str) -> Result<Self, Box<dyn std::error::Error>> {
        Ok(Self {
            db: postgres::Client::connect(connect_string, postgres::NoTls)?,
        })
    }

    pub fn add_items(
        &mut self,
        items: Vec<crate::types::Item>,
    ) -> Result<(), Box<dyn std::error::Error>> {
        let query = Client::build_insert(
            "items",
            vec![
                "id",
                "name",
                "description",
                "icon",
                "stack_size",
                "plural",
                "singular",
                "patch",
                "level",
            ],
        );

        let statement = self.db.prepare(&query)?;

        log::debug!("Prepared query: {}", query);

        let mut transaction = self
            .db
            .build_transaction()
            .isolation_level(postgres::IsolationLevel::RepeatableRead)
            .start()?;

        log::info!("Building transaction with {} items", items.len());
        items.into_iter().for_each(|item| {
            transaction
                .execute(
                    &statement,
                    &[
                        &item.id,
                        &item.name,
                        &item.description,
                        &item.icon,
                        &item.stack_size,
                        &item.plural,
                        &item.singular,
                        &0,
                        &item.level_item,
                    ],
                )
                .unwrap();
        });

        log::info!("Transaction built. Comitting.");
        transaction.commit()?;
        log::info!("Items inserted.");

        Ok(())
    }

    pub fn add_recipes(
        &mut self,
        recipes: Vec<crate::types::Recipe>,
    ) -> Result<(), Box<dyn std::error::Error>> {
        let recipe_insert_query = Client::build_insert(
            "recipes",
            vec![
                "id",
                "can_hq",
                "can_quick_synth",
                "difficulty_factor",
                "durability_factor",
                "quality_factor",
                "required_control",
                "required_craftsmanship",
                "patch_number",
                "is_specialization_required",
                "resulting_item_id",
                "resulting_item_quantity",
                "recipe_level_id",
            ],
        );
        let recipe_ingredient_insert_query = Client::build_insert(
            "recipe_ingredients",
            vec!["quantity", "item_id", "recipe_id"],
        );

        let recipe_insert_statement = self.db.prepare(&recipe_insert_query)?;
        let recipe_ingredients_insert_statement =
            self.db.prepare(&recipe_ingredient_insert_query)?;

        let mut transaction = self
            .db
            .build_transaction()
            .isolation_level(postgres::IsolationLevel::RepeatableRead)
            .start()?;
        log::info!("Building transaction with {} recipes", recipes.len());

        for recipe in recipes {
            transaction.execute(
                &recipe_insert_statement,
                &[
                    &recipe.id,
                    &recipe.can_hq,
                    &recipe.can_quicksynth,
                    &recipe.difficulty_factor,
                    &recipe.durability_factor,
                    &recipe.quality_factor,
                    &recipe.required_control,
                    &recipe.required_craftsmanship,
                    &recipe.patch_number,
                    &recipe.is_specialization_required,
                    &recipe.item_result,
                    &recipe.amount_result,
                    &recipe.recipe_level_table,
                ],
            )?;
        }

        transaction.commit()?;

        Ok(())
    }

    fn build_insert(table_name: &str, fields: Vec<&str>) -> String {
        let fields_str = fields.join(", ");
        let fields_iter = fields.into_iter().enumerate();
        format!(
            "INSERT INTO {name} ({columns}) VALUES ({variables}) ON CONFLICT (id) DO UPDATE SET {update}",
            name = table_name,
            columns = fields_str,
            variables = fields_iter.clone()
                .map(|(i, _x)| format!("${}", i + 1))
                .collect::<Vec<String>>()
                .join(", "),
            update = fields_iter
                .map(|(i, x)| format!("{} = ${}", x, i + 1))
                .collect::<Vec<String>>()
                .join(", "),
        )
    }
}
