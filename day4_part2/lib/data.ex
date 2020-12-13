defmodule Data do
  defstruct byr: nil, iyr: nil, eyr: nil, hgt: nil, hcl: nil, ecl: nil, pid: nil, cid: nil

  def get do
    File.stream!("data.txt")
    |> Stream.chunk_by(fn line -> line === "\n" end)
    |> Stream.filter(fn line -> line !== ["\n"] end)
    |> Stream.map(fn lines ->
      map =
        lines
        |> Enum.join(" ")
        |> String.replace("\n", " ")
        |> String.split(" ")
        |> Enum.filter(fn e -> e !== "" end)
        |> Enum.into(%{}, fn kv ->
          [key, value] = String.split(kv, ":")

          cond do
            key === "pid" and Regex.match?(~r/\d{9}/, value) ->
              {String.to_atom(key), value}

            key === "ecl" and value in ~w(amb blu brn gry grn hzl oth) ->
              {String.to_atom(key), value}

            key === "hgt" ->
              {String.to_atom(key), parse_hgt(value)}

            key === "cid" ->
              {String.to_atom(key), value}

            key === "hcl" && Regex.match?(~r/\#[a-f0-9]{6}/, value) ->
              {String.to_atom(key), value}

            key in ["byr", "iyr", "eyr"] ->
              {String.to_atom(key), to_number(value)}

            true ->
              {String.to_atom(key), nil}
          end
        end)

      struct(Data, map)
    end)
    |> Enum.to_list()
  end

  defp parse_hgt(string) do
    case Integer.parse(string) do
      {hgt, x} when x in ["in", "cm"] ->
        {hgt, x}

      _ ->
        nil
    end
  end

  defp to_number(string) do
    case Integer.parse(string) do
      {number, ""} -> number
      _ -> nil
    end
  end
end
