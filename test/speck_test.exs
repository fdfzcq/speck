defmodule SpeckTest do
  use ExUnit.Case
  doctest Speck

  test "greets the world" do
    assert Speck.hello() == :world
  end
end
