defmodule Day14 do
  @moduledoc """
  Documentation for Day14.
  """

  def run do
    Data.get()
    |> process_line(%{})
    |> Enum.to_list()
    |> Enum.reduce(0, fn e, acc ->
      case e do
        {"mask", _} ->
          acc

        {_, v} ->
          v + acc
      end
    end)
    |> to_string()
  end

  @spec process_line([{any, any}], any) :: any
  def process_line([], acc), do: acc

  def process_line([{k, v} | rest], %{"mask" => m} = acc) when k !== :mask do
    masked = bin_mask(m, decimal_to_binary(v))
    to_v = binary_to_decimal(masked)

    process_line(rest, Map.put(acc, "#{k}", to_v))
  end

  def process_line([{k, v} | rest], acc) do
    process_line(rest, Map.put(acc, "#{k}", v))
  end

  def binary_to_decimal(bin) when is_list(bin) do
    bin
    |> to_string()
    |> Integer.parse(2)
    |> case do
      {number, _} ->
        number

      _ ->
        raise "ASDADA"
    end
  end

  def decimal_to_binary(decimal) when is_binary(decimal) do
    decimal
    |> String.to_integer()
    |> decimal_to_binary()
  end

  def decimal_to_binary(decimal) when is_integer(decimal) do
    decimal
    |> Integer.to_string(2)
    |> String.pad_leading(36, "0")
    |> to_charlist()
  end

  def bin_mask(mask, bin, pos \\ 0)

  def bin_mask([], bin, _), do: bin

  def bin_mask([mask | mask_rest], bin, pos) do
    cond do
      mask === ?X ->
        char = Enum.at(bin, pos)
        new_bin = List.replace_at(bin, pos, char)
        bin_mask(mask_rest, new_bin, pos + 1)

      mask === ?0 ->
        new_bin = List.replace_at(bin, pos, ?0)
        bin_mask(mask_rest, new_bin, pos + 1)

      mask === ?1 ->
        new_bin = List.replace_at(bin, pos, ?1)
        bin_mask(mask_rest, new_bin, pos + 1)
    end
  end

  def binary_sum(a, b) do
    a
    |> Enum.zip(b)
    |> Enum.reduce({'', ?0}, fn {a, b}, {bin, add} ->
      cond do
        a === ?1 and b === ?1 and add === ?1 ->
          {[?1 | bin], ?1}

        (a === ?1 or b === ?1) and add === ?1 ->
          {[?0 | bin], ?1}

        add === ?1 ->
          {[?1 | bin], ?0}

        a === ?1 and b === ?1 ->
          {[?0 | bin], ?1}

        a === ?1 or b === ?1 ->
          {[?1 | bin], ?0}

        true ->
          {[?0 | bin], ?0}
      end
    end)
    |> elem(0)
  end
end
