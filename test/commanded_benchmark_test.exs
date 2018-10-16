defmodule CommandedBenchmarkTest do
  use ExUnit.Case
  doctest CommandedBenchmark

  test "greets the world" do
    assert CommandedBenchmark.hello() == :world
  end
end
