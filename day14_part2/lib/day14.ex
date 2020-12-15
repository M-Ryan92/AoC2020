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

  def split_float(masked) do
    IO.inspect(masked)
    charlist = to_charlist(masked)

    res =
      Enum.reduce_while(charlist, 0, fn e, pos ->
        cond do
          e === ?X ->
            items = [
              to_string(List.update_at(charlist, pos, fn _ -> ?0 end)),
              to_string(List.update_at(charlist, pos, fn _ -> ?1 end))
            ]

            {:halt, items}

          pos === 35 ->
            {:halt, [masked]}

          true ->
            {:cont, pos + 1}
        end
      end)

    Enum.reduce(res, [], fn e, acc ->
      if String.contains?(e, "X") do
        split_float(e) ++ acc
      else
        [e | acc]
      end
    end)
  end

  def process_splitted(_, acc \\ [])
  def process_splitted([], acc), do: acc

  def process_splitted([item | rest], acc) do
    process_splitted(rest, [binary_to_decimal(item) | acc])
  end

  def process_line([], acc), do: acc

  def process_line([{k, v} | rest], %{"mask" => m} = acc) when k !== :mask do
    res =
      v
      |> decimal_to_binary()
      |> bin_mask(m)
      |> to_string()
      |> Day14.split_float()
      |> Enum.uniq()
      |> Day14.process_splitted()
      |> Enum.sum()

    process_line(rest, Map.put(acc, "#{k}", res))
  end

  def process_line([{k, v} | rest], acc) do
    process_line(rest, Map.put(acc, "#{k}", v))
  end

  def binary_to_decimal(bin) do
    bin
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
      mask === ?0 ->
        char = Enum.at(bin, pos)
        new_bin = List.replace_at(bin, pos, char)
        bin_mask(mask_rest, new_bin, pos + 1)

      mask === ?X ->
        new_bin = List.replace_at(bin, pos, ?X)
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
