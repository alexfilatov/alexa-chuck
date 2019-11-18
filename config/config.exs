# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chuck,
  ecto_repos: [Chuck.Repo]

# Configures the endpoint
config :chuck, ChuckWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rE2+mKUy4UDXDfMVPy0njTQhd/BXT5+Dy4YPJhZR8gh8sj7rjAr3IQa4imkxLRgk",
  render_errors: [view: ChuckWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chuck.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
