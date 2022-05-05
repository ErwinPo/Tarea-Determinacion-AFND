defmodule Automatas do

  def nfa1 do
    %{
      states: [P0,P1,P2,P3],
      q0: P0,
      final: [P3],
      sigma: [?a, ?b],
      delta: %{
        {P0, "a"} => [P0, P1],
        {P0, "b"} => [P0],
        {P1, "a"} => [],
        {P1, "b"} => [P2],
        {P2, "a"} => [],
        {P2, "b"} => [P3],
        {P3, "a"} => [],
        {P3, "b"} => [],
      }
    }
  end

  def as do
    %{
      q0: 0,
      f: [3],
      delta: %{
        {0, ?a} => [1, 0],
        {0, ?b} => [0],
        {1, ?b} => [2],
        {2, ?b} => [3]
      }
    }
  end

end
