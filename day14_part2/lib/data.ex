defmodule Data do
  @moduledoc false
  def get do
    "data.txt"
    |> File.stream!()
    |> Stream.map(fn line -> String.replace(line, "\n", "") end)
    |> Enum.map(fn e ->
      cond do
        String.starts_with?(e, "mask =") -> mask_line(e)
        true -> mem_line(e)
      end
    end)
  end

  defp mask_line("mask = " <> e) do
    {:mask, to_charlist(e)}
  end

  defp mem_line(e) do
    case String.split(e, " = ") do
      ["mem[" <> number, right] ->
        {to_int(number), to_int(right)}

      _ ->
        raise "oof"
    end
  end

  defp to_int(string) do
    case Integer.parse(string) do
      {number, _} ->
        number

      _ ->
        raise "to_int error"
    end
  end
end
