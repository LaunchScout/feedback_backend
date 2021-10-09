defmodule FeedbackBackend.FeedbacksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FeedbackBackend.Feedbacks` context.
  """

  @doc """
  Generate a feedback.
  """
  def feedback_fixture(attrs \\ %{}) do
    {:ok, feedback} =
      attrs
      |> Enum.into(%{
        email: "some email",
        message: "some message",
        name: "some name"
      })
      |> FeedbackBackend.Feedbacks.create_feedback()

    feedback
  end
end
