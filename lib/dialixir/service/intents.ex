defmodule Dialixir.Service.Intents do
  @moduledoc """
  Helper para intents.
  """

  alias Dialixir

  @doc """
  Lista todos los intents de un agente por pageToken.
  """
  @spec list(String.t(), String.t(), String.t() | nil, list) :: tuple
  def list(language \\ "es", view \\ "INTENT_VIEW_UNSPECIFIED", token \\ nil, acc \\ []) do
    case list_by_page(language, view, 100, token) do
      {:ok, %{"intents" => intents, "nextPageToken" => nextPageToken}} ->
        list(language, view, nextPageToken, acc ++ intents)

      {:ok, %{"intents" => intents}} ->
        {:ok, acc ++ intents}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Lista los de intents de un agente por pageToken y definiendo tamaño de pagina.
  """
  @spec list_by_page(String.t(), String.t(), integer, String.t() | nil) :: tuple
  def list_by_page(
        language \\ "es",
        view \\ "INTENT_VIEW_UNSPECIFIED",
        pageSize \\ 100,
        token \\ nil
      ) do
    url =
      "intents?languageCode=#{language}&intentView=#{view}&" <>
        "pageSize=#{pageSize}&pageToken=#{token}"

    Dialixir.request(:get, url, "")
  end

  @doc """
  Obtiene un intent buscando por id.
  """
  @spec get(String.t(), String.t(), String.t()) :: tuple
  def get(id, language \\ "es", view \\ "INTENT_VIEW_UNSPECIFIED") do
    url = "intents/#{id}?languageCode=#{language}&intentView=#{view}"

    Dialixir.request(:get, url, "")
  end
end
