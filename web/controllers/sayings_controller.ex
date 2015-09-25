defmodule Echo.SayingsController do
  use Echo.Web, :controller

  alias Echo.Saying

  plug :scrub_params, "saying" when action in [:create, :update]

  def random(conn, _params) do
    saying = Echo.Saying.random
    render conn, saying: saying
  end

  def index(conn, _params) do
    sayings = Repo.all(Saying)
    render conn, sayings: sayings
  end

  def show(conn, %{"cypher" => cipher}) do
    {:ok, [id]} = Saying.decode_cipher(cipher)

    saying = Repo.get!(Saying, id)
    render conn, saying: saying
  end

  def new(conn, _params) do
    changeset = Saying.changeset(%Saying{})
    render conn, changeset: changeset
  end

  def create(conn, %{"saying" => saying_params}) do
    changeset = Saying.changeset(%Saying{}, saying_params)

    case Repo.insert(changeset) do
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
      {_, changeset} ->
        cipher = Saying.encoded_cipher(changeset.id)
        redirect conn, to: sayings_path(conn, :show, cipher)
    end
  end
end
