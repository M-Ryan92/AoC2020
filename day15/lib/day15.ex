defmodule Day15 do
  @moduledoc """
  Documentation for Day15.
  """
  def run(input, end_turn) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> init()
    |> speak(end_turn)
  end

  def init(speak) do
    [{turn, last_spoken} | spoken] =
      speak
      |> Enum.with_index(1)
      |> Enum.reverse()

    {last_spoken, turn, Map.new(spoken)}
  end

  def speak({last_spoken, turn, spoken}, end_turn) when turn < end_turn do
    next = {
      turn - Map.get(spoken, last_spoken, turn),
      turn + 1,
      Map.put(spoken, last_spoken, turn)
    }

    speak(next, end_turn)
  end

  def speak({speak, _, _}, _), do: speak
end
