defmodule Speck do
  @moduledoc """
  """
  alias Speck.FileReader
  alias Speck.Parser

  def generate_test_models(file_paths) do
    file_paths
    |> FileReader.read(file_paths)
    |> Enum.map(&Parser.parse/1)
  end
end
