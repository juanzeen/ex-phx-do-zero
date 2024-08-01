defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase
  alias BananaBank.Users
  import Mox

  setup do
    params = %{
      "name" => "Juan Cristo",
      "cep" => "28016811",
      "email" => "juanhygino@gmail.com",
      "password" => "12345678"
    }

    body = %{
      "bairro" => "Parque Califórnia",
      "cep" => "28016-811",
      "complemento" => "até 755 - lado ímpar",
      "ddd" => "22",
      "gia" => "",
      "ibge" => "3301009",
      "localidade" => "Campos dos Goytacazes",
      "logradouro" => "Avenida Alberto Lamego",
      "siafi" => "5819",
      "uf" => "RJ",
      "unidade" => ""
    }

    {:ok, params: params, body: body}
  end

  describe "create/2" do
    test "succesfully creates an user", %{conn: conn, params: params, body: body} do
      expect(BananaBank.ViaCep.ClientMock, :call, fn "28016811" ->
        {:ok, body}
      end)

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
      wrong_params = %{
        name: "Ju",
        cep: "0123",
        email: "juanhygino@gmail.com",
        password: "32"
      }

      expect(BananaBank.ViaCep.ClientMock, :call, fn "0123" ->
        {:ok, ""}
      end)

      response =
        conn
        |> post(~p"/api/users", wrong_params)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "name" => ["should be at least 3 character(s)"],
          "password" => ["should be at least 6 character(s)"],
          "cep" => ["should be 8 character(s)"]
        }
      }

      assert expected_response == response
    end
  end

  describe "delete/2" do
    test "succesfully deletes an user", %{conn: conn, params: params, body: body} do
      expect(BananaBank.ViaCep.ClientMock, :call, fn "28016811" ->
        {:ok, body}
      end)

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
