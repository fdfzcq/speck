defmodule Speck.Generator.Type do
  alias Speck.Generator.Type.PrimitiveType
  def generate(type) do
    case PrimitiveType.is_primitive?(type) do
      true -> PrimitiveType.generate(type)
      false -> nil # not supported yet, ExtendedType.generate(type) to be added
    end
  end

  defmodule PrimitiveType do
    use Bitwise
    # can be simply generated without considering the impact
    @simple_primitive [:atom, :float, :int, :integer, :neg_integer, :non_neg_integer,
      :binary, :boolean, :byte, :char, :charlist, :nil, :number]
    # referenced, randomly generated following types may lead to unexpected results
    @special_primitive [:pid, :port, :fun, :function, :reference, :identifier, :module]
    # data type composed from other prim types
    @combined_primitive [:map, :struct, :tuple, :list, :nonempty_list, :any, :term, :keyword]

    def is_primitive?(type), do:
      @simple_primitive
      |> Kernel.++(@special_primitive)
      |> Kernel.++(@combined_primitive)
      |> Enum.member?(type)

    def generate(:any) do
      type_index = random_number(Enum.count(@simple_primitive) - 1)
      type = Enum.at(@simple_primitive, type_index)
      generate(type)
    end

    def generate(:atom) do
      no_of_atoms = :erlang.system_info(:atom_count)
      atom_index = random_number(no_of_atoms)
      :erlang.binary_to_term(<<131,75,atom_index::24>>)
    end

    def generate(:int) do
      random_neg_integer = generate(:neg_integer)
      random_non_neg_integer = generate(:non_neg_integer)
      random_factor = trunc(:rand.uniform() / 0.5)
      inv_random_factor = random_factor ^^^ 1
      random_factor * random_neg_integer + inv_random_factor * random_non_neg_integer
    end
    def generate(:integer), do: generate(:int)
    def generate(:neg_integer), do: generate_neg_integer()
    def generate_neg_integer(upbound \\ 1000), do: 0 - random_number(upbound)
    def generate(:non_neg_integer), do: generate_non_neg_integer()
    def generate_non_neg_integer(upbound \\ 1000), do: trunc(random_number(upbound * upbound)/upbound)

    def generate(:boolean) do
      case trunc(:rand.uniform() / 0.5) do
        1 -> true
        0 -> false
      end
    end

    def generate(:float) do
      random_int = generate(:int)
      random_int + :rand.uniform()
    end
    def generate(:number) do
      random_float = generate(:float)
      random_int = generate(:int)
      random_factor = trunc(:rand.uniform() / 0.5)
      inv_random_factor = random_factor ^^^ 1
      random_factor * random_float + inv_random_factor * random_int
    end

    def generate(:byte), do: generate_non_neg_integer(255)
    # 126 - 32 = 94
    def generate(:char), do: generate_non_neg_integer(94) + 32

    def generate(:charlist) do
      random_length = generate(:non_neg_integer)
      generate(:charlist, random_length, [])
    end
    def generate(:charlist, 0, charlist), do: charlist
    def generate(:charlist, random_length, charlist), do:
      generate(:charlist, random_length - 1, [generate(:char)|charlist])

    def generate(:binary), do: List.to_string(generate(:charlist))

    def generate(:nil), do: nil

    def random_number(seed), do: :rand.uniform(seed)
  end
end
