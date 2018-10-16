import Util.{Reset, Rename, Combinators}

conn = conn!()

inputs = %{
  "Small (100)" => Enum.to_list(1..100),
  "Middle (1k)" => Enum.to_list(1..1_000),
  "Big (10k)" => Enum.to_list(1..10_000)
}

init = fn list ->
  Enum.map(
    list,
    fn i -> :ok = BankRouter.dispatch(%OpenBankAccount{account_number: i, initial_balance: 100}) end
  )

  list
end

dispatch_no_events = fn i ->
  BankRouter.dispatch(%CheckAccount{account_number: i})
end

dispatch_events = fn i ->
  BankRouter.dispatch(%CloseAccount{account_number: i})
end

Benchee.run(
  %{
    "without events" => fn list ->
      list |> Flow.from_enumerable() |> Flow.map(dispatch_no_events) |> Enum.to_list()
    end,
    "with events" => fn list ->
      list |> Flow.from_enumerable() |> Flow.map(dispatch_events) |> Enum.to_list()
    end
  },
  time: 40,
  inputs: inputs,
  before_scenario: do_reset!(conn) ~> do_rename() ~> init
)

do_reset!(conn).([])
