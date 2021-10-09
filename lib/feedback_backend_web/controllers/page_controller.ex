defmodule FeedbackBackendWeb.PageController do
  use FeedbackBackendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
