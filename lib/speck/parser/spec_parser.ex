defmodule SpecParser do
  defstruct(
    function: nil,
    arguments: [],
    returns: []
  )

  def new(), do: %__MODULE__{}

  def parse([{:::, _, spec_attributes}]), do: 
  	parse_attributes(spec_attributes, new())

  defp parse_attributes([], state), do: {state.function, {state.arguments, state.returns}}
  defp parse_attributes([h|t], state), do:
  	parse_attributes(t, parse_attribute(h, state))

  defp parse_attribute({func_name, _, args}, state), do: %{state|function: func_name}
  defp parse_attribute(args) when is_list(args), do:
  	%{state|arguments: parse_args(args)}
  defp parse_attribute(returns) when is_tuple(returns), do:
  	%{state|returns: parse_returns(returns)}

  # TODO: parse_args/1, parse_returns/1

end
