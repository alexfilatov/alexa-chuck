defmodule ChuckWeb.EndpointController do
  use ChuckWeb, :controller

  @spec alexa(Plug.Conn.t(), any) :: Plug.Conn.t()
  def alexa(conn, params) do
    require Logger

    Logger.warn("ALEXA POST PARAMS:")
    Logger.warn(inspect params)

    {:ok, "ok"}
  end
end
