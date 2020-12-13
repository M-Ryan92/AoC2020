defmodule Day4 do
  @moduledoc """
  Documentation for Day4.
  """

  def run do
    Data.get()
    |> Enum.filter(fn e -> valid?(e) end)
    |> length()
  end

  def valid?(%{byr: nil}), do: false
  def valid?(%{iyr: nil}), do: false
  def valid?(%{eyr: nil}), do: false
  def valid?(%{hgt: nil}), do: false
  def valid?(%{hcl: nil}), do: false
  def valid?(%{ecl: nil}), do: false
  def valid?(%{pid: nil}), do: false

  def valid?(%{}), do: true
end
