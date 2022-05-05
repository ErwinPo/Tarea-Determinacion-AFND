defmodule Automatatarea do

  def powerset([head | tail]) do
    pt = powerset(tail)
    powerset(head, pt, pt)
  end
  def powerset([]), do: [[]]
  defp powerset(x, [head | tail], accumulator), do: powerset(x, tail, [[x | head] | accumulator])
  defp powerset(_, [], accumulator), do: accumulator

  def determinize(auto) do
    finalstates = powerset(auto.states)
    sigma = auto.sigma
    delta = Enum.map(Automatas.nfa1.sigma, fn s -> Enum.map(finalstates, fn a -> {{a, s}, Enum.map(a, fn m -> auto.delta[{m, s}] end)
    |> List.flatten
    |> Enum.uniq
    |> Enum.filter(fn b -> b != nil end)} end) end)
    |> List.flatten()
    |> Map.new()

    qcero = [auto.q0]
    final = Enum.filter(finalstates, fn r -> Enum.any?(r, fn e -> e == P3 end) end)
    %{
      states: finalstates,
      sigma: sigma,
      delta: delta,
      q0: qcero,
      final: final
    }
  end
end
