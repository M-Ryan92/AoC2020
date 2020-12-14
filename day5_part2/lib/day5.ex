defmodule Day5 do
  @moduledoc """
  Documentation for Day5.
  """

  def run do
    Data.get()
    |> Enum.map(fn binary ->
      process_pass(binary)
    end)
  end

  def find_seat() do
    run()
    |> Enum.group_by(fn %{row: r} -> r end)
    |> Enum.filter(fn {k, v} ->
      taken =
        v
        |> Enum.map(fn %{column: c} -> c end)
        |> Enum.sort()

      taken !== [0, 1, 2, 3, 4, 5, 6, 7] and !String.starts_with?(to_string(k), "1")
    end)
    |> Enum.map(fn {k, v} ->
      taken = Enum.map(v, fn %{column: c} -> c end)

      pass =
        Enum.filter([0, 1, 2, 3, 4, 5, 6, 7], fn e ->
          e not in taken
        end)
        |> Enum.map(fn e ->
          id =
            k
            |> Kernel.*(8)
            |> Kernel.+(e)

          %{id: id, row: k, column: e}
        end)

      pass
    end)
    |> List.flatten()
    |> List.first()
  end

  def max do
    run()
    |> Enum.max_by(fn %{id: i} -> i end)
  end

  def process_pass(binary) do
    state = %{count: 0, row: string_list(0..127), column: string_list(0..7)}

    %{row: [r], column: [c]} =
      binary
      |> to_charlist()
      |> Enum.reduce(state, fn char, %{count: c} = acc ->
        if c < 7 do
          row_range(%{acc | count: c + 1}, char)
        else
          column_range(acc, char)
        end
      end)

    id =
      r
      |> Kernel.*(8)
      |> Kernel.+(c)

    %{id: id, column: c, row: r}
  end

  def row_range(%{row: row} = state, letter) do
    res = split(row)

    case {letter, res} do
      {?F, {lower, _}} ->
        %{state | row: lower}

      {?B, {_, upper}} ->
        %{state | row: upper}
    end
  end

  def column_range(%{column: col} = state, letter) do
    res = split(col)

    case {letter, res} do
      {?L, {lower, _}} ->
        %{state | column: lower}

      {?R, {_, upper}} ->
        %{state | column: upper}
    end
  end

  defp split(range) do
    split =
      range
      |> length()
      |> div(2)

    Enum.split(range, split)
  end

  defp string_list(range) do
    Enum.into(range, [], fn e -> e end)
  end
end
