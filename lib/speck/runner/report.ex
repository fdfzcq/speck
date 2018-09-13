defmodule Speck.Runner.Report do
  alias Speck.Runner.Checker
  defstruct(
    success: nil,
    module: nil,
    function: nil,
    arg: [],
    expected: [],
    result: nil
  ) 

  def run(module, function, arg, expected) do
    %__MODULE__{module: module, function: function, arg: arg, expected: expected}
    |> run()
    |> check_result()
  end

  def run(state) do
    try do
      result = :erlang.apply(state.module, state.function, state.arg)
      %{state|success: true, result: result}
    rescue
      err -> result = "#{inspect err}"
             %{state|success: false, result: result}
    end
  end

  def check_result(state = %{success: true, result: result, expected: expected}) do
    case Checker.check(result, expected) do
      true -> state
      false -> %{state|success: false}
    end
  end
  def check_result(state), do: state
end
