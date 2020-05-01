defmodule MasterBrainWeb.GameLive do
  alias MasterBrain.Board, as: Board
  use MasterBrainWeb, :live_view
  import Phoenix.HTML, only: [raw: 1]

  def mount(_params, _session, socket) do
    {:ok, assign(socket, game_status: :idle)}
  end

  def render(%{game_status: :idle} = assigns) do
    ~L"""
    <div style="display: flex; flex-direction: column; align-items: center">
    <h1>Hello Master Brain</h1>
    <p> Welcome to the MASTER BRAIN 🧠</p>

    <button phx-click="start"> Start Game </button>
    </div>
    """
  end

  def render(%{game_status: :playing} = assigns) do
    ~L"""
    <pre><%= inspect @state %></pre>

    <%= for peg <- (1..8) do %>
    <%= raw button(peg) %>
    <% end %>
    """
  end

  def button(number) do
    """
    <button phx-click="guess" phx-value-number="#{number}" style="color: #{text_color(number)}; background-color: #{color(number)}; border: 0.1rem solid floralwhite">#{number}</button>
    """
  end

  def color(1), do: :rosybrown
  def color(2), do: :lightseagreen
  def color(3), do: :darksalmon
  def color(4), do: :sienna
  def color(5), do: :darkslategray
  def color(6), do: :peachpuff
  def color(7), do: :midnightblue
  def color(8), do: :darkslateblue

  def text_color(n) when n in [6], do: :midnightblue
  def text_color(_), do: :floralwhite

  def handle_event("start", _metadata, socket) do
    {:noreply, start_game(socket)}
  end

  def handle_event("guess", %{"number" => number_string}, socket) do
    {:noreply, add_peg(socket, number_string)}
  end

  def add_peg(%{assigns: %{board: board}} = socket, peg) do
    socket
    |> assign(
      board: MasterBrain.add_peg(board, String.to_integer(peg))
    )
    |> show
  end

  defp start_game(socket) do
    socket
    |> assign(
      game_status: :playing,
    board: Board.new()
    )
    |> show
  end

  def show(%{assigns: %{board: board}} = socket) do
    socket
    |> assign(
      state: Board.to_hash(board)
    )
  end
end
