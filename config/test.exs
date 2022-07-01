import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :wow_data, WoWData.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "wow_data_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wow_data, WoWDataWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "l/tcfg6ZoaWs8aIfMe/BJVVcHPV319HL1cLmg1M6rHikKR2giEc0HAg5EkFoawyh",
  server: false

# In test we don't send emails.
config :wow_data, WoWData.Mailer, adapter: Swoosh.Adapters.Test

config :wow_data, :client, impl: WoWData.Api.ClientBehaviourMock

config :wow_data, :access_token_request, impl: WoWData.Api.AccessTokenBehaviourMock

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
