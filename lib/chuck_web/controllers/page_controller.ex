defmodule ChuckWeb.PageController do
  use ChuckWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    fact = Chuck.ChuckFacts.get_fact()

    render(conn, "index.html", fact: fact)
  end

  @spec alexa_endpoint(Plug.Conn.t(), any) :: Plug.Conn.t()
  def alexa_endpoint(conn, params) do


    {:ok, "ok"}
  end
end
