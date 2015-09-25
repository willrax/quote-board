use Mix.Config

import_config "prod.secret.exs"

config :logger, level: :info

config :echo, Echo.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "echo_production",
  url: System.get_env("DATABASE_URL"),
  size: 20

config :echo, Echo.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")
