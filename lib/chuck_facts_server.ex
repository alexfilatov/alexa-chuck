defmodule Chuck.ChuckFactsServer do
  @moduledoc """
  Getting facts from JSON here
  """
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def start_link() do
    GenServer.start_link(__MODULE__, load_facts(), name: __MODULE__)
  end

  def get_fact do
    GenServer.call(__MODULE__, :get_joke)
  end

  @impl true
  def handle_call(:get_joke, _from, state) do
    {:reply, Enum.random(state.jokes), state}
  end

  defp load_facts do
    require Logger
    with {:ok, body} <- File.read("#{Path.dirname(__DIR__)}/priv/repo/jokes.json"),
      {:ok, jokes} <- parse_jokes(body)
    do
      %{jokes: jokes}
    else
      error -> {:error, error}
    end
  end

  defp parse_jokes(body) do
    jokes = Jason.decode!(body) |> Enum.map(fn(%{"joke" => joke}) -> joke end)

    {:ok, jokes}
  end
end
