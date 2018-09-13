defmodule Speck.Runner do
  alias Speck.Runner.Report

  def run(tests_specs) when is_list(tests_specs), do:
    tests_specs
    |> Enum.map(&run/1)

  def run(%{module: module, function: function, inputs: inputs, expected: expected}), do:
    inputs
    |> Enum.map(&Report.run(module, function, &1, expected))
end
