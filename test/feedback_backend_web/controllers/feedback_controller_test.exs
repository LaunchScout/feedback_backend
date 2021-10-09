defmodule FeedbackBackendWeb.FeedbackControllerTest do
  use FeedbackBackendWeb.ConnCase

  import FeedbackBackend.FeedbacksFixtures

  alias FeedbackBackend.Feedbacks.Feedback

  @create_attrs %{
    email: "some email",
    message: "some message",
    name: "some name"
  }
  @update_attrs %{
    email: "some updated email",
    message: "some updated message",
    name: "some updated name"
  }
  @invalid_attrs %{email: nil, message: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all feedbacks", %{conn: conn} do
      conn = get(conn, Routes.feedback_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create feedback" do
    test "renders feedback when data is valid", %{conn: conn} do
      conn = post(conn, Routes.feedback_path(conn, :create), feedback: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.feedback_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some email",
               "message" => "some message",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.feedback_path(conn, :create), feedback: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update feedback" do
    setup [:create_feedback]

    test "renders feedback when data is valid", %{conn: conn, feedback: %Feedback{id: id} = feedback} do
      conn = put(conn, Routes.feedback_path(conn, :update, feedback), feedback: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.feedback_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "message" => "some updated message",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, feedback: feedback} do
      conn = put(conn, Routes.feedback_path(conn, :update, feedback), feedback: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete feedback" do
    setup [:create_feedback]

    test "deletes chosen feedback", %{conn: conn, feedback: feedback} do
      conn = delete(conn, Routes.feedback_path(conn, :delete, feedback))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.feedback_path(conn, :show, feedback))
      end
    end
  end

  defp create_feedback(_) do
    feedback = feedback_fixture()
    %{feedback: feedback}
  end
end
