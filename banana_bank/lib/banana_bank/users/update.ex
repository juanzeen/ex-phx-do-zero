defmodule BananaBank.Users.Update do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> update_user(user, params)
    end
  end

  def update_user(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
