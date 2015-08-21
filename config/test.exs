use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :echo, Echo.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :echo, Echo.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  adapter: Ecto.Adapters.Postgres,
  username: "echo",
  password: "",
  database: "echo_test",
  size: 1 # Use a single connection for transactional tests
