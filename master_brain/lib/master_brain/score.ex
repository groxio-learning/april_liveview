defmodule MasterBrain.Score do
  defstruct [reds: 0, whites: 0]

  def new(answer, guess) do
    %__MODULE__{reds: reds(answer, guess), whites: whites(answer, guess)}
  end

  # red: right color, right place
  def reds(answer, guess) do
    answer 
    |> Enum.zip(guess)
    |> Enum.count(fn {x, y} -> x == y end)
  end

  # misses
  def misses(answer, guess), do: length(guess -- answer)

  # number of slots in answer (length of answer)
  def peg_count(answer), do: length(answer)

  # whites: right color, wrong place
  def whites(answer, guess) do
    peg_count(answer) - reds(answer, guess) - misses(answer, guess)
  end
end