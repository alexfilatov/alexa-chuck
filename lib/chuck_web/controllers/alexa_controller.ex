defmodule ChuckWeb.AlexaController do
  use ChuckWeb, :controller

  require Logger

  # Request type dispatcher
  def command(
        conn,
        %{
          "request" => %{
            "type" => "LaunchRequest"
          }
        }
      ) do

    content = Chuck.ChuckFactsServer.get_fact()
    response = message("Chuck Norris Fact", "Hello! Here is the fact: #{content}")
    send_response(conn, response)
  end

  def command(
        conn,
        %{
          "request" => %{
            "type" => "SessionEndedRequest"
          }
        }
      ) do

    response = message("Thank you!", "Ok, that's it. Call me again when you need me", true)
    send_response(conn, response)
  end

  def command(
        conn,
        %{
          "request" => %{
            "type" => req_type,
            "intent" => %{
              "name" => intent_name
            }
          }
        }
      ) do
    process_intent(conn, intent_name)
  end

  # Intents:
  def process_intent(conn, "GetJokeIntent") do
    content = Chuck.ChuckFactsServer.get_fact()
    response = message("Chuck Norris Fact", content)
    send_response(conn, response)
  end

  def process_intent(conn, "NextJokeIntent") do
    content = Chuck.ChuckFactsServer.get_fact()
    response = message("Next Chuck Norris Fact", content)
    send_response(conn, response)
  end

  #  Amazon intents:
  def process_intent(conn, "AMAZON.StopIntent") do
    response = message("Chuck Norris is out", "Thank you! Call me again when you need me.", true)
    send_response(conn, response)
  end

  def process_intent(conn, "AMAZON.CancelIntent") do
    response = message("Chuck Norris is out", "Cancelled! Call me again when you need me.", true)
    send_response(conn, response)
  end

  def process_intent(conn, "AMAZON.HelpIntent") do
    response = message(
      "How to use Chuck Norris Jokes",
      "Just ask Alexa to open Chuck Norris Jokes then say Next if you want to hear next joke and say Stop to make Alexa quiet.",
      true
    )
    send_response(conn, response)
  end

  def process_intent(conn, "AMAZON.NavigateHomeIntent") do
    response = message("Home sweet home", "I hope you're at home now :)", true)
    send_response(conn, response)
  end

  # Helpers
  def message(title, content, stop \\ false) do
    ~s"""
    {
        "version": "1.0",
        "response": {
          "outputSpeech": {
            "type": "PlainText",
            "text": "#{content}"
          },
          "card": {
            "type": "Simple",
            "title": "#{title}",
            "content": "#{content}"
          },
          "shouldEndSession": #{stop}
        }
      }
    """
  end

  def send_response(conn, response) do
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.resp(
         200,
         Jason.decode!(response)
         |> Jason.encode!()
       )
  end
end
