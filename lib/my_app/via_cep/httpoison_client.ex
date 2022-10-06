defmodule MyApp.ViaCep.HttpoisonClient do
  alias HTTPoison.{Error, Response}

  @base_url "https://viacep.com.br/ws/"

  def get_cep_info(url \\ @base_url, cep) do
    "#{url}#{cep}/json/"
    |> HTTPoison.get()
    |> json_to_map()
    |> handle_get()
  end

  defp json_to_map({:ok, %Response{body: body} = response}) do
    {_ok_or_error, body} = Jason.decode(body)

    {:ok, Map.put(response, :body, body)}
  end

  defp json_to_map({:error, %Error{}} = error), do: error

  defp handle_get({:ok, %Response{status_code: 200, body: %{"erro" => "true"}}}) do
    {:error, %{status: :not_found, result: "CEP not found!"}}
  end

  defp handle_get({:ok, %Response{status_code: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Response{status_code: 400, body: _body}}) do
    {:error, %{status: :bad_request, result: "Invalid CEP!"}}
  end

  defp handle_get({:error, reason}) do
    {:error, %{status: :bad_request, result: reason}}
  end
end
