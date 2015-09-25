defmodule Echo.Plugs.Authenticate do
  alias Plug.Conn

  def init(_), do: nil

  def call(conn, _) do
    config = {System.get_env("AUTH_REALM"), "#{System.get_env("AUTH_USER")}:#{System.get_env("AUTH_PASSWORD")}"}

    get_auth_header(conn)
      |> decode_creds
      |> assert_creds(config)
  end

  def get_auth_header(conn) do
    {conn, Conn.get_req_header(conn, "authorization")}
  end

  defp decode_creds({conn, ["Basic " <> encoded_creds | _]}) do
    case Base.decode64(encoded_creds) do
      {:ok, creds} -> {conn, creds}
      :error -> {conn, nil}
    end
  end

  defp decode_creds({conn, _}), do: {conn, nil}

  defp assert_creds({conn, val}, nil) do
    destructure([user, pass], split_creds(val))
    Conn.assign(conn, :credentials, {user, pass})
  end

  defp assert_creds({conn, val}, {_, val}), do: conn
  defp assert_creds({conn, _}, {realm, _}), do: halt_with_login(conn, realm)

  def halt_with_login(conn, realm) do
    Conn.put_resp_header(conn, "www-authenticate", "Basic realm=\"" <> realm <> "\"")
      |> Conn.send_resp(401, "HTTP Basic: Access denied.\n")
      |> Conn.halt
  end

  defp split_creds(nil), do: []
  defp split_creds(val), do: :binary.split(val, ":")
end
