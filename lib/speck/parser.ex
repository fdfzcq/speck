defmodule Speck.Parser do
  @moduledoc """
  
  """
  alias Speck.Parser.ModuleParser

  defstruct(
    code_str: nil,
    modules: []
  )

  def parse(code_str), do: code_str
    |> init()
    |> to_abstract()
    |> get_abs_modules()
    

  defp init(code_str), do: %__MODULE__{code_str: code_str}

  defp to_abstract(state = %{code_str: code_str}), do: {state, Code.string_to_quoted!(code_str)}

  defp get_abs_modules({state, abstract}) do
    modules = abstract
    |> extract_abstract()
    |> Enum.map(&ModuleParser.parse/1)
    %{state|modules: modules}
  end

  defp extract_abstract({:__block__, [], abs_modules}), do: abs_modules
  defp extract_abstract(module), do: [module]
end