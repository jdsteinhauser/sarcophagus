defmodule Sarcophagus do
  @moduledoc """
  Documentation for Sarcophagus.
  """

  defp map_over_chars(str, f) do
    str
    |> to_charlist()
    |> Enum.map(f)
    |> to_string()
  end

  defp char_shift(base, c, multiplier, shift) when shift < 0, do: char_shift(base, c, multiplier, 26 + shift)

  defp char_shift(base, c, multiplier, shift), do: base + rem (c - base + 1) * multiplier + shift - 1, 26

  defp char_shift(c, multiplier, shift) when c in ?a..?z, do: char_shift(?a, c, multiplier, shift)
  
  defp char_shift(c, multiplier, shift) when c in ?A..?Z, do: char_shift(?A, c, multiplier, shift)
  
  defp char_shift(c, _multiplier, _shift), do: c

  def affine_cipher(plain_text, multiplier, shift), do: map_over_chars(plain_text, &(char_shift(&1, multiplier, shift)))

  @doc """
  Performs a Caesar shift cipher on a message, shifting the letters
  `x` characters forward in the alphabet, wrapping around from z to a
  when necessary

  ## Examples

      iex> Sarcophagus.caesar_cipher("Attack at dawn")
      "Dwwdfn dw gdzq"

      iex> Sarcophagus.caesar_cipher("Attack at dawn", 5)
      "Fyyfhp fy ifbs"
  """
  def caesar_cipher(plain_text, shift \\ 3), do: affine_cipher(plain_text, 1, shift)

  @doc """
  Performs a 13 character Caesar shift cipher on the plain text input.

  ## Examples

      iex> Sarcophagus.rot13_cipher("Attack at dawn")
      "Nggnpx ng qnja"
  """
  def rot13_cipher(plain_text), do: affine_cipher(plain_text, 1, 13)

  defp char_mirror(c) when c in ?a..?z, do: ?z - c + ?a
  defp char_mirror(c) when c in ?A..?Z, do: ?Z - c + ?A
  defp char_mirror(c), do: c

  @doc """
  Performs a basic Atbash substitution cipher, switching letters from
  a,b,c,... to z,y,x,...

  ## Examples

      iex> Sarcophagus.atbash_cipher("Attack at dawn")
      "Zggzxp zg wzdm"

  """
  def atbash_cipher(plain_text), do: map_over_chars(plain_text, &char_mirror/1)
end
