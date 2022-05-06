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

  def nfa3 do
    %{
      states: [P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10],
      sigma: [?a, ?b],
      q0: [P0],
      final: P10,
      delta: %{
        {P0, nil} => [P1,P7],
        {P1, nil} => [P2,P3],
        {P2, ?a} => [P4],
        {P3, ?b} => [P5],
        {P4, nil} => [P6],
        {P5, nil} => [P6],
        {P6, nil} => [P1,P7],
        {P7, ?a} => [P8],
        {P8, ?b} => [P9],
        {P9, ?b} => [P10]
      }
    }
  end



end
