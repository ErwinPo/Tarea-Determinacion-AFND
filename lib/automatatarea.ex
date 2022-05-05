defmodule Automatatarea do

  def power([head | tail]) do
    pt = power(tail)
    power(head, pt, pt)
  end
  def power([]), do: [[]]
  defp power(x, [head | tail], accumulator), do: power(x, tail, [[x | head] | accumulator])
  defp power(_, [], accumulator), do: accumulator

  def determinize(auto) do
    finalstates = power(auto.states)
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

  def eclosure(delta, r, v) do
    Enum.reduce(Map.get(delta, {r, nil}, []), v, fn q, vp->
      if q not in vp, do: eclosure(delta, q, [q | vp]), else: vp end)
  end
  def eclosure(auto, x) do
    Enum.reduce(x, [], fn fun, v -> eclosure(auto.delta, fun, [fun|v])end)
    |> Enum.uniq
    |> Enum.sort
  end
end
