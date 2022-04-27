prodserver:
	cd backend && MIX_ENV=prod mix phx.server

deps:
	docker-compose up -d postgres pgadmin

server:
	cd backend && mix phx.server

front:
	cd frontend && yarn dev

migrate:
	cd backend && mix ecto.migrate

rollback:
	cd backend && mix ecto.rollback --all

db-clean:
	cd backend && mix ecto.rollback --all && mix ecto.migrate

sync:
	cd datasync && RUST_LOG=debug cargo run

build-front:
	cd frontend && yarn && yarn build

dev:
	make -j 3 deps server front
