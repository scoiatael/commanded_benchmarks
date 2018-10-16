defmodule BankAccount do
  defstruct [:account_number, :balance]

  # OpenBankAccount command
  def execute(%BankAccount{account_number: nil}, %OpenBankAccount{
        account_number: account_number,
        initial_balance: initial_balance
      })
      when initial_balance > 0 do
    %BankAccountOpened{account_number: account_number, initial_balance: initial_balance}
  end

  # ensure initial balance is never zero or negative
  def execute(%BankAccount{}, %OpenBankAccount{initial_balance: initial_balance})
      when initial_balance <= 0 do
    {:error, :initial_balance_must_be_above_zero}
  end

  # ensure account has not already been opened
  def execute(%BankAccount{}, %OpenBankAccount{}) do
    {:error, :account_already_opened}
  end

  # CheckAccount command

  def execute(%BankAccount{account_number: nil}, %CheckAccount{}) do
    {:error, :account_not_opened}
  end

  def execute(%BankAccount{account_number: account_number}, %CheckAccount{
        account_number: account_number
      }) do
    []
  end

  # CloseAccount command

  def execute(%BankAccount{account_number: nil}, %CloseAccount{}) do
    {:error, :account_not_opened}
  end

  def execute(%BankAccount{account_number: account_number}, %CloseAccount{
        account_number: account_number
      }) do
    %BankAccountClosed{account_number: account_number}
  end

  # state mutators

  def apply(%BankAccount{} = account, %BankAccountOpened{
        account_number: account_number,
        initial_balance: initial_balance
      }) do
    %BankAccount{account | account_number: account_number, balance: initial_balance}
  end

  def apply(%BankAccount{account_number: account_number} = account, %BankAccountClosed{account_number: account_number}) do
    %BankAccount{account | account_number: nil}
  end
end
