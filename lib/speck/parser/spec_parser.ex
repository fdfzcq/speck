defmodule Speck.Parser.SpecParser do
  defstruct(
    function: nil,
    arguments: [],
    returns: []
  )

  def new(), do: %__MODULE__{}

  def parse([{:::, _, spec_attributes}]), do:
  	parse_attributes(spec_attributes, new())

  defp parse_attributes([return], specs), do: %{specs|returns: parse_returns(return, [])}
  defp parse_attributes([h|t], specs), do:
  	parse_attributes(t, parse_attribute(h, specs))

  defp parse_attribute({func_name, _, args}, state), do: parse_attribute(args, %{state|function: func_name})
  defp parse_attribute(args, state) when is_list(args), do:
  	%{state|arguments: parse_args(args, [])}

  defp parse_args([], l), do: :lists.reverse(l)
  defp parse_args([{:::, _, arg_spec}|t], l), do:
    parse_args(t, [get_type(arg_spec)|l])
  defp parse_args([h|t], l), do:
    parse_args(t, [get_type(h)|l])

  defp get_type([_|[spec]]), do: get_type(spec)
  defp get_type([spec]), do: get_type(spec)
  defp get_type({type, _, _}), do: type

  defp parse_returns({type, _, _}, l), do: [type|l]
  defp parse_returns([], l), do: :lists.reverse(l)
  defp parse_returns([{:|, _, returns}|t], l), do:
    parse_returns(t, [parse_returns(returns, [])|l])
  defp parse_returns([return|t], l), do:
    parse_returns(t, [return|l])
  defp parse_returns(r, l), do: [r|l]
end
