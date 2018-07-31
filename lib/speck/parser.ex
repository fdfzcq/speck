defmodule Speck.Parser do
  @moduledoc """
  
  """
  alias Speck.Parser.ModuleParser
  alias Speck.Parser.FunctionParser

  defstruct(
    code_str: nil,
    modules: []
  )

  def parse(code_str), do: code_str
    |> init()
    |> to_abstract()
    |> get_abs_modules()
    |> Enum.map(&ModuleParser.parse)
    # TBC

  defp init(code_str), do: %__MODULE__{code_str: code_str}

  defp to_abstract(state = %{code_str: code_str}), do: {state, Code.string_to_quoted!(code_str)}

  defp get_abs_modules({state, abstract}) do
    {:__block__, [], abs_modules} = abstract
    abs_modules
  end
end