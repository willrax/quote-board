defmodule Echo.Repo.Migrations.AddUniqueConstraintToSaying do
  use Ecto.Migration

  def change do
    create unique_index(:sayings, [:body])
  end
end
