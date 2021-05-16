# Dialixir (Not [dialyxir](https://hex.pm/packages/dialyxir))

Very basic client for Dialogflow API v2.
Based off [flowex](https://github.com/resuelve/flowex)

## Installation

Add dialixir to your mix file:

```elixir
def deps do
  [
    {:dialixir, "~> 0.1.0"}
  ]
end
```

and install dependencies
```shell
mix deps.get
```

## How to use
You *must* have the following environment variables in your project
PROJECT_ID={your Google project ID}
APPLICATION_CREDENTIALS={path to the json file with project credentials}

You also need to have the proper configuration entries in your `config.exs` file
```elixir
config :dialixir, project_id: System.get_env("PROJECT_ID")
config :dialixir, google_credentials: System.get_env("APPLICATION_CREDENTIALS")
```


### Dialixir.Service.Agent

Fetch the agent associated project_id. [getAgent](https://cloud.google.com/dialogflow/es/docs/reference/rest/v2/projects/getAgent)

```elixir
get()
```

### Dialixir.Service.Intents

List all intents from an agent. [list](https://cloud.google.com/dialogflow/es/docs/reference/rest/v2/projects.agent.entityTypes/list)

```elixir
list(language \\ "es", view \\ "INTENT_VIEW_UNSPECIFIED", pageSize \\ 100, token \\ nil)
```

### dialixir.Service.Sessions

Procesa una consulta en lenguaje natural para detectar un intent con la respuesta apropiada [(📘)](https://dialogflow.com/docs/reference/api-v2/rest/v2/projects.agent.sessions/detectIntent)

```elixir
detect_intent(project, text, session_id, languageCode \\ "es",)
```
