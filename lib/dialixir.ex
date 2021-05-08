defmodule Dialixir do
  @moduledoc """
  Módulo para manejar la API de DialogFlow v2.
  """

  @spec request(atom, String.t(), String.t() | map) :: tuple
  def request(method, path, body) do
    url = "https://dialogflow.googleapis.com/v2/projects/#{_project_id()}/agent/#{path}"

    case HTTPoison.request(method, url, _body(body), _headers()) do
      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status in 200..299 ->
        {:ok, Poison.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status in 400..499 ->
        {:error, Poison.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: status, body: body}} when status >= 500 ->
        {:error, Poison.decode!(body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, Poison.decode!(reason)}
    end
  end

  # ---------------------------------------------------------------------------
  # Encode body
  # ---------------------------------------------------------------------------
  @spec _body(String.t() | map) :: String.t()
  defp _body(""), do: ""
  defp _body(body), do: Poison.encode!(body)

  @spec _headers() :: list
  defp _headers do
    {:ok, token} = Goth.fetch(Dialixir.Goth)

    [
      {"Authorization", "Bearer #{token.token}"},
      {"Content-Type", "application/json"}
    ]
  end

  @spec _project_id :: String.t()
  defp _project_id(), do: Application.get_env(:dialixir, :project_id)
end
