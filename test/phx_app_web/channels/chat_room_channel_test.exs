defmodule PhxAppWeb.ChatRoomChannelTest do
  use PhxAppWeb.ChannelCase

  alias PhxAppWeb.ChatRoomChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(ChatRoomChannel, "chat_room:main")

    {:ok, socket: socket}
  end

  test "speak replies with status ok", %{socket: socket} do
    ref = push socket, "speak", %{"message" => "unco!"}
    assert_broadcast "speak", %{"message" => "unco!"}
  end
end
