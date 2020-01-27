defmodule Gallows.Views.Helpers.GameStateHelper do
  import Phoenix.HTML, only: [ raw: 1 ]

  @responses %{
    :won => { :success, "You WON!" },
    :good_guess => { :success, "Good guess!" },
    :bad_guess => { :warning, "Bad guess" },
    :lost => { :danger, "You lost..." },
    :already_used => { :info, "You already guessed that" },
  }

  def game_state(state) do
    @responses[state]
    |> alert()
  end

  defp alert(nil), do: ""
  defp alert({class, msg}) do
    """
    <div class="alert alert-#{ class }">
      #{ msg }
    </div>
    """
    |> raw()
  end
end
