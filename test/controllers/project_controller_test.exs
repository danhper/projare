defmodule Projare.ProjectControllerTest do
  use Projare.ConnCase

  alias Projare.Project
  @valid_attrs %{created_at: "2010-04-17 14:00:00", description: "some content", title: "some content", url: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, project_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    project = Repo.insert! %Project{}
    conn = get conn, project_path(conn, :show, project)
    assert json_response(conn, 200)["data"] == %{"id" => project.id,
      "url" => project.url,
      "title" => project.title,
      "description" => project.description,
      "created_at" => project.created_at}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, project_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, project_path(conn, :create), project: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Project, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, project_path(conn, :create), project: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    project = Repo.insert! %Project{}
    conn = put conn, project_path(conn, :update, project), project: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Project, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    project = Repo.insert! %Project{}
    conn = put conn, project_path(conn, :update, project), project: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    project = Repo.insert! %Project{}
    conn = delete conn, project_path(conn, :delete, project)
    assert response(conn, 204)
    refute Repo.get(Project, project.id)
  end
end
