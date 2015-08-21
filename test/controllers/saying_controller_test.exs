defmodule Echo.SayingControllerTest do
  use Echo.ConnCase

  alias Echo.Saying
  @valid_attrs %{body: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, saying_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    saying = Repo.insert! %Saying{}
    conn = get conn, saying_path(conn, :show, saying)
    assert json_response(conn, 200)["data"] == %{
      "id" => saying.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, saying_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, saying_path(conn, :create), saying: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Saying, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, saying_path(conn, :create), saying: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    saying = Repo.insert! %Saying{}
    conn = put conn, saying_path(conn, :update, saying), saying: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Saying, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    saying = Repo.insert! %Saying{}
    conn = put conn, saying_path(conn, :update, saying), saying: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    saying = Repo.insert! %Saying{}
    conn = delete conn, saying_path(conn, :delete, saying)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Saying, saying.id)
  end
end
