defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.Transaction
  alias BananaBank.Accounts.Create
  defdelegate create(params), to: Create, as: :call
  defdelegate transaction(transaction_map), to: Transaction, as: :call
end
