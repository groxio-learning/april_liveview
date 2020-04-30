defmodule MasterBrain.Move do

  def new, do: []

  def add([_,_,_,_]=move,_peg), do: move 
  def add(move,peg) when peg in (1..8), do: [peg|move] 

  def backspace([]), do: []
  def backspace([_|move]), do: move

end
