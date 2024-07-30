defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:name, :password, :email, :cep]
  @derive {Jason.Encoder, only: [:name]}
  schema "users" do
    field :name, :string
    #o campo password só existe no schema, nao está na migration
    #isso pq ele nao será enviado para o DB, por isso ele recebe esse virtual
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :cep, :string

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    #começamos dessa forma pois como estamos lidando com inserção, devemos
    #lidar inicialmente com uma struct vazia para que ela receba os
    #dados do params e assim torne-se válida para ser colocada no DB
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, is: 8)
    |> validate_format(:email, ~r/@/)
    |> add_password_hash
  end

  #faz pattern match com o changeset que vai vir focando nos campos valid? e pegando a senha nas changes
  defp add_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    #usamos a função change do Ecto.Changeset,
    change(changeset, Argon2.add_hash(password))
  end

  defp add_password_hash(changeset), do: changeset

end
