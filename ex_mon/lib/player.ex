defmodule ExMon.Player do
  @required_keys [:name, :life, :moves]
  @enforce_keys @required_keys
  @max_life 100
  defstruct @required_keys

  def build(name, move_avg, move_rnd, move_heal) do
    %ExMon.Player{
      name: name,
      moves: %{move_avg: move_avg, move_rnd: move_rnd, move_heal: move_heal},
      life: @max_life
    }
  end
end
