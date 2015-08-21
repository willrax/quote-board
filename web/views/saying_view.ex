defmodule Echo.SayingView do
  use Echo.Web, :view

  def render("show.json", %{saying: saying}) do
    %{saying: render_one(saying, "saying.json")}
  end

  def render("saying.json", %{saying: saying}) do
    %{id: encode_id(saying.id), body: saying.body, name: saying.name}
  end

  defp encode_id(id) do
    salt = Hashids.new([
      salt: "12345678",
      min_len: 5,
    ])

    Hashids.encode(salt, id)
  end
end
