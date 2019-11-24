defmodule ChuckWeb.AlexaController do
  use ChuckWeb, :controller

  def command(conn) do
    require Logger

    Logger.warn(inspect conn)
  end

end
