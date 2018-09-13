defmodule Speck.Generator.TestGenerator do
  alias Speck.Generator.Type
  defstruct(
    module: nil,
    function: nil,
    inputs: [],
    expected: []
  )

  def generate(%{function: func, arguments: argument_spec, returns: res_spec}, module_name) do
    generated_args = generate_inputs(argument_spec)
    %__MODULE__{function: func, inputs: generated_args, expected: res_spec, module: module_name}
  end

  defp generate_inputs(argument_spec), do:
    argument_spec
    |> Enum.reduce(empty_inputs(), &generate_input/2)

  defp generate_input(type, inputs), do: generate_input(type, inputs, [], [])

  defp generate_input(_, [], _, generated_inputs), do: generated_inputs
    |> Enum.map(&:lists.reverse/1)
    |> dedup([])
  defp generate_input(type, [h|t], generated_values, generated_inputs) do
    input = generate_from_type(type, generated_values)
    generate_input(type, t, [input|generated_values], [[input|h]|generated_inputs])
  end

  defp generate_from_type(type, generated_values) do
    generated = Type.generate(type)
    case Enum.member?(generated_values, generated) && type != :boolean && type != nil do
      true -> generate_from_type(type, generated_values)
      false -> generated
    end
  end

  defp empty_inputs(), do: empty_inputs(num_to_generate(), [])

  defp empty_inputs(0, l), do: l
  defp empty_inputs(n, l), do: empty_inputs(n - 1, [[]|l])

  defp dedup([], l), do: l
  defp dedup([h|t], l) do
    case Enum.member?(l, h) do
      true -> dedup(t, l)
      false -> dedup(t, [h|l])
    end
  end

  defp num_to_generate(), do: Application.get_env(:speck, :num_to_generate, 10)
end
