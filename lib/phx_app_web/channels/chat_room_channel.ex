defmodule PhxAppWeb.ChatRoomChannel do
  use PhxAppWeb, :channel

  def join("chat_room:main", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # def handle_in("ping", payload, socket) do
  #   {:reply, {:ok, payload}, socket}
  # end

  def handle_in("speak", payload, socket) do
    broadcast socket, "speak", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
