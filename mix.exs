defmodule Dialixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :dialixir,
      version: "0.1.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Dialixir",
      source_url: "https://github.com/JoseMPena/dialixir"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test]},
      {:excoveralls, "~> 0.14", only: :test},
      {:httpoison, "~> 1.8"},
      {:mock, "~> 0.3.0", only: :test},
      {:poison, "~> 3.1"},
      {:goth, "~> 1.3-rc"},
      {:hackney, "~> 1.17"}
    ]
  end

  defp description() do
    "Small basic wrapper around Dialogflow API V2"
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      # name: "postgrex",
      # These are the default files included in the package
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/JoseMPena/dialixir"}
    ]
  end
end
