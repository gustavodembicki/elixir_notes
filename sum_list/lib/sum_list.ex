defmodule SumList do
  def call(list), do: sum(list, 0)

  # def call_enum(list), do: Enum.sum(list)
  # def call_enum(list), do: Enum.map(list, fn element -> element end)
  # def call_enum(list), do: Enum.map(list, fn {chave, valor} -> {chave, valor} end)

  defp sum([], acc), do: acc

  defp sum([hd | tl], acc) do
    acc = acc + hd
    sum(tl, acc)
  end
end
