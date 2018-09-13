defmodule Speck.Generator do
  alias Speck.Generator.Processor

  def generate(module_spec = %{nested_modules: []}), do: Processor.generate(module_spec)
  def generate(module_spec), do:
    List.flatten([generate(%{module_spec|nested_modules: []})|generate(module_spec.nested_modules, module_spec.name)])

  defp generate(nested_module_specs, parent_module_name), do:
    nested_module_specs
    |> Enum.map(&annotate_parent_module_name(&1, parent_module_name))
    |> Enum.map(&generate/1)
    |> List.flatten()

  defp annotate_parent_module_name(module_spec = %{name: name}, parent_module_name) do
    new_name = parent_module_name <> "." <> name
    %{module_spec|name: new_name}
  end

end
