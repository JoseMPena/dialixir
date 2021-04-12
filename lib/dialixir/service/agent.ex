defmodule Dialixir.Service.Agent do
  @moduledoc """
  Helper para información del agente.
  """

  alias Dialixir

  @doc """
  Obtiene el agente al que está asociado el projecto.
  """
  @spec get() :: tuple
  def get do
    Dialixir.request(:get, "", "")
  end
end
