defmodule FizzBuzz do

  def run(file) do
    File.read(file)
    |> convert()
  end

  defp convert({:ok, file}) do
  result =
    file
  |> String.trim
  |> String.split(",")
  #mais viável usar capture operator quando já temos a função existindo
  |> Enum.map(&evaluate_numbers/1)
  {:ok, result}
end

  defp convert({:error, reason}), do: {:error, "Conversion error: #{reason}"}

  defp evaluate_numbers(number) do
    number
    |> String.to_integer()
    |> convert_to_phrase()
  end

  defp convert_to_phrase(num) when rem(num, 3) == 0 and rem(num, 5) == 0, do: :fizz_buzz
  defp convert_to_phrase(num) when rem(num, 3) == 0, do: :fizz
  defp convert_to_phrase(num) when rem(num, 5) == 0, do: :buzz
  defp convert_to_phrase(num), do: num

end
