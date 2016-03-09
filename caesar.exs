defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(sting)
end

defimpl Caesar, for: List do
  def encrypt(list, shift) do
    Enum.map(list, &encrypt_char(&1, shift))
  end

  def rot13(string), do: encrypt(string, 13)

  @length_leters 26

  defp encrypt_char(char, shift) when char in ?a..?z do
    ?a + rem(char + shift - ?a, @length_leters)
  end

  defp encrypt_char(char, shift) when char in ?A..?Z do
    ?A + rem(char + shift - ?A, @length_leters)
  end
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    Caesar.List.encrypt(String.to_char_list(string), shift)
    |> List.to_string
  end

  def rot13(string), do: encrypt(string, 13)
end
