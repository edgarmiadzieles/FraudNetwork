defmodule FraudNetwork do
  @moduledoc """
  Documentation for FraudNetwork.
  """

  def get_fraud_score(user, links, fraudulent_users, max_depth) do
      matrix = Matrix.create_matrix_from_links(links, %{})
      get_score_rec([user], matrix, fraudulent_users, max_depth, 1)
      #found_links = get_depth_unvisited_links([1,2,7], [], matrix, [])
      #get_depth_score(found_links, fraudulent_users, depth, 0)
  end

  def get_score_rec(users, matrix, fraudulent_users, max_depth, depth) do
    found_links = get_depth_unvisited_links(users, [], matrix, [])
    depth_score = get_depth_score(found_links, fraudulent_users, depth, 0)
  end

  def get_score_rec(_, matrix, fraudulent_users, visited, depth, depth, score) do
    score
  end

  def get_depth_score([], fraudulent_users, depth, score) do
    score
  end

  def get_depth_score([single_node_depth_users|tail], fraudulent_users, depth, score) do
    fraudulent_count = get_fraudulent_count(single_node_depth_users, fraudulent_users, 0)
    depth_score = (Enum.count(single_node_depth_users) * fraudulent_count) / depth
    get_depth_score(tail, fraudulent_users, depth, depth_score + score)
  end

  def get_depth_unvisited_links([depth_user|tail], visited, matrix, found_links) do
    found_links_for_user = get_unvisited_links(matrix[depth_user], visited, [])
    get_depth_unvisited_links(tail, found_links_for_user ++ visited, matrix, found_links ++ [found_links_for_user])
    #{visited_all, found_links} = get_unvisited_links(user_links, visited, [])
    #fraudulent_count = get_fraudulent_count(found_links, fraudulent_users, 0)
    #depth_score = (Enum.count(found_links) * fraudulent_count) / depth
    #{visited_all, found_links}
  end

  def get_depth_unvisited_links([], _, _, found_links) do
    found_links
  end

  def get_unvisited_links([user|tail], visited, found_links) do
    if Enum.member?(visited, user) do
      get_unvisited_links(tail, [user] ++ visited, found_links)
    else 
      get_unvisited_links(tail, [user] ++ visited, [user] ++ found_links)
    end
  end

  def get_unvisited_links([], _, found_links) do
    found_links
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
