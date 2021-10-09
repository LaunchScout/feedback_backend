defmodule FeedbackBackendWeb.FeedbackController do
  use FeedbackBackendWeb, :controller

  alias FeedbackBackend.Feedbacks
  alias FeedbackBackend.Feedbacks.Feedback

  action_fallback FeedbackBackendWeb.FallbackController

  def index(conn, _params) do
    feedbacks = Feedbacks.list_feedbacks()
    render(conn, "index.json", feedbacks: feedbacks)
  end

  def create(conn, feedback_params) do
    with {:ok, %Feedback{} = feedback} <- Feedbacks.create_feedback(feedback_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.feedback_path(conn, :show, feedback))
      |> render("show.json", feedback: feedback)
    else
      {:error, cs} -> IO.inspect(cs)
    end
  end

  def show(conn, %{"id" => id}) do
    feedback = Feedbacks.get_feedback!(id)
    render(conn, "show.json", feedback: feedback)
  end

  def update(conn, %{"id" => id, "feedback" => feedback_params}) do
    feedback = Feedbacks.get_feedback!(id)

    with {:ok, %Feedback{} = feedback} <- Feedbacks.update_feedback(feedback, feedback_params) do
      render(conn, "show.json", feedback: feedback)
    end
  end

  def delete(conn, %{"id" => id}) do
    feedback = Feedbacks.get_feedback!(id)

    with {:ok, %Feedback{}} <- Feedbacks.delete_feedback(feedback) do
      send_resp(conn, :no_content, "")
    end
  end
end
