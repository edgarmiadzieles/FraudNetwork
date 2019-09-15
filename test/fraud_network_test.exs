defmodule FraudNetworkTest do
  use ExUnit.Case
  doctest FraudNetwork

  test "error when inital user fraud" do
    network = [{0,1}, {0,2}]
    assert FraudNetwork.get_fraud_score(0, network, [0], 1) == {:error, -1}
  end

  test "error when initial user not in network" do
    network = [{0,1}, {0,2}]
    assert FraudNetwork.get_fraud_score(3, network, [0], 1) == {:error, -1}
  end

  test "Fraudulency at first depth with 2 links on level" do
    network = [{0,1}, {0,2}]
    assert FraudNetwork.get_fraud_score(0, network, [1], 1) == {:ok, 2}
  end

  test "Fraudulency at second depth with 2 levels and 1 fraud" do
    network = [{0,1}, {0,2}, {1,3}, {1,4}, {2,5}, {2,6}]
    frauds = [3]
    assert FraudNetwork.get_fraud_score(0, network, frauds, 2) == {:ok, 1}
  end

  test "Empty list check at requested depth" do
    network = [{0,1}, {0,2}, {1,3}, {1,4}, {2,5}, {2,6}, {5,7}, {5,8}, {5,9}]
    frauds = [3,7]
    assert FraudNetwork.get_fraud_score(0, network, frauds, 3) == {:ok, 2}
  end

  test "Stop propagation in circular links" do
    network = [{0,1}, {0,2}, {1,3}, {2,3}, {3,4}]
    frauds = [2,3]
    assert FraudNetwork.get_fraud_score(0, network, frauds, 3) == {:ok, 2.5}
  end

end
