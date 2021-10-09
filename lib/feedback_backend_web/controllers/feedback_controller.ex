defmodule FeedbackBackendWeb.FeedbackController do
  use FeedbackBackendWeb, :controller

  alias FeedbackBackend.Feedbacks
  alias FeedbackBackend.Feedbacks.Feedback

  action_fallback FeedbackBackendWeb.FallbackController

  def index(conn, _params) do
    feedbacks = Feedbacks.list_feedbacks()
    render(conn, "index.html", feedbacks: feedbacks)
  end

end
