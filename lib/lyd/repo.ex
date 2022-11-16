defmodule Lyd.Repo do
  use Ecto.Repo,
    otp_app: :lyd,
    adapter: Ecto.Adapters.Postgres
end
