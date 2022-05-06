defmodule AutomatatareaTest do
  use ExUnit.Case
  doctest Automatatarea

  test "determinize" do
    assert Automatatarea.determinize(Automatas.nfa1) == %{
    delta: %{
      {[], 97} => [],
      {[], 98} => [],
      {[P0], 97} => [P0, P1],
      {[P0], 98} => [P0],
      {[P0, P1], 97} => [P0, P1],
      {[P0, P1], 98} => [P0, P2],
      {[P0, P1, P2], 97} => [P0, P1],
      {[P0, P1, P2], 98} => [P0, P2, P3],
      {[P0, P1, P2, P3], 97} => [P0, P1],
      {[P0, P1, P2, P3], 98} => [P0, P2, P3],
      {[P0, P1, P3], 97} => [P0, P1],
      {[P0, P1, P3], 98} => [P0, P2],
      {[P0, P2], 97} => [P0, P1],
      {[P0, P2], 98} => [P0, P3],
      {[P0, P2, P3], 97} => [P0, P1],
      {[P0, P2, P3], 98} => [P0, P3],
      {[P0, P3], 97} => [P0, P1],
      {[P0, P3], 98} => [P0],
      {[P1], 97} => [],
      {[P1], 98} => [P2],
      {[P1, P2], 97} => [],
      {[P1, P2], 98} => [P2, P3],
      {[P1, P2, P3], 97} => [],
      {[P1, P2, P3], 98} => [P2, P3],
      {[P1, P3], 97} => [],
      {[P1, P3], 98} => [P2],
      {[P2], 97} => [],
      {[P2], 98} => [P3],
      {[P2, P3], 97} => [],
      {[P2, P3], 98} => [P3],
      {[P3], 97} => [],
      {[P3], 98} => []
    },
    final: [
      [P0, P3],
      [P0, P2, P3],
      [P0, P1, P2, P3],
      [P0, P1, P3],
      [P1, P3],
      [P1, P2, P3],
      [P2, P3],
      [P3]
    ],
    q0: [P0],
    sigma: 'ab',
    states: [
      [P0],
      [P0, P3],
      [P0, P2, P3],
      [P0, P2],
      [P0, P1, P2],
      [P0, P1, P2, P3],
      [P0, P1, P3],
      [P0, P1],
      [P1],
      [P1, P3],
      [P1, P2, P3],
      [P1, P2],
      [P2],
      [P2, P3],
      [P3],
      []
    ]
    }
  end


  test "e_closure" do
    assert Automatatarea.eclosure(Automatas.nfa2,[P0]) == [P0, P1, P3]
    assert Automatatarea.eclosure(Automatas.nfa2,[P1]) == [P1, P3]
    assert Automatatarea.eclosure(Automatas.nfa2,[P2]) == [P2, P4]
  end

  test "e_determinize" do
    assert Automatatarea.e_determinize(Automatas.nfa3,Automatas.nfa3.q0,{[], %{}}) == {[
      [P1, P2, P3, P5, P6, P7],
      [P1, P10, P2, P3, P5, P6, P7],
      [P1, P2, P3, P5, P6, P7, P9],
      [P1, P2, P3, P4, P6, P7, P8],
      [P0]
    ],
    %{
      {[P0], 97} => [P1, P2, P3, P4, P6, P7, P8],
      {[P0], 98} => [P1, P2, P3, P5, P6, P7],
      {[P1, P10, P2, P3, P5, P6, P7], 97} => [P1, P2, P3, P4, P6, P7, P8],
      {[P1, P10, P2, P3, P5, P6, P7], 98} => [P1, P2, P3, P5, P6, P7],
      {[P1, P2, P3, P4, P6, P7, P8], 97} => [P1, P2, P3, P4, P6, P7, P8],
      {[P1, P2, P3, P4, P6, P7, P8], 98} => [P1, P2, P3, P5, P6, P7, P9],
      {[P1, P2, P3, P5, P6, P7], 97} => [P1, P2, P3, P4, P6, P7, P8],
      {[P1, P2, P3, P5, P6, P7], 98} => [P1, P2, P3, P5, P6, P7],
      {[P1, P2, P3, P5, P6, P7, P9], 97} => [P1, P2, P3, P4, P6, P7, P8],
      {[P1, P2, P3, P5, P6, P7, P9], 98} => [P1, P10, P2, P3, P5, P6, P7]
    }}
  end
end
