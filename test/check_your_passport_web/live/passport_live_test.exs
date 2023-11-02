defmodule CheckYourPassportWeb.PassportLiveTest do
  use CheckYourPassportWeb.ConnCase

  import Phoenix.LiveViewTest
  import CheckYourPassport.PassportsFixtures

  @create_attrs %{
    name: "some name",
    date: "some date",
    tracking_number: "some tracking_number",
    county: "some county"
  }
  @update_attrs %{
    name: "some updated name",
    date: "some updated date",
    tracking_number: "some updated tracking_number",
    county: "some updated county"
  }
  @invalid_attrs %{name: nil, date: nil, tracking_number: nil, county: nil}

  defp create_passport(_) do
    passport = passport_fixture()
    %{passport: passport}
  end

  describe "Index" do
    setup [:create_passport]

    test "lists all passports", %{conn: conn, passport: passport} do
      {:ok, _index_live, html} = live(conn, Routes.passport_index_path(conn, :index))

      assert html =~ "Listing Passports"
      assert html =~ passport.name
    end

    test "saves new passport", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.passport_index_path(conn, :index))

      assert index_live |> element("a", "New Passport") |> render_click() =~
               "New Passport"

      assert_patch(index_live, Routes.passport_index_path(conn, :new))

      assert index_live
             |> form("#passport-form", passport: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#passport-form", passport: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.passport_index_path(conn, :index))

      assert html =~ "Passport created successfully"
      assert html =~ "some name"
    end

    test "updates passport in listing", %{conn: conn, passport: passport} do
      {:ok, index_live, _html} = live(conn, Routes.passport_index_path(conn, :index))

      assert index_live |> element("#passport-#{passport.id} a", "Edit") |> render_click() =~
               "Edit Passport"

      assert_patch(index_live, Routes.passport_index_path(conn, :edit, passport))

      assert index_live
             |> form("#passport-form", passport: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#passport-form", passport: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.passport_index_path(conn, :index))

      assert html =~ "Passport updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes passport in listing", %{conn: conn, passport: passport} do
      {:ok, index_live, _html} = live(conn, Routes.passport_index_path(conn, :index))

      assert index_live |> element("#passport-#{passport.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#passport-#{passport.id}")
    end
  end

  describe "Show" do
    setup [:create_passport]

    test "displays passport", %{conn: conn, passport: passport} do
      {:ok, _show_live, html} = live(conn, Routes.passport_show_path(conn, :show, passport))

      assert html =~ "Show Passport"
      assert html =~ passport.name
    end

    test "updates passport within modal", %{conn: conn, passport: passport} do
      {:ok, show_live, _html} = live(conn, Routes.passport_show_path(conn, :show, passport))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Passport"

      assert_patch(show_live, Routes.passport_show_path(conn, :edit, passport))

      assert show_live
             |> form("#passport-form", passport: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#passport-form", passport: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.passport_show_path(conn, :show, passport))

      assert html =~ "Passport updated successfully"
      assert html =~ "some updated name"
    end
  end
end
