defmodule Day1 do
  @moduledoc """
  Documentation for Day1.
  """

  def run do
    Report.get()
    |> process(2)
  end

  @spec process([integer], integer) :: [{integer, integer}]
  def process(_, _, acc \\ [])

  def process([number | rest], entries, acc) do
    case find2020({number, number}, rest, entries) do
      [] ->
        process(rest, entries, acc)

      result ->
        Keyword.get(result, true)
    end
  end

  def process([], _, acc), do: acc

  @spec find2020({integer, [integer]}, [integer], integer) :: {boolean, integer}
  def find2020(nil, _, _), do: {false, 0}

  def find2020({2020, numbers}, _, 0), do: {true, numbers}
  def find2020(_, _, 0), do: {false, 0}

  def find2020({number, acc}, list, n) do
    list
    |> Enum.map(fn number_from_list ->
      sum = number + number_from_list

      if sum <= 2020 do
        find2020({sum, number_from_list * acc}, list, n - 1)
      else
        {false, 0}
      end
    end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.filter(fn {r, _} -> r end)
  end
end
