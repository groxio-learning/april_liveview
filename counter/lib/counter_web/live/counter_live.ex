defmodule CounterWeb.CounterLive do
  use Phoenix.LiveView
  # use is a macro that calls __use__
  # use CounterWeb, :live_view
  # import Phoenix.LiveView, only: [assign: 2, assign: 3]

  def mount(_params, _session, socket) do
    # think of assign as "add data to the user area of the live view"
    # the very first thing that the router will call is mount/3
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)
    
    {
      :ok, 
      socket 
      |> initialize 
      |> show
    }
  end
  
  def show(socket) do
    socket
    |> assign(:time, Time.utc_now() |> to_string)
  end
  
  defp initialize(socket) do
    # this just adds stuff onto the socket
    assign(socket, count: 0)
  end
  
  defp inc(socket) do
    assign(socket,
        count: socket.assigns.count + 1
    )
  end
  defp dec(socket) do
    assign(socket,
        count: socket.assigns.count - 1
    )
  end

  def render(%{count: count} = assigns) do
    # ~L""" <-- this is a sigil
    ~L"""
    <div phx-window-keydown="counter">
    <h1 phx-click="count">
      <!-- could also be assigns.count -->
        <%= @count %>

      </h1>
      <h2><%= @time %></h2>
    </div>
    """
  end

  def handle_event("count", _metadata, socket) do
    {:noreply, socket |> inc |> show}
  end
  def handle_event("counter", %{"key" => "ArrowUp"}, socket) do
    {:noreply, socket |> inc |> show}
  end
  def handle_event("counter", %{"key" => "ArrowDown"}, socket) do
    {:noreply, socket |> dec |> show}
  end
  
  def handle_info(:tick, socket) do
    {:noreply, socket |> show}
  end

end
