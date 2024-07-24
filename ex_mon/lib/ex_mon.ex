defmodule ExMon do
  alias ExMon.Player
  alias Game.Actions
  alias Game.Status

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    # criamos o player do computador nessa função e recebemos o player do jogador também nessa função para startar o game
    create_player("Home Destroyer", :send_numbers, :hack_instagram, :eat_elixir_code)
    |> ExMon.Agent.start(player)

    Game.Status.print_round(ExMon.Agent.get_infos())
  end

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move
  end

  defp do_move({:error, move}), do: Status.print_error_message(move)

  defp do_move({:ok, move_key}) do
    case move_key do
      :move_heal -> Actions.heal()
      move_key -> Actions.attack(move_key)
    end

    Status.print_round(ExMon.Agent.get_infos())
  end
end
