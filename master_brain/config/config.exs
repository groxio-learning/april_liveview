# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :master_brain,
  ecto_repos: [MasterBrain.Repo]

# Configures the endpoint
config :master_brain, MasterBrainWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "o8JTnACGM1ev1uArmt7YQru116G7yjMlV00VjaIXp7N1ZMujVhWiHtmHcrcsbElE",
  render_errors: [view: MasterBrainWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MasterBrain.PubSub,
  live_view: [signing_salt: "8IoLpxtt"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
