defmodule TextClient.Impl.Player do
  @typep game :: Hangman.game()
  @typep tally :: Hangman.tally()
  @typep state :: {game, tally}

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    interact({game, tally})
  end

  @spec interact(state()) :: :ok
  def interact(state) do
    :ok
    # feedback
    # display state
    # get next guess
    # make move
    # recurse
  end
end
