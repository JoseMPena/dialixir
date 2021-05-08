use Mix.Config
config :dialixir, project_id: System.get_env("PROJECT_ID")
config :dialixir, google_credentials: System.get_env("APPLICATION_CREDENTIALS")
