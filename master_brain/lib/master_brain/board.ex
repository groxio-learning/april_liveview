defmodule MasterBrain.Board do
  alias MasterBrain.Move
  
  defstruct guesses: [], answer: [1, 2, 3, 4], current: Move.new()
  
  def new(answer \\ random_answer()) do
    __struct__(answer: answer)
  end
  
  defp random_answer do
    (1..8)
    |> Enum.shuffle
    |> Enum.take(4)
  end
  
  def move(%__MODULE__{}=board, guess) when is_list(guess) do
    %{ board | guesses: [guess|board.guesses] }
  end
  
  def won?(%{answer: answer, guesses: [answer|_rest]}), do: true
  def won?(_losing_board), do: false
  
  def to_hash(_board) do
  end
  
end