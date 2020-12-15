defmodule Day14Test do
  use ExUnit.Case
  doctest Day14

  test "binary_sum" do
    a = binary("1001")
    b = binary("1000101101")
    c = binary("1011001")
    d = binary("1110011001011001")

    assert '00000000000000000000001000110110' = Day14.binary_sum(a, b)
    assert '00000000000000000000000001100010' = Day14.binary_sum(a, c)
    assert '00000000000000000000000000010010' = Day14.binary_sum(a, a)
    assert '00000000000000000000001010000110' = Day14.binary_sum(b, c)
    assert '00000000000000000000000010110010' = Day14.binary_sum(c, c)
    assert '00000000000000001110011001100010' = Day14.binary_sum(a, d)
    assert '00000000000000001110100010000110' = Day14.binary_sum(b, d)
    assert '00000000000000001110011010110010' = Day14.binary_sum(c, d)
    assert '00000000000000011100110010110010' = Day14.binary_sum(d, d)
  end

  test "decimal_to_bin" do
    assert '000000000000000000000000000000000010' = Day14.decimal_to_binary("2")
    assert '000000000000000000000000000000000110' = Day14.decimal_to_binary("6")
    assert '000000000000000000000000000000001011' = Day14.decimal_to_binary("11")
    assert '000000000000000000001100001101011010' = Day14.decimal_to_binary("50010")
    assert '000000000000010011000110001010111010' = Day14.decimal_to_binary("5006010")
    assert '000000011101110111001011111010111010' = Day14.decimal_to_binary("501006010")
  end

  test "bin_to_dec" do
    assert 2 = Day14.binary_to_decimal('000000000000000000000000000000000010')
    assert 6 = Day14.binary_to_decimal('000000000000000000000000000000000110')
    assert 11 = Day14.binary_to_decimal('000000000000000000000000000000001011')
    assert 50010 = Day14.binary_to_decimal('000000000000000000001100001101011010')
    assert 5_006_010 = Day14.binary_to_decimal('000000000000010011000110001010111010')
    assert 501_006_010 = Day14.binary_to_decimal('000000011101110111001011111010111010')
  end

  test "bin_mask" do
    a = Day14.decimal_to_binary("48627")
    b = Day14.decimal_to_binary("16724249")
    c = Day14.decimal_to_binary("241166")

    mask = '1X0110X0X110000100X01100000011101111'

    assert '100110000110000100001100000011101111' = Day14.bin_mask(mask, a)
    assert '100110000110000100101100000011101111' = Day14.bin_mask(mask, b)
    assert '100110000110000100101100000011101111' = Day14.bin_mask(mask, c)
  end

  def binary(s) do
    s
    |> String.pad_leading(32, "0")
    |> to_charlist()
  end
end
