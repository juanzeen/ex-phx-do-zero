defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true
  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "succesfully return cep info", %{bypass: bypass} do
      cep = "28016811"

      expected_response =
        {:ok,
         %{
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
         }}

      body = ~s({
        "bairro": "Parque Califórnia",
        "cep": "28016-811",
        "complemento": "até 755 - lado ímpar",
        "ddd": "22",
        "gia": "",
        "ibge": "3301009",
        "localidade": "Campos dos Goytacazes",
        "logradouro": "Avenida Alberto Lamego",
        "siafi": "5819",
        "uf": "RJ",
        "unidade": ""
      })

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
