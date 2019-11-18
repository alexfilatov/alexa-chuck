defmodule ChuckFacts do
  @moduledoc """
  Getting facts from JSON here
  """
  use GenServer

  @impl true
  @doc """
  Loads data from JSON into memory
  """
  def init do
    {:ok, load_facts()}
  end

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def get_fact do

  end

  defp load_facts do

  end

end
