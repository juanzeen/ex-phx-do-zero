defmodule BananaBankWeb.WelcomeController do
  use BananaBankWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok) #mesma coisa que HTTP 200
    |> json(%{message: "testando o json", status: :ok})
  end
end
