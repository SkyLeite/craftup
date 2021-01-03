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
        mut self,
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
