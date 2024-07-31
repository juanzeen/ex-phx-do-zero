defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase
  alias BananaBank.Users

  describe "create/2" do
    test "succesfully creates an user", %{conn: conn} do
      params = %{
        name: "Juan Cristo",
        cep: "28016811",
        email: "juanhygino@gmail.com",
        password: "12345678"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "cep" => "28016811",
                 "email" => "juanhygino@gmail.com",
                 "id" => _id,
                 "name" => "Juan Cristo"
               },
               "message" => "Created user!"
             } = response
    end

    test "when we have incorrects params, a error must be launched", %{conn: conn} do
      params = %{
        name: "Ju",
        cep: "0123",
        email: "juanhygino@gmail.com",
        password: "32"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{
        "name" => "[should be at least 3 character(s)]",
        "password" => "[should be at least 6 character(s)]",
        "cep" => "[should be 8 character(s)]"
      }
    }

      assert expected_response = response
    end
  end

  describe "delete/2" do
    test "succesfully deletes an user", %{conn: conn} do
      params = %{
        name: "Juan Cristo",
        cep: "28016811",
        email: "juanhygino@gmail.com",
        password: "12345678"
      }

      {:ok, user} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{user.id}", params)
        |> json_response(:ok)

      expected_response = %{"data" => %{"name" => "Juan Cristo"}, "message" => "User deleted!!"}

      assert expected_response == response
    end
  end
end
