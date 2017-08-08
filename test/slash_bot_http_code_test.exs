defmodule SlashBotHttpCodeTest do
  use ExUnit.Case
  doctest SlashBotHttpCode

  test "greets the world" do
    assert SlashBotHttpCode.hello() == :world
  end
end
