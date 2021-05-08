use Mix.Config

config :dialixir, project_id: System.get_env("GOOGLE_CLOUD_PROJECT")
config :dialixir, google_credentials: System.get_env("GOOGLE_APPLICATION_CREDENTIALS")
