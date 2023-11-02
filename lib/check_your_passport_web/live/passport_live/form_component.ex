defmodule CheckYourPassportWeb.PassportLive.FormComponent do
  use CheckYourPassportWeb, :live_component

  alias CheckYourPassport.Passports

  @impl true
  def update(%{passport: passport} = assigns, socket) do
    changeset = Passports.change_passport(passport)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"passport" => passport_params}, socket) do
    changeset =
      socket.assigns.passport
      |> Passports.change_passport(passport_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"passport" => passport_params}, socket) do
    save_passport(socket, socket.assigns.action, passport_params)
  end

  defp save_passport(socket, :edit, passport_params) do
    case Passports.update_passport(socket.assigns.passport, passport_params) do
      {:ok, _passport} ->
        {:noreply,
         socket
         |> put_flash(:info, "Passport updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_passport(socket, :new, passport_params) do
    case Passports.create_passport(passport_params) do
      {:ok, _passport} ->
        {:noreply,
         socket
         |> put_flash(:info, "Passport created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
