defmodule Speck.FileReader do
  @moduledoc """
  
  """

  def read(file_paths), do: read_files(file_paths, [])

  defp read_files([], l), do: l
  defp read_files([file_path|t], l), do: read_files(t, [read_file(file_path)|l])
  defp read_files(file_path, []), do: [read_file(file_path)]

  defp read_file(file_path), do: File.read!(file_path)
end
