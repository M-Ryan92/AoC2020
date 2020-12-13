defmodule Report do
  @moduledoc """
  the expense list
  """
  def stream() do
    File.cwd!()
    |> Path.join("expense_report.txt")
    |> File.stream!()
    |> Stream.map(fn line ->
      {number, _} = Integer.parse(line)
      number
    end)
  end

  def get do
    Enum.to_list(stream)
  end
end
