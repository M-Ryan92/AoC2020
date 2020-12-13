defmodule Day2 do
  @moduledoc """
  Documentation for Day2.
  """

  def run do
    PasswordWithPolicies.get()
    |> process()
  end

  defp process(_, acc \\ 0)

  defp process([policy | policies], acc) do
    %{min: min, max: max, char: char, password: pass} = policy

    if valid?(char, String.at(pass, min - 1), String.at(pass, max - 1)) do
      process(policies, acc + 1)
    else
      process(policies, acc)
    end
  end

  defp process(_, acc), do: acc

  defp valid?(char, min, char) when min !== char, do: true
  defp valid?(char, char, _), do: true
  defp valid?(_, _, _), do: false
end
