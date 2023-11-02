defmodule CheckYourPassport.PassportsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CheckYourPassport.Passports` context.
  """

  @doc """
  Generate a passport.
  """
  def passport_fixture(attrs \\ %{}) do
    {:ok, passport} =
      attrs
      |> Enum.into(%{
        name: "some name",
        date: "some date",
        tracking_number: "some tracking_number",
        county: "some county"
      })
      |> CheckYourPassport.Passports.create_passport()

    passport
  end
end
