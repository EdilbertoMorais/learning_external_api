defmodule MyApp.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :cep, :string
    field :city, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :uf, :string

    timestamps()
  end

  def validate_before_insert(changeset), do: apply_action(changeset, :insert)

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :cep])
    |> validate_required([:first_name, :last_name, :email, :cep])
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)
  end
end
