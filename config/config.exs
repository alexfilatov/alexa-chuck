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
config :chuck,
       ChuckWeb.Endpoint,
       url: [
         host: {:system, :string, "APP_HOST", "localhost"},
         port: {:system, :integer, "APP_PORT", 4100}
       ],
       http: [
         port: {:system, :integer, "APP_PORT", 4100}
       ],
       secret_key_base: {:system, :string, "SECRET_KEY_BASE"},
       render_errors: [
         view: ChuckWeb.ErrorView,
         accepts: ~w(html json)
       ],
       pubsub: [
         name: Chuck.PubSub,
         adapter: Phoenix.PubSub.PG2
       ],
       live_view: [
         signing_salt: {:system, :string, "SIGNING_SALT"}
       ]

# Configures Elixir's Logger
config :logger,
       :console,
       format: "$time $metadata[$level] $message\n",
       metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
