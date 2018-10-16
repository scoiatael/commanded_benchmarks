defmodule Util.Concurrently do
  def concurrent_map(fun) do
    fn (data) ->
      data |> Flow.from_enumerable() |> Flow.map(fun) |> Enum.to_list()
    end
  end
end
