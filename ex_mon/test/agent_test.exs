defmodule ExMon.AgentTest do

  use ExUnit.Case

  alias ExMon.Player

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("J", :soco, :chute, :cafe)
      computer = Player.build("Machine", :soco, :chute, :cura)

      assert {:ok, _pid} = ExMon.Agent.start(computer, player)
    end
  end

  describe "info" do
    test "returns the current state" do
      player = Player.build("J", :soco, :chute, :cafe)
      computer = Player.build("Home Destroyer", :send_numbers, :hack_instagram, :eat_elixir_code)
      ExMon.Agent.start(computer, player)

      expected_response = %{
        status: :started,
        turn: :player,
        computer: %Player{
          name: "Home Destroyer",
          life: 100,
          moves: %{
            move_heal: :eat_elixir_code,
            move_avg: :send_numbers,
            move_rnd: :hack_instagram
          }
        },
        player: %Player{
          name: "J",
          life: 100,
          moves: %{
            move_heal: :cafe,
            move_avg: :soco,
            move_rnd: :chute
          }
        }
      }

      assert ExMon.Agent.get_infos == expected_response
    end
  end

  describe "update/1" do
    test "returns the game state update" do
      player = Player.build("J", :soco, :chute, :cafe)
      computer = Player.build("Home Destroyer", :send_numbers, :hack_instagram, :eat_elixir_code)
      ExMon.Agent.start(computer, player)

      expected_response = %{
        status: :started,
        turn: :player,
        computer: %Player{
          name: "Home Destroyer",
          life: 100,
          moves: %{
            move_heal: :eat_elixir_code,
            move_avg: :send_numbers,
            move_rnd: :hack_instagram
          }
        },
        player: %Player{
          name: "J",
          life: 100,
          moves: %{
            move_heal: :cafe,
            move_avg: :soco,
            move_rnd: :chute
          }
        }
      }

      assert ExMon.Agent.get_infos == expected_response

      new_state = %{
        status: :started,
        turn: :player,
        computer: %Player{
          name: "Home Destroyer",
          life: 85,
          moves: %{
            move_heal: :eat_elixir_code,
            move_avg: :send_numbers,
            move_rnd: :hack_instagram
          }
        },
        player: %Player{
          name: "J",
          life: 100,
          moves: %{
            move_heal: :cafe,
            move_avg: :soco,
            move_rnd: :chute
          }
        }
      }

      ExMon.Agent.update(new_state)

      expected_response = %{ new_state | turn: :computer, status: :continue}

      assert ExMon.Agent.get_infos == expected_response

    end
  end

end
