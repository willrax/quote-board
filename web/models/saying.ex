defmodule Echo.Saying do
  use Echo.Web, :model

  schema "sayings" do
    field :name, :string
    field :body, :string

    timestamps
  end

  def encoded_cipher(id) do
    salt = Hashids.new([
      salt: "12345678",
      min_len: 5
    ])

    Hashids.encode(salt, id)
  end

  def decode_cipher(cipher) do
    salt = Hashids.new([
      salt: "12345678",
      min_len: 5,
    ])

    Hashids.decode(salt, cipher)
  end

  def random do
    {:ok, %{rows: [[id, name, body]]}} = Ecto.Adapters.SQL.query(Echo.Repo, "SELECT id, name, body from sayings ORDER BY RANDOM() LIMIT 1", [])
    %Echo.Saying{id: id, name: name, body: body}
  end

  @required_fields ~w(name body)
  @optional_fields ~w()

  def changeset(saying, params \\ :empty) do
    saying
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:body)
  end
end
