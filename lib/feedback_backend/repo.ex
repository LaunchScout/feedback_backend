defmodule FeedbackBackend.Repo do
  use Ecto.Repo,
    otp_app: :feedback_backend,
    adapter: Ecto.Adapters.Postgres
end
