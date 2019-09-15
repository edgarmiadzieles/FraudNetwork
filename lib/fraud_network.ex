defmodule FraudNetwork do
  @moduledoc """
  Documentation for FraudNetwork.
  """

  def get_fraud_score(user, links, fraudulent_users, depth) do
      matrix = Matrix.create_matrix_from_links(links, %{})
      get_depth_score(user, matrix, fraudulent_users, [], depth, 0)
  end

  def get_depth_score(current_user, matrix, fraudulent_users, visited, depth, score) do
    {visited_all, found_links} = get_unvisited_links(matrix[current_user], visited, [])
    fraudulent_count = get_fraudulent_count(found_links, fraudulent_users, 0)
    (Enum.count(found_links) * fraudulent_count) / depth
  end

  def get_unvisited_links([user|tail], visited, found_links) do
    if Enum.member?(visited, user) do
      get_unvisited_links(tail, [user] ++ visited, found_links)
    else 
      get_unvisited_links(tail, [user] ++ visited, [user] ++ found_links)
    end
  end

  def get_unvisited_links([], visited, found_links) do
    { visited, found_links }
  end

  def get_fraudulent_count([], _, count) do
    count
  end

  def get_fraudulent_count([user|tail], fraudulent_users, count) do
    if Enum.member?(fraudulent_users, user) do
      get_fraudulent_count(tail, fraudulent_users, count + 1)
    else
      get_fraudulent_count(tail, fraudulent_users, count)
    end
  end

end
