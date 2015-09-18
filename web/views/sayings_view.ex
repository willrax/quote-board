defmodule Echo.SayingsView do
  use Echo.Web, :view

  def encode_cipher(saying) do
    Echo.Saying.encoded_cipher(saying.id)
  end
end
