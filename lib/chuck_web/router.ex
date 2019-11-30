defmodule ChuckWeb.Router do
  use ChuckWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug LessVerifiesAlexa.Plug, application_id: "amzn1.ask.skill.d92fd8c4-1586-4818-9871-67a9b3b571e9"
  end

  scope "/", ChuckWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/terms", PageController, :terms
    get "/terms-of-use", PageController, :terms
    get "/privacy-policy", PageController, :policy
  end

  scope "/api", ChuckWeb do
    pipe_through :api

    post "/alexa/command", AlexaController, :command
  end
end
