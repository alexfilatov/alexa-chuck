defmodule ChuckWeb.PageControllerTest do
  use ChuckWeb.ConnCase
  require Logger

  setup_all do
    System.put_env("APP_PORT", "4100")
    System.put_env("APP_HOSTNAME", "localhost")
    System.put_env("SECRET_KEY_BASE", "dn2LtKsz0JLVLms2QjDArXdx1+p+q/RG4/pQPLH2DL7Xgq60wJoNvAUeN0u3KPqS")
    System.put_env("ALEXA_SKILL_ID", "skill_id")
    :ok
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Next Random Fact"
  end
end
