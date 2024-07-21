defmodule Game.Status do
  alias Game.Actions

  def print_round() do
    IO.puts("\n===== The game is started! =====\n")
    IO.inspect(ExMon.Agent.get_infos)
    IO.puts("------------------------")
  end

  def print_round(round) do
    IO.puts("The game is started!")
    IO.inspect(ExMon.Agent.get_infos)
  end

  def print_error_message(move) do
    IO.puts("===== You selected a inexistent movement! ===== \n\nYour movements are:")
    ExMon.Agent.get_player_infos
    |> Map.get(:moves)
    |> IO.inspect()
  end

  def print_move_message(target, :attack, damage) do
    IO.puts("===== #{target} received #{damage} damage =====")
    ExMon.Agent.fetch_player(target)
  end
end
