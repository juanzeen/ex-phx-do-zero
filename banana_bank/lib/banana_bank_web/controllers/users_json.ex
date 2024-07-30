defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User
  def create(%{user: user}) do
    %{
      message: "Created user!",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: user}

  defp data(%User{} = user) do
    %{
      name: user.name,
      id: user.id,
      email: user.email,
      cep: user.cep
    }
  end
end