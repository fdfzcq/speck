defmodule Speck.Runner.Checker do

  def check(result, expected) when is_list(expected), do: check(result, expected, false)
  def check(result, :atom), do: is_atom(result)
  def check(result, :float), do: is_float(result)
  def check(result, :int), do: is_integer(result)
  def check(result, :integer), do: check(result, :int)
  def check(result, :neg_integer), do: is_integer(result) && result < 0
  def check(result, :non_neg_integer), do: is_integer(result) && result >= 0
  def check(result, :binary), do: is_binary(result)
  def check(result, :boolean), do: is_boolean(result)
  def check(result, :byte), do: is_integer(result) && result >= 0 && result <= 255
  def check(result, :char), do: is_integer(result) && result >= 0 && result <= 127
  def check(result, :charlist), do: is_list(result)
  def check(result, :nil), do: result == nil
  def check(result, :number), do: check(result, :float) || check(result, :integer)
  def check(result, type), do: result == type

  defp check(result, [], res), do: res
  defp check(_, _, true), do: true
  defp check(result, [type|t], false), do: check(result, t, check(result, type))
end
