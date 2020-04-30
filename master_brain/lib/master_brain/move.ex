defmodule MasterBrain.Move do
  def new, do: []
  
  def add([_,_,_,_]=move, _peg), do: move
  def add(move, peg), do: [peg|move]
  
  def backspace([]), do: []
  def backspace([_peg|move]), do: move
  
  def show(move), do: Enum.reverse(move)
end