use Mix.Config

config :echo, Echo.Endpoint,
  http: [port: System.get_env("PORT")],
  url: [scheme: "https", host: System.get_env("HOST"), port: 443],
  cache_static_manifest: "priv/static/manifest.json",
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

config :logger, level: :info

config :echo, Echo.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "echo_production",
  url: System.get_env("DATABASE_URL"),
  size: 20

config :echo, Echo.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")
