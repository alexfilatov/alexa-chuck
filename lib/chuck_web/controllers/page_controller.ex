defmodule ChuckWeb.PageController do
  use ChuckWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec alexa_endpoint(Plug.Conn.t(), any) :: Plug.Conn.t()
  def alexa_endpoint(conn, params) do
    #    TODO: implement me
    {:ok, "ok"}
  end
end
