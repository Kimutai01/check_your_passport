defmodule CheckYourPassport.Passports do
  @moduledoc """
  The Passports context.
  """

  import Ecto.Query, warn: false
  alias CheckYourPassport.Repo

  alias CheckYourPassport.Passports.Passport

  @doc """
  Returns the list of passports.

  ## Examples

      iex> list_passports()
      [%Passport{}, ...]

  """
  def list_passports do
    Repo.all(Passport)
  end

  def paginate_passports(params) do
    Repo.paginate(Passport, params)
  end

  @doc """
  Gets a single passport.

  Raises `Ecto.NoResultsError` if the Passport does not exist.

  ## Examples

      iex> get_passport!(123)
      %Passport{}

      iex> get_passport!(456)
      ** (Ecto.NoResultsError)

  """
  def get_passport!(id), do: Repo.get!(Passport, id)

  @doc """
  Creates a passport.

  ## Examples

      iex> create_passport(%{field: value})
      {:ok, %Passport{}}

      iex> create_passport(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_passport(attrs \\ %{}) do
    %Passport{}
    |> Passport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a passport.

  ## Examples

      iex> update_passport(passport, %{field: new_value})
      {:ok, %Passport{}}

      iex> update_passport(passport, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_passport(%Passport{} = passport, attrs) do
    passport
    |> Passport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a passport.

  ## Examples

      iex> delete_passport(passport)
      {:ok, %Passport{}}

      iex> delete_passport(passport)
      {:error, %Ecto.Changeset{}}

  """
  def delete_passport(%Passport{} = passport) do
    Repo.delete(passport)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking passport changes.

  ## Examples

      iex> change_passport(passport)
      %Ecto.Changeset{data: %Passport{}}

  """
  def change_passport(%Passport{} = passport, attrs \\ %{}) do
    Passport.changeset(passport, attrs)
  end
end
