defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account

  def create(%{account: account}) do
    %{
      message: "Created account!",
      data: data(account)
    }
  end

  def transaction(%{transaction: %{deposit: deposit_infos, withdraw: withdraw_infos}}) do
    %{
      message: "Succesfull transaction from!",
      from_account: data(deposit_infos),
      to_account: data(withdraw_infos)
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      balance: account.balance,
      user_id: account.user_id
    }
  end
end
