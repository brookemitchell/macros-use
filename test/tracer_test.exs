defmodule TracerTest do
  use ExUnit.Case
  use Tracer

  import ExUnit.CaptureIO

  def adds_posi_nums(a, b) when a > 0, do: a + b
  def puts_sum_3(a, b, c), do: a + b + c
  def add_list(list), do: Enum.reduce(list, 0, &(&1 + &2))

  test "adds posi num" do
    assert with_io(fn ->
             adds_posi_nums(1, 2)
           end) == {3, "==> call    adds_posi_nums(1, 2)\n<== result: 3\n"}
  end

  test "puts sum 3" do
    assert with_io(fn ->
             puts_sum_3(1, 2, 3)
           end) == {6, "==> call    puts_sum_3(1, 2, 3)\n<== result: 6\n"}
  end

  test "add list" do
    assert with_io(fn ->
             add_list([1, 2, 3])
           end) == {6, "==> call    add_list([1, 2, 3])\n<== result: 6\n"}
  end
end
