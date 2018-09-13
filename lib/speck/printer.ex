defmodule Speck.Printer do
  def print(report = %{success: true}, sum = %{success: success}) do
    args = report.arg
      |> Enum.map(&add_quotes/1)
      |> Enum.join(", ")
    log = "#{report.module}.#{report.function}(#{args}) passed"
    Bunt.puts([:green, log])
    %{sum|success: success + 1}
  end

  def print(report = %{success: false}, sum = %{failed: failed}) do
    args = Enum.join(report.arg, ", ")
    expected = Enum.join(report.expected, "|")
    log = "#{report.module}.#{report.function}(#{args}) failed with result #{report.result} expected result to be (#{expected})"
    Bunt.puts([:red, log])
    %{sum|failed: failed + 1}
  end

  def print_summary(%{success: no_of_success, failed: no_of_failed}) do
    IO.puts ""
    Bunt.puts([:green, "success: #{no_of_success} ", :red, "failed: #{no_of_failed}"])
  end

  defp add_quotes(arg) do
    case is_binary(arg) do
      true -> "\"" <> arg <> "\""
      false -> arg
    end
  end
end
