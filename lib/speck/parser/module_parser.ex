defmodule Speck.Parser.ModuleParser do
  alias Speck.Parser.SpecParser

  @type state() :: %__MODULE__{
    name:             nil|binary(),
    functions:        list(),
    nested_modules:   list()
  }

  defstruct(
    name: nil,
    functions: [],
    nested_modules: []
  )

  def new(), do: %__MODULE__{}

  @spec parse(module() :: list()) :: state()
  def parse({:defmodule, _, attributes}), do:
    parse_attributes(attributes, new())
  def parse(_), do: nil

  defp parse_attributes([], state), do: state
  defp parse_attributes([h|t], state), do: parse_attributes(t, parse_attribute(h, state))

  defp parse_attribute({:__aliases__, _, mod_names}, state), do:
    %{state|name: "Elixir." <> Enum.join(mod_names, ".")}
  defp parse_attribute([{:do, {:__block__, _, attributes}}], state), do:
    parse_attributes(attributes, state)
  defp parse_attribute({:@, _, [{:spec, _, spec_attributes}|_]}, state), do:
    %{state|functions: [SpecParser.parse(spec_attributes)|state.functions]}
  defp parse_attribute(mod = {:defmodule, _, _}, state), do:
    %{state|nested_modules: [parse(mod)|state.nested_modules]}
  defp parse_attribute(_, state), do: state

end
