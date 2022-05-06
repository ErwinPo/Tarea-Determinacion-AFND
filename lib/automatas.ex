defmodule Automatas do

  def nfa1 do
    %{
      states: [P0,P1,P2,P3],
      sigma: [?a, ?b],
      q0: P0,
      final: [P3],
      delta: %{
        {P0, ?a} => [P0, P1],
        {P0, ?b} => [P0],
        {P1, ?b} => [P2],
        {P2, ?b} => [P3],
      }
    }
  end

  def nfa2 do
    %{
      states: [P0, P1, P2, P3, P4],
      sigma: [?a, ?b, ?e],
      q0: P0,
      final: [P4],
      delta: %{
        {P0, ?e} => [P1],
        {P0, ?b} => [P2],
        {P1, ?e} => [P3],
        {P2, ?e} => [P4],
        {P3, ?a} => [P4]
      }
    }
  end



end
