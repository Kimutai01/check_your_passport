defmodule CheckYourPassportWeb.PassportLive.Index do
  use CheckYourPassportWeb, :live_view

  alias CheckYourPassport.Passports
  alias CheckYourPassport.Passports.Passport

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :passports, list_passports())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Passport")
    |> assign(:passport, Passports.get_passport!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Passport")
    |> assign(:passport, %Passport{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Passports")
    |> assign(:passport, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    passport = Passports.get_passport!(id)
    {:ok, _} = Passports.delete_passport(passport)

    {:noreply, assign(socket, :passports, list_passports())}
  end

  defp list_passports do
    Passports.list_passports()
  end
end
