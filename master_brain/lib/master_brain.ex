defmodule MasterBrain do
  @moduledoc """
  MasterBrain keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  
  defmacro __using__(_opts) do
    quote do
      alias MasterBrain.{Move, Board, Score}
    end
  end
end
