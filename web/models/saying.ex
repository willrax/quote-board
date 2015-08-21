defmodule Echo.Saying do
  use Echo.Web, :model

  schema "sayings" do
    field :name, :string
    field :body, :string

    timestamps
  end

  def random do
    %{rows: [[id, name, body]]} = Ecto.Adapters.SQL.query(Echo.Repo, "SELECT id, name, body from sayings ORDER BY RANDOM() LIMIT 1", [])
    %Echo.Saying{id: id, name: name, body: body}
  end

  @required_fields ~w(name body)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
