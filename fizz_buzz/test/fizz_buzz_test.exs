defmodule FizzBuzzTest do
  use ExUnit.Case

  describe "run/1" do
    test "when a valid file is provided, return the converted list" do
      expected = {:ok,[1, 2, :fizz, 4, :buzz, :buzz, :fizz, :fizz, 32, 1553, :fizz_buzz, :fizz]}
      assert FizzBuzz.run("numbers.txt") == expected
      assert FizzBuzz.run("non_exist.txt") == {:error, "Conversion error: enoent"}
    end
  end

end
