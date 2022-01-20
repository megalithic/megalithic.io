defmodule Megalithic.Repo do
  use Ecto.Repo,
    otp_app: :megalithic,
    adapter: Ecto.Adapters.Postgres
end
