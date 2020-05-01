defmodule MasterBrain.Board do
  alias MasterBrain.{Move, Score}

  @max_moves 10

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

  def done?(%{guesses: guesses} = _board) do
    length(guesses) >= @max_moves
  end

  def lost?(board) do
    done?(board) && not won?(board)
  end

  def to_hash(board) do
    rows = Enum.map(board.guesses, &row_to_hash(&1, board.answer))
    %{
      rows: rows,
      won: board |> won?,
      lost: board |> lost?,
      move: board.current |> Move.show()
    }
  end

  defp row_to_hash(guess, answer) do
    %{guess: guess, score: Score.new(answer, guess)}
  end

  def add_peg(board, peg) do
    %{ board| current: Move.add(board.current, peg)}
  end
  def remove_peg(%{current: move}=board) do
    %{ board| current: Move.backspace(move)}
  end
  def submit_move(board) do
    new_move = board.current |> Enum.reverse()

    board
    |> move(new_move)
    |> clear_current()
  end
  def clear_current(board) do
    %{ board| current: Move.new()}
  end

end
