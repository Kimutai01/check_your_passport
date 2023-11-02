defmodule CheckYourPassport.Repo.Migrations.CreatePassports do
  use Ecto.Migration

  def change do
    create table(:passports) do
      add :name, :string
      add :date, :string
      add :tracking_number, :string
      add :county, :string

      timestamps()
    end
  end
end
