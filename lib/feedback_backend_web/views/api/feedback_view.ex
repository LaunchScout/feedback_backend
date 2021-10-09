defmodule FeedbackBackendWeb.Api.FeedbackView do
  use FeedbackBackendWeb, :view
  alias FeedbackBackendWeb.Api.FeedbackView

  def render("index.json", %{feedbacks: feedbacks}) do
    %{data: render_many(feedbacks, FeedbackView, "feedback.json")}
  end

  def render("show.json", %{feedback: feedback}) do
    %{data: render_one(feedback, FeedbackView, "feedback.json")}
  end

  def render("feedback.json", %{feedback: feedback}) do
    %{
      id: feedback.id,
      name: feedback.name,
      email: feedback.email,
      message: feedback.message
    }
  end
end
