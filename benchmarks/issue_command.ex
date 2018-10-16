import Util.{Reset, Rename, Combinators, Concurrently}

conn = conn!()

inputs = %{
  "Small (100)" => Enum.to_list(1..100),
  "Middle (1k)" => Enum.to_list(1..1_000),
  "Big (10k)" => Enum.to_list(1..10_000)
}

dispatch = fn i ->
  BankRouter.dispatch(%OpenBankAccount{account_number: i, initial_balance: 100})
end

Benchee.run(
  %{
    "sequentially" => fn list -> Enum.each(list, dispatch) end,
    "concurrently" => concurrent_map(dispatch),
    "no-op" => concurrent_map(fn _ -> Process.sleep(5) end)
  },
  time: 10,
  inputs: inputs,
  before_scenario: do_reset!(conn) ~> do_rename()
)

do_reset!(conn).([])
