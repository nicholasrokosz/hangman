defmodule TextClient.Impl.Player do
  @typep game :: Hangman.game()
  @typep tally :: Hangman.tally()
  @typep state :: {game, tally}

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  ##############################################################################################################

  @spec interact(state()) :: :ok
  def interact({_game, _tally = %{game_state: :won}}) do
    IO.puts("Congrats, you won!")
  end

  def interact({_game, tally = %{game_state: :lost}}) do
    IO.puts("You lost! The word was #{tally.letters |> Enum.join()}")
  end

  def interact({_game, tally}) do
    IO.puts(feedback_for_tally(tally))
    # display state
    # get next guess
    # make move
    # recurse
  end

  ##############################################################################################################

  # :initializing | :good_guess | :bad_guess | :already_used
  def feedback_for_tally(tally = %{game_state: :initializing}) do
    "Welcome! I'm thinking of a #{tally.letters |> length} letter word."
  end

  def feedback_for_tally(%{game_state: :good_guess}), do: "Good guess!"
  def feedback_for_tally(%{game_state: :bad_guess}), do: "Sorry, that letter isn't in the word."
  def feedback_for_tally(%{game_state: :already_used}), do: "You already guessed that letter."
end
