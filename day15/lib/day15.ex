defmodule Day15 do
  @moduledoc """
  Documentation for Day15.
  """

  @list [6, 3, 15, 13, 1, 0]
  def run(n) do
    acc = set_turns(@list)
    run(n - length(@list), acc)
  end

  def run(t, acc) when t <= 0, do: acc

  def run(n, acc) do
    new_acc = do_turn(acc)
    run(n - 1, new_acc)
  end

  def set_turns(_, pos \\ 1, state \\ [])
  def set_turns([], _, state), do: state

  def set_turns([number | rest], pos, state) do
    acc = [{pos, number} | state]
    set_turns(rest, pos + 1, acc)
  end

  def do_turn([{current, v} | rest] = state) do
    next = current + 1
    spoken = spoken(v, state)

    cond do
      two_in_a_row(v, rest) ->
        [{next, 1} | state]

      length(spoken) >= 2 ->
        one = Enum.at(spoken, 0)
        two = Enum.at(spoken, 1)

        number = elem(one, 0) - elem(two, 0)

        [{next, number} | state]

      true ->
        [{next, 0} | state]
    end
  end

  def last_time_spoken(_, []), do: nil
  def last_time_spoken(v, [{t, v} | _]), do: t

  def last_time_spoken(v, [_ | rest]), do: last_time_spoken(v, rest)

  def two_in_a_row(_, []), do: false
  def two_in_a_row(v, [{_, v}]), do: true
  def two_in_a_row(v, [{_, v} | _]), do: true
  def two_in_a_row(_, _), do: false

  def spoken(number, state) do
    Enum.reject(state, fn {_, v} -> v != number end)
  end
end
