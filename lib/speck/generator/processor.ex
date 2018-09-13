defmodule Speck.Generator.Processor do
  alias Speck.Generator.TestGenerator

  def generate(%{functions: []}), do: []
  def generate(st = %{name: name, functions: function_specs}) do
    module_name =
      try do
        String.to_existing_atom("Elixir." <> name)
      catch _,_ -> String.to_atom("Elixir." <> name)
      end
    Enum.map(function_specs, &TestGenerator.generate(&1, module_name))
  end
end
