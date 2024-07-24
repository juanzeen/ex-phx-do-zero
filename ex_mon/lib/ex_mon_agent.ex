defmodule ExMon.Agent do
  alias ExMon.Player
  use Agent

  def start(computer, player) do
    start_value = %{computer: computer, player: player, turn: :player, status: :started}
    Agent.start_link(fn -> start_value end, name: __MODULE__)
  end

  def get_infos do
    Agent.get(__MODULE__, fn x -> x end)
  end

  def update(state) do
    Agent.update(__MODULE__, fn _ -> update_game_status(state) end)
  end

  def fetch_player(player), do: Map.get(get_infos(), player)
  def fetch_player(), do: Map.get(get_infos(), get_turn())
  def get_turn, do: Map.get(get_infos(), :turn)

  defp update_game_status(
         state = %{player: %Player{life: player_life}, computer: %Player{life: computer_life}}
       )
       when player_life == 0 or computer_life == 0,
       do: Map.put(state, :status, :game_over)

  defp update_game_status(state) do
    state
    |> Map.put(:status, :continue)
    |> update_turn
  end

  defp update_turn(%{turn: :player} = state), do: Map.put(state, :turn, :computer)
  defp update_turn(%{turn: :computer} = state), do: Map.put(state, :turn, :player)
end
