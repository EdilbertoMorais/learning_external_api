defmodule MyApp.ViaCep.Behaviour do
  @callback get_cep_info(String.t()) :: {:ok, map()} | {:error, map()}
end
