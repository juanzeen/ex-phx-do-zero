defmodule BananaBank.Users.Verify do
  alias BananaBank.Users

  def call(%{"id" => id, "password" => password}) do
    case Users.get(id) do
      {:ok, user} -> verify(password, user.password_hash)
      {:error, _message} = error -> error
    end
  end

  defp verify(password, hash) do
    case Argon2.verify_pass(password, hash) do
      true -> {:ok, :valid_passord}
      false -> {:error, :invalid_passord}
    end
  end
end
