defmodule BankRouter do
  use Commanded.Commands.Router

  dispatch OpenBankAccount, to: BankAccount, identity: :account_number
  dispatch CheckAccount, to: BankAccount, identity: :account_number
  dispatch CloseAccount, to: BankAccount, identity: :account_number
end
