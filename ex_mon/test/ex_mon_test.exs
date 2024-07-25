defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      assert %Player{
               life: 100,
               moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cafe},
               name: "J"
             } == ExMon.create_player("J", :soco, :chute, :cafe)
    end
  end

  describe "start_game/1" do
    test "when game is started, returns a message" do
      player = ExMon.create_player("J", :soco, :chute, :cafe)
      #em messages fica salvo a saída do inspect, dentro da fn fazemos o assert com
      #:ok pois é isso que é retornado do inspect
        messages =
          capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

        #usamos regex pra nao passar a string inteira
        assert messages =~ "The game is started"
        assert messages =~ "status: :started"
        assert messages =~ "turn: :player"
    end
  end
  describe "make_move/1" do
    #procedimento padrão que será executado antes da realização de qualquer teste dentro do describe
    #o setup sempre espera ao fim um retorno de sucesso ou uma variável
    setup do
      player = ExMon.create_player("J", :soco, :chute, :cafe)
      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end
    test "valid move -> do the move and makes computer make a move" do
      messages =
        capture_io(fn ->
        ExMon.make_move(:soco)
      end)

      assert messages =~ "computer received"
      #dessa maneira conseguimos verificar se a mudança de turno ocorre corretamente
      assert messages =~ "its computer turn"
      assert messages =~ "its player turn"
      assert messages =~ "status: :continue"
    end

    test "invalid move -> error message" do
      messages =
        capture_io(fn ->
        ExMon.make_move(:socaoultramasterblaster)
      end)

      assert messages =~ "You don't have the socaoultramasterblaster move"
    end
  end
end
