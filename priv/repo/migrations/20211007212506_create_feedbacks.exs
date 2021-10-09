defmodule FeedbackBackend.Repo.Migrations.CreateFeedbacks do
  use Ecto.Migration

  def change do
    create table(:feedbacks) do
      add :name, :string
      add :email, :string
      add :message, :string

      timestamps()
    end
  end
end
