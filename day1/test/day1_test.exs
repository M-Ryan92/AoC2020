defmodule Day1Test do
  use ExUnit.Case

  describe "find2020" do
    test "combination found" do
      {true, {20, 2000}} = Day1.find2020(20, [10, 20, 300, 2000])
    end

    test "combination not found" do
      {false, nil} = Day1.find2020(20, [10, 20, 300])
    end
  end
end
