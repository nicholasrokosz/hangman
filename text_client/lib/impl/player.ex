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
  def interact({game, _tally = %{game_state: :won}}) do
    """
    Word: #{game.letters |> Enum.join()}
    Congrats, you won!
    """
    |> IO.puts()
  end

  def interact({game, _tally = %{game_state: :lost}}) do
    IO.puts("You lost! The word was #{game.letters |> Enum.join()}.")
  end

  def interact({game, tally}) do
    IO.puts(feedback_for_tally(tally))
    IO.puts(current_word(tally))

    Hangman.make_move(game, get_guess())
    |> interact()
  end

  ##############################################################################################################

  # :initializing | :good_guess | :bad_guess | :already_used
  def feedback_for_tally(tally = %{game_state: :initializing}) do
    "Welcome! The target word is #{tally.letters |> length} letters long."
  end

  def feedback_for_tally(%{game_state: :good_guess}), do: "Good guess!"
  def feedback_for_tally(%{game_state: :bad_guess}), do: "Sorry, that letter isn't in the word."
  def feedback_for_tally(%{game_state: :already_used}), do: "You already guessed that letter."

  ##############################################################################################################

  def current_word(tally) do
    """
    Guesses remaining: #{tally.turns_left |> to_string()}
    #{letters_guessed_output(tally.used)}
    Word: #{tally.letters |> Enum.join(" ")}
    """
  end

  def letters_guessed_output(_used = []), do: ""
  def letters_guessed_output(used), do: "Letters guessed: #{used |> Enum.join(", ")}"

  ##############################################################################################################

  def get_guess() do
    IO.gets("Guess a letter: ")
    |> to_string()
    |> String.trim()
    |> String.downcase()
  end
end
