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
    count = count_occurance(char, pass)

    if valid?(min, max, count) do
      process(policies, acc + 1)
    else
      process(policies, acc)
    end
  end

  defp process(_, acc), do: acc

  defp valid?(min, max, occurance) when occurance >= min and occurance <= max, do: true
  defp valid?(_, _, _), do: false

  defp count_occurance(char, pass) do
    pass
    |> String.codepoints()
    |> Enum.reduce(0, fn e, acc ->
      if e === char do
        acc + 1
      else
        acc
      end
    end)
  end
end
