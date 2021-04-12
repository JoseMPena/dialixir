defmodule DialixirTest do
  use ExUnit.Case
  doctest Dialixir

  test "greets the world" do
    assert Dialixir.hello() == :world
  end
end
