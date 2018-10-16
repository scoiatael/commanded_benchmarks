defmodule Util.Combinators do
  def then(a, b) do
    fn data -> b.(a.(data)) end
  end

  def a ~> b, do: a |> then(b)
end
