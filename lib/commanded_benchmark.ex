defmodule CommandedBenchmark < Application do
  def start(_type, _args) do
    Supervisor.start_link(children(), opts())
  end

  defp children do
    []
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: CommandedBenchmark.Supervisor
    ]
  end
end
