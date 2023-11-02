defmodule CheckYourPassport.Passports.Passport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "passports" do
    field :name, :string
    field :date, :string
    field :tracking_number, :string
    field :county, :string

    timestamps()
  end

  @doc false
  def changeset(passport, attrs) do
    passport
    |> cast(attrs, [:name, :date, :tracking_number, :county])
    |> validate_required([:name, :date, :tracking_number, :county])
  end
end
