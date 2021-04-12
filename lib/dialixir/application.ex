defmodule Dialixir.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    credentials = "GOOGLE_CREDENTIALS" |> System.fetch_env!() |> Jason.decode!()
    IO.inspect(credentials)
    source = {:service_account, credentials, []}

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Dialixir.Worker.start_link(arg1, arg2, arg3)
      # worker(Dialixir.Worker, [arg1, arg2, arg3]),
      {Goth, name: Dialixir.Goth, source: source}
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dialixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
