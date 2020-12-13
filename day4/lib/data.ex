defmodule Data do
  defstruct byr: nil, iyr: nil, eyr: nil, hgt: nil, hcl: nil, ecl: nil, pid: nil, cid: nil

  def get do
    "data.txt"
    |> File.stream!()
    |> Stream.chunk_by(fn line -> line === "\n" end)
    |> Stream.map(fn lines ->
      map =
        Enum.join(lines, " ")
        |> String.replace("\n", " ")
        |> String.split(" ")
        |> Enum.filter(fn e -> e !== "" end)
        |> Enum.into(%{}, fn kv ->
          [key, value] = String.split(kv, ":")

          cond do
            value === "" ->
              {String.to_atom(key), nil}

            key === "hgt" ->
              {String.to_atom(key), Integer.parse(value)}

            key in ["byr", "iyr", "eyr"] ->
              {String.to_atom(key), to_number(value)}

            true ->
              {String.to_atom(key), value}
          end
        end)

      struct(Data, map)
    end)
    |> Stream.filter(fn lines -> is_map(lines) end)
    |> Enum.to_list()
  end

  def to_number(string) do
    case Integer.parse(string) do
      {number, _} -> number
      :error -> nil
    end
  end
end
