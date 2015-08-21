defmodule Echo.Repo.Migrations.CreateSaying do
  use Ecto.Migration

  def change do
    create table(:sayings) do
      add :name, :string
      add :body, :string

      timestamps
    end

  end
end
