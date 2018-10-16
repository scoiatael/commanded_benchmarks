defmodule AccountBalanceHandler do
  use Commanded.Event.Handler, name: __MODULE__

  def init do
    with {:ok, _pid} <- Agent.start_link(fn -> %{} end, name: __MODULE__) do
      :ok
    end
  end

  def handle(%BankAccountOpened{account_number: account_number, initial_balance: initial_balance}, _metadata) do
    Agent.update(__MODULE__, &Map.put(&1, account_number, initial_balance))
  end

  def current_balance(account_number) do
    Agent.get(__MODULE__, &Map.get(&1, account_number))
  end
end
