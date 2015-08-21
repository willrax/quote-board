defmodule Echo.SayingView do
  use Echo.Web, :view

  def render("show.json", %{saying: saying}) do
    %{saying: render_one(saying, "saying.json")}
  end

  def render("saying.json", %{saying: saying}) do
    %{id: saying.id, body: saying.body, name: saying.name}
  end
end
