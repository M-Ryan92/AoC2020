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
  def valid?(%{byr: byr}) when byr not in 1921..2002, do: false

  def valid?(%{iyr: nil}), do: false
  def valid?(%{iyr: iyr}) when iyr not in 2010..2020, do: false

  def valid?(%{eyr: nil}), do: false
  def valid?(%{eyr: eyr}) when eyr not in 2020..2030, do: false

  def valid?(%{hgt: nil}), do: false
  def valid?(%{hgt: {hgt, "cm"}}) when hgt not in 150..193, do: false
  def valid?(%{hgt: {hgt, "in"}}) when hgt not in 59..76, do: false

  def valid?(%{hcl: nil}), do: false
  def valid?(%{ecl: nil}), do: false
  def valid?(%{pid: nil}), do: false

  def valid?(_), do: true
end
