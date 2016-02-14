defmodule CodecheckSprint.StarTest do
  use CodecheckSprint.ModelCase

  alias CodecheckSprint.Star

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Star.changeset(%Star{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Star.changeset(%Star{}, @invalid_attrs)
    refute changeset.valid?
  end
end
