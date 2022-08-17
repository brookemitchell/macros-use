defmodule TracerTest do
  use ExUnit.Case
  import Kernel, except: [def: 2]
  import Tracer, only: [def: 2]

  import ExUnit.CaptureIO

  def puts_sum_3(a, b, c), do: a + b + c
  def add_list(list), do: Enum.reduce(list, 0, &(&1 + &2))

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
