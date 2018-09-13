defmodule Speck do
  @moduledoc """
  """
  alias Speck.FileReader
  alias Speck.Parser
  alias Speck.Generator
  alias Speck.Runner
  alias Speck.Printer

  def process([]), do: process(Utils.Finder.find_all("./"))
  def process(args) do
    args
    |> Enum.map(&String.split(&1, ","))
    |> List.flatten()
    |> extract_module_spec()
    |> generate_tests()
    |> List.flatten()
    |> run_tests()
    |> print_report()
  end

  def extract_module_spec(file_paths) do
    file_paths
    |> FileReader.read()
    |> Enum.map(&Parser.parse/1)
  end

  def generate_tests(state), do:
    state
    |> Enum.map(&generate_test/1)

  defp generate_test(%{modules: module_specs}), do:
    module_specs
    |> Enum.map(&Generator.generate/1)

  defp run_tests(tests_specs), do:
    tests_specs
    |> Runner.run()
    |> List.flatten()

  defp print_report(report), do:
    report
    |> Enum.reduce(%{success: 0, failed: 0}, &Printer.print/2)
    |> Printer.print_summary()
end
