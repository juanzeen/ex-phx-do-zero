defmodule Game.Actions.Heal do
  alias Game.Status
  @move_heal_points 18..25

  def heal_life(player) do
    player
    |> ExMon.Agent.fetch_player()
    |> Map.get(:life)
    |> calculate_life
    |> set_life(player)
  end

  defp calculate_life(player_life), do: player_life + Enum.random(@move_heal_points)

  defp set_life(new_life, player) when(new_life > 100), do: update_life(100, player)
  defp set_life(new_life, player), do: update_life(new_life, player)

  defp update_life(new_life, player) do
    player
    |> ExMon.Agent.fetch_player()
    |> Map.put(:life, new_life)
    |> update_game(player, new_life)
  end

  defp update_game(new_player_data, player, new_life) do
    ExMon.Agent.get_infos
    |> Map.put(player, new_player_data)
    |> ExMon.Agent.update()

    Status.print_heal_message(player, new_life)
  end
end
