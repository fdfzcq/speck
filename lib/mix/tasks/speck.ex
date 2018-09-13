defmodule Mix.Tasks.Speck do
  defmodule Test do
    use Mix.Task

    def run(args) do
      Speck.process(args)
    end
  end
end
