defmodule MasterBrain.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string
      add :reaction, :string
      add :username, :string

      timestamps()
    end

  end
end
