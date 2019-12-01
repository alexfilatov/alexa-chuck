use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :chuck,
       ChuckWeb.Endpoint,
       http: [
         port: 4100
       ],
       debug_errors: true,
       code_reloader: true,
       check_origin: false,
       secret_key_base: {:system, :string, "SECRET_KEY_BASE"},
       watchers: [
         node: [
           "node_modules/webpack/bin/webpack.js",
           "--mode",
           "development",
           "--watch-stdin",
           cd: Path.expand("../assets", __DIR__)
         ]
       ]


# Watch static and templates for browser reloading.
config :chuck,
       ChuckWeb.Endpoint,
       live_reload: [
         patterns: [
           ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
           ~r"priv/gettext/.*(po)$",
           ~r"lib/chuck_web/{live,views}/.*(ex)$",
           ~r"lib/chuck_web/templates/.*(eex)$",
           ~r{lib/chuck_web/live/.*(ex)$}
         ]
       ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
