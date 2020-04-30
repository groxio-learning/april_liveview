defmodule MasterBrain.MoveTest do
  use ExUnit.Case, async: true
  
  import MasterBrain.Move
  
  test "adds two moves" do
    actual = 
      new()
      |> add(1)
      |> add(2)
      |> show
    
    assert actual == [1, 2]
  end
  
  test "moves run out" do
    actual = 
      new()
      |> check([])
      |> add(1)
      |> check([1])
      |> add(2)
      |> check([2, 1])
      |> add(3)
      |> check([3, 2, 1])
      |> add(4)
      |> check([4, 3, 2, 1])
      |> add(4)
      |> check([4, 3, 2, 1])
      |> show
    
    assert actual == [1, 2, 3, 4]
  end
  
  def check(actual, expected) do
    assert actual == expected

    actual
  end
end
