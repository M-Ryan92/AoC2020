defmodule TreeMap do
  def get do
    File.stream!("map.txt")
    |> Stream.map(fn line ->
      line
    end)
    |> Enum.to_list()
  end
end
