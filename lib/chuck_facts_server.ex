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
    path = Path.join([Application.app_dir(:chuck), "priv/repo/jokes.json"])

    with true <- File.exists?(path),
      {:ok, body} <- File.read(path),
      {:ok, jokes} <- parse_jokes(body)
    do
      %{jokes: jokes}
    else
      false -> Logger.error("File #{path} not found")
      error -> {:error, error}
    end
  end

  defp parse_jokes(body) do
    jokes = Jason.decode!(body) |> Enum.map(fn(%{"joke" => joke}) -> joke end)

    {:ok, jokes}
  end
end
