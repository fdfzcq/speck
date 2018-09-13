defmodule Example.A do
  alias Logger
  defmodule Foo do
    @spec func(a :: integer, b :: integer) :: integer
    def func(a, b), do: a + b

    @spec func2(test :: boolean) :: boolean
    def func2(true), do: true
    def func2(false), do: false
  end
end
defmodule ExampleB do
  @spec func(t :: any) :: :ok
  def func(t), do: :ok

  @spec func2(t :: integer, d :: integer) :: nil
  def func2(t, d), do: nil
end
