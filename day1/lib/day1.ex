defmodule Day1 do
  @moduledoc """
  Documentation for Day1.
  """

  def run do
    Report.get()
    |> process()
    |> List.first()
  end

  @spec process([integer]) :: [{integer, integer}]
  def process(_, acc \\ [])

  def process([number | rest], acc) do
    case find2020(number, rest) do
      {true, {first, second}} ->
        process(rest, [first * second | acc])

      _ ->
        process(rest, acc)
    end
  end

  def process([], acc), do: acc

  @spec find2020(integer, [integer]) :: {true, {integer, integer}} | {false, nil}
  def find2020(number, list) do
    result =
      Enum.filter(list, fn number_from_list ->
        2020 === number + number_from_list
      end)

    case List.first(result) do
      nil ->
        {false, nil}

      result ->
        {true, {number, result}}
    end
  end
end
