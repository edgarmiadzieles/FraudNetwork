defmodule FraudNetwork do
  @moduledoc """
  Documentation for FraudNetwork.
  """

  def get_fraud_score(user, links, fraudulent_users, depth) do
      matrix = Matrix.create_matrix_from_links(links, %{})
      step(user, matrix, fraudulent_users, [], 0)
  end

  def step(current_user, matrix, fraudulent_users, visited, score) do
    fraud_count = get_fraudulent_count(matrix[current_user], fraudulent_users, visited, 0)
    
  end

  def get_fraudulent_count([user|tail], fraudulent_users, visited, count) do
    if Enum.member?(fraudulent_users, user) && !Enum.member?(visited, user) do
      get_fraudulent_count(tail, fraudulent_users, visited, count + 1)
    else 
      get_fraudulent_count(tail, fraudulent_users, visited, count)
    end
  end

  def get_fraudulent_count([], _, _, count) do
    count
  end

end
