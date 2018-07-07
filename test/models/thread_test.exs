defmodule PhxApp.ThreadTest do
  use PhxApp.ModelCase

  alias PhxApp.Thread

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Thread.changeset(%Thread{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Thread.changeset(%Thread{}, @invalid_attrs)
    refute changeset.valid?
  end
end
