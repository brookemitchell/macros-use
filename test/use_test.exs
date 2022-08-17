defmodule UseTest do
  use ExUnit.Case
  doctest Use

  test "greets the world" do
    assert Use.hello() == :world
  end
end
