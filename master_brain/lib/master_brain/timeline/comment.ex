defmodule MasterBrain.Timeline.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    field :reaction, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :reaction, :username])
    |> validate_required([:body, :reaction, :username])
    |> validate_length(:body, max: 250, min: 4)
  end
end
