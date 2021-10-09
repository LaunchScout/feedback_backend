defmodule FeedbackBackend.Feedbacks.Feedback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedbacks" do
    field :email, :string
    field :message, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:name, :email, :message])
    |> validate_required([:name, :email, :message])
  end
end
