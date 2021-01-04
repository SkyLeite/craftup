migrate:
	cd backend && mix ecto.migrate

rollback:
	cd backend && mix ecto.rollback --all

db-clean:
	cd backend && mix ecto.rollback --all && mix ecto.migrate

sync:
	cd datasync && RUST_LOG=debug cargo run
