defmodule Dialixir do
  @moduledoc """
  Módulo para manejar la API de DialogFlow v2.
  """

  alias Goth.Token

  @spec request(atom, String.t(), String.t() | map) :: tuple
  def request(method, path, body) do
    %{id: id, client_email: email} = _project_info()

    url = "#{_host()}/v2/projects/#{id}/agent/#{path}"

    case HTTPoison.request(method, url, _body(body), _headers(email)) do
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

  # ---------------------------------------------------------------------------
  # Obtine el host de Dialogflow API
  # ---------------------------------------------------------------------------
  @spec _host :: String.t()
  defp _host(), do: Application.get_env(:dialixir, :host)

  # ---------------------------------------------------------------------------
  # Headers de la petición.
  # ---------------------------------------------------------------------------
  @spec _headers(String.t()) :: list
  defp _headers(email) do
    IO.inspect(Token.for_scope({email, "https://www.googleapis.com/auth/cloud-platform"}))
    {:ok, token} = Token.for_scope({email, "https://www.googleapis.com/auth/cloud-platform"})

    [
      {"Authorization", "Bearer #{token.token}"},
      {"Content-Type", "application/json"}
    ]
  end

  # ---------------------------------------------------------------------------
  # Obtiene el id y email de un proyecto de dialogflow.
  # ---------------------------------------------------------------------------
  @spec _project_info :: map
  defp _project_info do
    # TODO: remove secrets from here
    %{id: "ariel-lgxg", client_email: "info@botcity.com.do"}
  end
end
