defmodule MasterBrain do
  alias MasterBrain.{Move, Board, Score}

  def new do
    Board.new()
  end

  def add_peg(board, peg) do
    board
    |> Board.add_peg(peg)
  end

  def remove_peg(board) do
    board
    |> Board.remove_peg()
  end

  def submit_move(board) do
    board
    |> Board.submit_move()
  end

  # is_binary is a string when it has valid codepoints/characters
  def move(board, guess) when is_binary(guess) do
    with {:ok, guess_string} <- valid?(guess) do
      valid_guess =
        guess_string
        |> String.graphemes()
        |> Enum.map(&String.to_integer/1)

        {:ok, Board.move(board, valid_guess)}
    else
      error -> error
    end
  end

  def valid?(guess_string) do
    good_string =
      ~r/^[1-8]{4}$/

    if guess_string =~ good_string do
      {:ok, guess_string}
    else
      {:error, :bad_input}
    end
  end

  defmacro __using__(_opts) do
    quote do
      alias MasterBrain.{Move, Board, Score}
    end
  end
end
