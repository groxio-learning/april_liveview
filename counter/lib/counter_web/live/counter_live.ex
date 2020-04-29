defmodule CounterWeb.CounterLive do

  # use is a macro that calls __use__
  # use CounterWeb, :live_view
  use Phoenix.LiveView
  # import Phoenix.LiveView, only: [assign: 2, assign: 3]

  def mount(_params, _session, socket) do
    # think of assign as "add data to the user area of the live view"
    # the very first thing that the router will call is mount/3

    {:ok, initialize(socket)}
  end


  def render(%{count: count} = assigns) do
    ~L"""
    <h1>
      <!-- could also be assigns.count -->
      <%= @count %>
    </h1>
    """
  end

  defp initialize(socket) do
    # this just adds stuff onto the socket
    assign(socket, count: 0)
  end
end
