defmodule Game.Status do

  def print_round(%{status: :started, turn: player} = info) do
    IO.puts("\n===== The game is started! =====\n")
    IO.puts("      The game is started! And its #{player} turn      ")
    IO.inspect(info)
    IO.puts("------------------------")
  end

  def print_round(%{status: :continue, turn: player} = info) do
    IO.puts("      The PORRADARIA is rolling! And its #{player} turn      ")
    IO.inspect(info)
  end

  def print_round(%{status: :game_over, turn: player} = info) do
    IO.puts("      GAME OVER! FINISH HIM #{player}     ")
    IO.inspect(info)
  end

  def print_error_message(move) do
    IO.puts("===== You don't have the #{move} move! ===== \n\nYour movements are:")

    ExMon.Agent.fetch_player()
    |> Map.get(:moves)
    |> IO.inspect()
  end

  def print_move_message(target, :attack, damage) do
    IO.puts("===== #{target} received #{damage} damage =====")
    ExMon.Agent.get_infos()
  end

  def print_heal_message(player, healed_life) do
    IO.puts("===== #{player} healed yourself and now have #{healed_life} HP =====")
    ExMon.Agent.get_infos()
  end
end
