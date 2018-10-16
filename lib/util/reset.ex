defmodule Util.Reset  do
  alias EventStore.{Config, Storage.Initializer}

  def conn! do
    {:ok, conn} = Config.parsed() |> Config.default_postgrex_opts() |> Postgrex.start_link()

    conn
  end

  def do_reset!(conn) do
    fn data ->
      Initializer.reset!(conn)
      data
    end
  end
end
