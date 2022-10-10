defmodule MyApp.Users.CreateTest do
  use MyApp.DataCase, async: true

  import Mox

  alias MyApp.{User, Users.Create, ViaCep.ClientMock}

  describe "call/1" do
    test "when all params are valid" do
      params = %{
        first_name: "Mike",
        last_name: "Wazowski",
        cep: "95270000",
        email: "mike_wazowski@monstros_sa.com"
      }

      expect(ClientMock, :get_cep_info, fn "00000000" ->
        {:ok,
         %{
           "bairro" => "Sé",
           "cep" => "01001-000",
           "complemento" => "lado ímpar",
           "ddd" => "11",
           "gia" => "1004",
           "ibge" => "3550308",
           "localidade" => "São Paulo",
           "logradouro" => "Praça da Sé",
           "siafi" => "7107",
           "uf" => "SP"
         }}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id, email: "mike_wazowski@monstros_sa.com"}} = response
    end

    test "when there are invalid params" do
      params = %{
        first_name: "Mike",
        last_name: "Wazowski",
        cep: "123",
        email: "monstros_sa.com"
      }

      response = Create.call(params)

      expected_response = %{
        cep: ["should be 8 character(s)"],
        email: ["has invalid format"]
      }

      assert {:error, changeset} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
