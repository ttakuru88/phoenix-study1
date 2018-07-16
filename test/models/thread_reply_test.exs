defmodule PhxApp.ThreadReplyTest do
  use PhxApp.ModelCase

  alias PhxApp.ThreadReply

  @valid_attrs %{body: "some body"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ThreadReply.changeset(%ThreadReply{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ThreadReply.changeset(%ThreadReply{}, @invalid_attrs)
    refute changeset.valid?
  end
end
