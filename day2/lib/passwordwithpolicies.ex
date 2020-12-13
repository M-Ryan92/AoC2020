defmodule PasswordWithPolicies do
  def get do
    File.stream!("passwords.txt")
    |> Stream.map(fn line ->
      case Regex.named_captures(~r/(?<min>\d*)-(?<max>\d*) (?<char>\w): (?<password>.*)/, line) do
        %{"char" => char, "max" => max, "min" => min, "password" => pass} ->
          %{min: to_n(min), max: to_n(max), char: char, password: pass}

        _ ->
          raise "something went wrong"
      end
    end)
    |> Enum.to_list()
  end

  defp to_n(s) do
    {number, _} = Integer.parse(s)
    number
  end
end
