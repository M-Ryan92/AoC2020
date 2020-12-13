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
  def valid?(%Pasports{byr: byr}) when byr < 1920 or byr > 2002, do: false

  def valid?(%Pasports{iyr: nil}), do: false
  def valid?(%Pasports{iyr: iyr}) when iyr < 2010 or iyr > 2020, do: false

  def valid?(%Pasports{eyr: nil}), do: false
  def valid?(%Pasports{eyr: eyr}) when eyr < 2020 or eyr > 2030, do: false

  def valid?(%Pasports{hgt: nil}), do: false
  def valid?(%Pasports{hgt: {hgt, "cm"}}) when hgt < 150 or hgt > 193, do: false
  def valid?(%Pasports{hgt: {hgt, "in"}}) when hgt < 59 or hgt > 76, do: false

  def valid?(%Pasports{hcl: nil}), do: false
  def valid?(%Pasports{ecl: nil}), do: false
  def valid?(%Pasports{ecl: ecl}) when ecl not in ~w(amb blu brn gry grn hzl oth), do: false

  def valid?(%Pasports{pid: nil}), do: false

  def valid?(%Pasports{pid: pid, hcl: hcl}) do
    Regex.match?(~r/\d{9}/, pid) && Regex.match?(~r/\#[a-f0-9]{6}/, hcl)
  end
end
