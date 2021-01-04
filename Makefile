migrate:
	cd backend && mix ecto.migrate

rollback:
	cd backend && mix ecto.rollback --all

sync:
	cd datasync && RUST_LOG=debug cargo run
