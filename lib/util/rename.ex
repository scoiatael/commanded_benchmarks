defmodule Util.Rename do
  def do_rename() do
    fn (data) ->
      uuid = UUID.uuid4()

      Enum.map(data, fn d -> "#{uuid}/#{d}" end)
    end
  end
end
