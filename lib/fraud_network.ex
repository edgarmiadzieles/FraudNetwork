defmodule FraudNetwork do
  @moduledoc """
  Finds fraudulency score of a user based on it's network.
  """

  def get_fraud_score(user, links, fraudulent_users, max_depth) do
    if Enum.member?(fraudulent_users, user) do
      {:error, -1}
    else
      matrix = Matrix.create_matrix_from_links(links, %{})

      if matrix[user] == nil do
        {:error, -1}
      else
        score = get_score_recurisive([user], matrix, fraudulent_users, max_depth, [user], 0, 0)
        {:ok, score}
      end
    end
  end

  @doc """
  Returns the score sum of each depth
  """
  def get_score_recurisive(_, _, _, max_depth, _, max_depth, score) do
    score
  end

  def get_score_recurisive([], _, _, _, _, _, score) do
    score
  end

  def get_score_recurisive(users, matrix, fraudulent_users, max_depth, visited, depth, score) do
    current_depth = depth + 1
    found_links = get_depth_unvisited_links(users, visited, matrix, [])
    found_links_flatten = List.flatten(found_links)
    depth_score = get_depth_score(found_links, fraudulent_users, current_depth, 0)

    get_score_recurisive(
      found_links_flatten,
      matrix,
      fraudulent_users,
      max_depth,
      found_links_flatten ++ visited,
      current_depth,
      score + depth_score
    )
  end

  @doc """
  Score for each level is calculated separately and then summed up.
  """
  def get_depth_score([], _, _, score) do
    score
  end

  def get_depth_score([single_node_depth_users | tail], fraudulent_users, depth, score) do
    fraudulent_count = get_fraudulent_count(single_node_depth_users, fraudulent_users, 0)
    depth_score = Enum.count(single_node_depth_users) * fraudulent_count / depth
    get_depth_score(tail, fraudulent_users, depth, depth_score + score)
  end

  @doc """
  A depth of n can have many nodes with it's links. 
  This functions finds the unvisited ones for each node in current depth.
  """
  def get_depth_unvisited_links([depth_user | tail], visited, matrix, found_links) do
    found_links_for_user = get_unvisited_links(matrix[depth_user], visited, [])

    get_depth_unvisited_links(
      tail,
      found_links_for_user ++ visited,
      matrix,
      found_links ++ [found_links_for_user]
    )
  end

  def get_depth_unvisited_links([], _, _, found_links) do
    found_links
  end

  @doc """
  Returns unvisited links of a given node (level).
  """
  def get_unvisited_links([user | tail], visited, found_links) do
    if Enum.member?(visited, user) do
      get_unvisited_links(tail, [user] ++ visited, found_links)
    else
      get_unvisited_links(tail, [user] ++ visited, [user] ++ found_links)
    end
  end

  def get_unvisited_links([], _, found_links) do
    found_links
  end

  @doc """
  Get fradulent users count in given list
  """
  def get_fraudulent_count([], _, count) do
    count
  end

  def get_fraudulent_count([user | tail], fraudulent_users, count) do
    if Enum.member?(fraudulent_users, user) do
      get_fraudulent_count(tail, fraudulent_users, count + 1)
    else
      get_fraudulent_count(tail, fraudulent_users, count)
    end
  end
end
