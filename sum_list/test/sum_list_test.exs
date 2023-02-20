defmodule SumListTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns the list sum" do
      # Given
      list = [1, 2, 3]

      # When
      response = SumList.call(list)

      # Then
      expected_response = 6
      assert response == expected_response
    end
  end
end
