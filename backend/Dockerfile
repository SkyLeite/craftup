FROM bitwalker/alpine-elixir-phoenix:latest

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

ADD . .

CMD ["mix", "phx.server"]
