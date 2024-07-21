defmodule ExMon.Agent do
  use Agent

  def start(computer, player) do
    start_value = %{computer: computer, player: player, turn: :player, status: :started}
    Agent.start_link(fn -> start_value end, name: __MODULE__)
    Game.Status.print_round
  end

  def get_infos do
    Agent.get(__MODULE__, fn x -> x end)
  end

  def update(state) do
    Agent.update(__MODULE__, fn _ -> state end)
  end

  def fetch_player(player), do: Map.get(get_infos(), player)
  def fetch_player(), do: Map.get(get_infos(), get_turn())
  def get_turn, do: Map.get(get_infos(), :turn)
end
