defmodule CodecheckSprint.ProjectTest do
  use CodecheckSprint.ModelCase

  alias CodecheckSprint.Project

  @valid_attrs %{created_at: "2010-04-17 14:00:00", description: "some content", title: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Project.changeset(%Project{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Project.changeset(%Project{}, @invalid_attrs)
    refute changeset.valid?
  end
end
