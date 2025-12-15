defmodule MyTable.Repo do
  use Ecto.Repo,
    otp_app: :my_table,
    adapter: Ecto.Adapters.Postgres
end
