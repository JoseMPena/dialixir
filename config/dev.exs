use Mix.Config

config :dialixir, host: System.get_env("DIALOGFLOW_URL")
config :dialixir, project_id: System.get_env("DIALOGFLOW_PROJECT_ID")
config :dialixir, client_email: System.get_env("CLIENT_EMAIL")
