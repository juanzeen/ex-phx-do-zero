defmodule Game.Actions do
  alias Game.Actions.Attack
  def fetch_move(move) do
    ExMon.Agent.fetch_player
    |> Map.get(:moves)
    |> find_move(move)
  end

  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {k, v} ->
      if v == move, do: {:ok, k}
    end)
  end

  defp heal do

  end

  def attack(move) do
    case ExMon.Agent.get_turn do
      :player -> Attack.attack_oponent(:computer, move)
      :computer -> Attack.attack_oponent(:player, move)
    end
  end
end
