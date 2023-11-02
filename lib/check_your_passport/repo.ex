defmodule CheckYourPassport.Repo do
  use Ecto.Repo,
    otp_app: :check_your_passport,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 5
end
