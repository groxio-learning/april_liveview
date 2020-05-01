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
    <div phx-window-keydown="keydown">
    	<pre><%= inspect @state %></pre>
			<%= for row <- @state.rows do %>
				<div style="display: flex; flex-direction: column"><%= raw render_row(row) %></div>
			<% end %>

			<div style="display: flex; align-items: center;">
				<%= raw render_move(@state.move) %>
			</div>
			<div>
				<%= raw render_submit(@state.move) %>
			</div>

			<%= for peg <- (1..8) do %>
			<%= raw button(peg) %>
			<% end %>
    </div>

    """
  end

  def render(%{game_status: :success} = assigns) do
    ~L"""
    <div style="display: flex; flex-direction: column; align-items: center">
    <h1>Hello Master Brain</h1>
    <p> You win! (this time..) You beat 🧠</p>

    <button phx-click="start"> Start Game </button>
    </div>
    """
  end

  def render(%{game_status: :failure} = assigns) do
    ~L"""
    <div style="display: flex; flex-direction: column; align-items: center">
    <h1>Hello Master Brain</h1>
    <p> You lose! Good day sir! 🧠</p>

    <button phx-click="start"> Start Game </button>
    </div>
    """
  end

	def render_row(%{guess: guess, score: score}) do
		[
			inspect(guess), render_score(score)
		]
	end
	def render_score(%{reds: reds, whites: whites}) do
		[
			color_stream(:red) |> Enum.take(reds),
			color_stream(:white) |> Enum.take(whites)
		]
	end
	def color_stream(color) do
		Stream.repeatedly(fn -> emoji(color) end)
	end
	def emoji(:red), do: "🔴" #red emoji , windows + dot on keyboard
	def emoji(:white), do: "⚪" #white emoji, windows + dot on keyboard

  def render_move(pegs), do: pegs |> Enum.map(&render_peg/1)

  def render_submit([_,_,_,_] = _move) do
    """
    <button
     phx-click="submit"
     style="background-color:darkslateblue; border: 0.1rem solid floralwhite">Guess
    </button>
    """
  end

  def render_submit(_move), do: ""


  def render_peg(peg) do
    """
    <div style=
      "background-color: #{color(peg)};
      width: 42px; height: 42px; border-radius: 50%;
      text-align: center;
      padding-top 20px;">
      <div>#{peg}</div>
    </div>
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

  def handle_event("keydown", %{"key" => "Backspace"}, socket) do
    {:noreply, remove_peg(socket)}
  end

  # default handler to ensure that we don't crash on random key
  # strokes
  def handle_event("keydown", _metadata, socket) do
    {:noreply, socket}
  end


  def handle_event("start", _metadata, socket) do
    {:noreply, start_game(socket)}
  end

  def handle_event("guess", %{"number" => number_string}, socket) do
    {:noreply, add_peg(socket, number_string)}
  end


  def handle_event("submit", _metadata, socket) do
    {:noreply, socket |> submit_move}
  end


  # reducers

  def submit_move(%{assigns: %{board: board}} = socket) do
    socket
    |> assign(
      board: MasterBrain.submit_move(board)
    )
    |> show
    |> maybe_end
  end


  def remove_peg(%{assigns: %{board: board}} = socket) do
    socket
    |> assign(
      board: MasterBrain.remove_peg(board)
    )
    |> show
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

  def maybe_end(%{assigns: %{state: %{won: true}}} = socket) do
    socket
    |> assign(
      game_status: :success,
      score: length(socket.assigns.board.guesses)
    )
  end

  def maybe_end(%{assigns: %{state: %{lost: true}}} = socket) do
    socket
    |> assign(
      game_status: :failure,
      score: 11
    )
  end

  def maybe_end(socket), do: socket
end
