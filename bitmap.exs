defmodule Bitmap do
  defstruct value: 0

  @doc """
  A simple accesor for the 2^bit value in an integer
    iex> b = %Bitmap{value: 5}
    %Bitmap{value: 5}
    iex> Bitmap.fetch_bit(b,2)
    1
    iex> Bitmap.fetch_bit(b,1)
    0
    iex> Bitmap.fetch_bit(b,0)
    1
  """
  def fetch_bit(%Bitmap{value: value}, bit) do
    use Bitwise

    (value >>> bit) &&& 1
  end
end

defimpl Enumerable, for: Bitmap do
  import Bitmap
  import :math, only: [log: 1]

  def count(%Bitmap{value: value}) do
    {:ok, trunc(log(abs(value))/log(2)) + 1}
  end

  def member?(value, bit_number) do
    {:ok, 0 <= bit_number && bit_number < Enum.count(value)}
  end


end

fifty = %Bitmap{value: 50}

IO.puts Enum.count fifty
