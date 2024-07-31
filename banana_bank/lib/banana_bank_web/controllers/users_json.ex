defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User
  def create(%{user: user}) do
    %{
      message: "Created user!",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: user}
  def update(%{user: user}), do: %{data: user, message: "User updated!! "}

  defp data(%User{} = user) do
    %{
      name: user.name,
      id: user.id,
      email: user.email,
      cep: user.cep
    }
  end
end
