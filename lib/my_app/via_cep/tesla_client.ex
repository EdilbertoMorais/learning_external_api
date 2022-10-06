defmodule MyApp.ViaCep.TeslaClient do
  use Tesla

  alias Tesla.Env

  @base_url "https://viacep.com.br/ws/"

  plug Tesla.Middleware.JSON

  def get_cep_info(url \\ @base_url, cep) do
    "#{url}#{cep}/json/"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"erro" => "true"}}}) do
    {:error, %{status: :not_found, result: "CEP not found!"}}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 400, body: _body}}) do
    {:error, %{status: :bad_request, result: "Invalid CEP!"}}
  end

  defp handle_get({:error, reason}) do
    {:error, %{status: :bad_request, result: reason}}
  end
end
