defmodule MasterBrain.Repo do
  use Ecto.Repo,
    otp_app: :master_brain,
    adapter: Ecto.Adapters.Postgres
end
