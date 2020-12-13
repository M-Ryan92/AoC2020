defmodule Day1Test do
  use ExUnit.Case

  describe "find2020" do
    test "depth 1 combination found" do
      assert [true: 40000] = Day1.find2020({20, 20}, [10, 20, 300, 2000], 1)
    end

    test "depth 1 combination not found" do
      assert [] = Day1.find2020({20, 20}, [10, 20, 300], 1)
    end

    test "depth 2 combination found" do
      assert [true: 398_000] = Day1.find2020({20, 20}, [10, 20, 300, 1990], 2)
    end

    test "depth 2 combination not found" do
      assert [] = Day1.find2020({20, 20}, [10, 20, 300], 2)
    end
  end
end
