defmodule Day3 do
  @moduledoc """
  Documentation for Day3.
  """

  @type tree :: integer
  @type open_squares :: integer
  @type pos :: {integer, integer}
  @type state :: %{status: :cont | :halt, pos: pos, state: {tree, open_squares}}

  def multiply_trees() do
    Enum.reduce(slopes(), 0, fn trees, acc ->
      if acc === 0 do
        trees
      else
        acc * trees
      end
    end)
  end

  def slopes() do
    [
      getTrees(1, 1),
      getTrees(3, 1),
      getTrees(5, 1),
      getTrees(7, 1),
      getTrees(1, 2)
    ]
  end

  def getTrees(right, down) do
    right
    |> run(down)
    |> Map.get(:state, {0, 0})
    |> elem(0)
  end

  def run(right, down) do
    start(%{status: :cont, pos: {0, 0}, state: {0, 0}}, {right, down}, TreeMap.get())
  end

  @spec start(state, {integer, integer}, [binary]) :: state
  def start(state, {right, down}, list) do
    state
    |> going_down(down)
    |> going_right(right)
    |> check({right, down}, list)
  end

  @spec check(state, integer, [binary]) :: state
  def check(%{status: :halt} = state, _, _) do
    state
  end

  def check(%{status: :cont, pos: {x, y}} = state, step, list) do
    with line when is_binary(line) <- Enum.at(list, y),
         char when is_binary(char) <- String.at(line, x) do
      state
      |> update_state(char)
      |> start(step, list)
    else
      _ ->
        %{state | status: :halt}
    end
  end

  def update_state(%{state: {x, o}} = state, char) do
    case char do
      "#" ->
        %{state | state: {x + 1, o}}

      "." ->
        %{state | state: {x, o + 1}}

      unkown ->
        IO.inspect(unkown)
        raise "aliens!"
    end
  end

  @spec going_down({[binary], state}, integer) :: state
  def going_down(%{pos: {x, y}} = state, step) do
    %{state | pos: {x, y + step}}
  end

  @spec going_right(state, integer) :: state
  def going_right(%{pos: {x, y}} = state, step) do
    next = x + step

    if next < 31 do
      %{state | pos: {next, y}}
    else
      %{state | pos: {next - 31, y}}
    end
  end
end
