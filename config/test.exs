use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chuck, ChuckWeb.Endpoint,
  http: [port: 4002],
  server: false,
  secret_key_base: {:system, :string, "SECRET_KEY_BASE"}

# Print only warnings and errors during test
config :logger, level: :warn
