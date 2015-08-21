defmodule Echo.SayingController do
  use Echo.Web, :controller

  alias Echo.Saying

  plug :scrub_params, "saying" when action in [:create, :update]

  def index(conn, _params) do
    saying = Echo.Saying.random
    render(conn, "show.json", saying: saying)
  end

  def create(conn, %{"saying" => saying_params}) do
    changeset = Saying.changeset(%Saying{}, saying_params)

    if changeset.valid? do
      saying = Repo.insert!(changeset)
      render(conn, "show.json", saying: saying)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Echo.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "saying" => saying_params}) do
    saying = Repo.get!(Saying, id)
    changeset = Saying.changeset(saying, saying_params)

    if changeset.valid? do
      saying = Repo.update!(changeset)
      render(conn, "show.json", saying: saying)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Echo.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    saying = Repo.get!(Saying, id)

    saying = Repo.delete!(saying)
    render(conn, "show.json", saying: saying)
  end
end
