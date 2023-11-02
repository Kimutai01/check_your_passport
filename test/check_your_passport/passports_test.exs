defmodule CheckYourPassport.PassportsTest do
  use CheckYourPassport.DataCase

  alias CheckYourPassport.Passports

  describe "passports" do
    alias CheckYourPassport.Passports.Passport

    import CheckYourPassport.PassportsFixtures

    @invalid_attrs %{name: nil, date: nil, tracking_number: nil, county: nil}

    test "list_passports/0 returns all passports" do
      passport = passport_fixture()
      assert Passports.list_passports() == [passport]
    end

    test "get_passport!/1 returns the passport with given id" do
      passport = passport_fixture()
      assert Passports.get_passport!(passport.id) == passport
    end

    test "create_passport/1 with valid data creates a passport" do
      valid_attrs = %{
        name: "some name",
        date: "some date",
        tracking_number: "some tracking_number",
        county: "some county"
      }

      assert {:ok, %Passport{} = passport} = Passports.create_passport(valid_attrs)
      assert passport.name == "some name"
      assert passport.date == "some date"
      assert passport.tracking_number == "some tracking_number"
      assert passport.county == "some county"
    end

    test "create_passport/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Passports.create_passport(@invalid_attrs)
    end

    test "update_passport/2 with valid data updates the passport" do
      passport = passport_fixture()

      update_attrs = %{
        name: "some updated name",
        date: "some updated date",
        tracking_number: "some updated tracking_number",
        county: "some updated county"
      }

      assert {:ok, %Passport{} = passport} = Passports.update_passport(passport, update_attrs)
      assert passport.name == "some updated name"
      assert passport.date == "some updated date"
      assert passport.tracking_number == "some updated tracking_number"
      assert passport.county == "some updated county"
    end

    test "update_passport/2 with invalid data returns error changeset" do
      passport = passport_fixture()
      assert {:error, %Ecto.Changeset{}} = Passports.update_passport(passport, @invalid_attrs)
      assert passport == Passports.get_passport!(passport.id)
    end

    test "delete_passport/1 deletes the passport" do
      passport = passport_fixture()
      assert {:ok, %Passport{}} = Passports.delete_passport(passport)
      assert_raise Ecto.NoResultsError, fn -> Passports.get_passport!(passport.id) end
    end

    test "change_passport/1 returns a passport changeset" do
      passport = passport_fixture()
      assert %Ecto.Changeset{} = Passports.change_passport(passport)
    end
  end
end
