defmodule ChuckWeb.PageController do
  use ChuckWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  def terms(conn, _params) do
    render(conn, "terms.html")
  end

  def policy(conn, _params) do
    render(conn, "policy.html")
  end
end
