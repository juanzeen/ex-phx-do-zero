defmodule BananaBankWeb.WelcomeController do
  use BananaBankWeb, :controller

  def index(conn, _params) do
    conn
    # mesma coisa que HTTP 200
    |> put_status(:ok)
    |> json(%{message: "testando o json", status: :ok})
  end
end
