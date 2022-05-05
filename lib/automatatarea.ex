defmodule Automatatarea do

  def cross(%{:states => estados1}, %{:states => [primer|resto]}) do
    Enum.map(estados1, fn estado -> [estado,primer] end) ++ cross(estados1,resto)
  end
  def cross(_, []), do: []
  def cross(estados1, [primer|resto]) do
    Enum.map(estados1, fn estado -> [estado,primer] end) ++ cross(estados1,resto)
  end

  defp keys(estados, %{:alphabet => [primer|resto]}) do
    Enum.map(estados, fn estado -> estado ++ [primer] end) ++ keys(estados, resto)
  end
  defp keys(_, []), do: []
  defp keys(estados, [primer|resto]) do
    Enum.map(estados, fn estado ->  estado ++ [primer] end) ++ keys(estados, resto)
  end

  def delta(automata1, automata2) do
    deltamap = Map.new()
    keys(cross(automata1, automata2), automata1)
    |> Enum.map(
      fn [estado1, estado2, clave] ->
        Map.put(deltamap, {[estado1, estado2], clave},
        Map.get(automata1.transitions, {estado1, clave}) ++ Map.get(automata2.transitions, {estado2, clave}))
      end)
    |> merge()
  end

  defp merge([]), do: Map.new()
  defp merge([primer|resto]) do
    Map.merge(primer, merge(resto))
  end

  def final(automata1, automata2) do
    delta(automata1, automata2)
    |> Enum.filter(fn {_,[final1,final2]} -> final1 == Enum.at(automata1.accept, 0) or final2 == Enum.at(automata2.accept, 0) end)
    |> Enum.map(fn {_,[final1,final2]} -> [final1,final2] end)
  end

  def union(automata1, automata2) do
    %{
    states: cross(automata1, automata2),
    alphabet: automata1.alphabet,
    transitions: delta(automata1, automata2),
    start: [automata1.start, automata2.start],
    accept: final(automata1, automata2)
    }
  end

  def prune(automata) do
    inicio = automata.start
    delta = validT(automata, inicio, [], Map.new())
    |> List.flatten()
    |> merge()

    estados = Enum.map(delta, fn {{state1, _}, state2}-> [state1] ++ [state2] end)
    |> List.flatten()
    |> Enum.chunk_every(2)
    |> Enum.uniq()
    |> Enum.sort()

    finales = Enum.filter(automata.accept, fn final -> final in estados end)
    |> Enum.uniq()

    %{%{%{automata|transitions: delta}|states: estados}|accept: finales}
  end

  def validT(automata, current, visited, delta) do
    visited = visited ++ [current]
    automata.transitions
    |> Enum.filter(fn {{child, _}, _} -> child == current end)
    |> Enum.map(fn {{current, simbolo}, susesor} ->
      if(susesor not in visited) do
        validT(automata, susesor, visited, Map.put(delta, {current, simbolo}, susesor))
      else
        Map.put(delta, {current, simbolo}, susesor)
      end
    end)
  end

  def determinize(_auto) do

  end

end
