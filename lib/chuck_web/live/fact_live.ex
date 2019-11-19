defmodule Chuck.Live.FactLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <button phx-click="random_fact">Next random fact</button>
    <div class="phx-hero">
    <h1><%= @fact %></h1>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, :fact, Chuck.ChuckFacts.get_fact())}
  end

  def handle_event("random_fact", value, socket) do
    require Logger
    Logger.warn(inspect value)

    {:noreply, assign(socket, :fact, Chuck.ChuckFacts.get_fact())}
  end
end