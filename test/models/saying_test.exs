defmodule Echo.SayingTest do
  use Echo.ModelCase

  alias Echo.Saying

  @valid_attrs %{body: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Saying.changeset(%Saying{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Saying.changeset(%Saying{}, @invalid_attrs)
    refute changeset.valid?
  end
end
