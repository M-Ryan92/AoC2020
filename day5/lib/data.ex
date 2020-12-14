defmodule Data do
  @moduledoc false
  def get do
    "data.txt"
    |> File.stream!()
    |> Stream.map(fn line -> String.replace(line, "\n", "") end)
    |> Enum.to_list()
  end
end
