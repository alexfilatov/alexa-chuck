defmodule Chuck.Repo do
  use Ecto.Repo,
    otp_app: :chuck,
    adapter: Ecto.Adapters.Postgres
end
