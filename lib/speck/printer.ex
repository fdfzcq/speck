defmodule Speck.Printer do
  def print(report = %{success: true}) do
    args = report.arg
      |> Enum.map(&add_quotes/1)
      |> Enum.join(", ")
    log = "#{report.module}.#{report.function}(#{args}) passed"
    Bunt.puts([:green, log])
  end

  def print(report = %{success: false}) do
    args = Enum.join(report.arg, ", ")
    expected = Enum.join(report.expected, "|")
    log = "#{report.module}.#{report.function}(#{args}) failed with result #{report.result} expected result to be (#{expected})"
    Bunt.puts([:red, log])
  end

  defp add_quotes(arg) do
    case is_binary(arg) do
      true -> "\"" <> arg <> "\""
      false -> arg
    end
  end
end
