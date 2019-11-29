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

    if Mix.env == :prod do
      plug LessVerifiesAlexa.Plug, application_id: System.get_env("ALEXA_SKILL_ID")
    end
  end

  scope "/", ChuckWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", ChuckWeb do
    pipe_through :api

    post "/alexa/command", AlexaController, :command
  end
end
