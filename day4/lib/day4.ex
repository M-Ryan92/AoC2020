defmodule Day4 do
  @moduledoc """
  Documentation for Day4.
  """

  def run do
    Pasports.get()
    |> Enum.filter(fn e -> valid?(e) end)
    |> length()
  end

  def valid?(%Pasports{byr: nil}), do: false
  def valid?(%Pasports{iyr: nil}), do: false
  def valid?(%Pasports{eyr: nil}), do: false
  def valid?(%Pasports{hgt: nil}), do: false
  def valid?(%Pasports{hcl: nil}), do: false
  def valid?(%Pasports{ecl: nil}), do: false
  def valid?(%Pasports{pid: nil}), do: false

  def valid?(%Pasports{}), do: true
end
