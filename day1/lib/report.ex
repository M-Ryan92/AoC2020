defmodule InputList do
  @moduledoc """
  the expense list
  """
  def get do
    File.stream!("expense_report.txt")
    |> Stream.map(fn line ->
      {number, _} = Integer.parse(line)
      number
    end)
    |> Enum.to_list()
  end
end
