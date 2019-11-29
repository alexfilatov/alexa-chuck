defmodule ChuckWeb.AlexaController do
  use ChuckWeb, :controller

  def command(conn, _intent) do
    content = Chuck.ChuckFactsServer.get_fact()

    response = ~s"""
    {
        "version": "1.0",
        "response": {
          "outputSpeech": {
            "type": "PlainText",
            "text": "#{content}"
          },
          "card": {
            "type": "Simple",
            "title": "Next random Chuck Norris fact",
            "content": "#{content}"
          }
        }
      }
    """

    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.resp(
         200,
         Jason.decode!(response)
         |> Jason.encode!()
       )
  end
end
