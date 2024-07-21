defmodule Game.Actions.Attack do
  alias Game.Status
  @move_avg_power 18..25
  @move_rnd_power 10..35

  def attack_oponent(target, move) do
    damage = calculate_power(move)

    target
    |> ExMon.Agent.fetch_player
    |> Map.get(:life)
    |> calculate_total_life(damage)
    |> update_target_life(target, damage)
  end

  defp calculate_power(:move_avg), do: Enum.random(@move_avg_power)
  defp calculate_power(:move_rnd), do: Enum.random(@move_rnd_power)
  defp calculate_total_life(life, damage) when(life - damage < 0), do: 0
  defp calculate_total_life(life, damage) , do: life - damage
  defp update_target_life(life, target, damage) do
    target
    |> ExMon.Agent.fetch_player
    |> Map.put(:life, life)
    |> update_game(target, damage)
  end

  defp update_game(target_info, target, damage) do
    ExMon.Agent.get_infos
    |> Map.put(target, target_info)
    |> ExMon.Agent.update

    Status.print_move_message(target, :attack, damage)
  end
end
