defmodule Speck.Parser.ModuleParser do

  @type state() :: %__MODULE__{
    name:             nil|binary(),
    functions:        map(),
    nested_modules:   list()
  }

  defstruct(
    name: nil,
    functions: %{},
    nested_modules: []
  )

  def new(), do: %__MODULE__{}

  @spec parse(module() :: list()) :: state()
  def parse(module) do
    {:defmodule, _, attributes} = module
    parse_attributes(attributes, new())
  end

  defp parse_attributes([], state), do: state
  defp parse_attributes([h|t], state), do: parse_attributes(t, parse_attribute(h, state()))

  defp parse_attribute({:__aliases__, _, mod_names}, state), do:
    %{state|name: "Elixir." <> Enum.join(mod_names, ".")}
  defp parse_attribute([{:do, attributes}])

end
