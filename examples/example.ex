defmodule Example.A do
  alias Logger
  defmodule Foo do
    @spec func(a() :: int(), b :: int()) :: int()|nil|true
    def func(a, 0), do: nil
    def func(a, b), do: a + b
  end
end
defmodule ExampleB do
  @spec func(t() :: any()) :: :ok
  def func(t), do: :ok
end
