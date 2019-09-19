defmodule Matrix do
  def create_matrix_from_links([link | tail], matrix) do
    matrix = add_link_to_key_in_matrix(elem(link, 0), elem(link, 1), matrix)
    matrix = add_link_to_key_in_matrix(elem(link, 1), elem(link, 0), matrix)
    create_matrix_from_links(tail, matrix)
  end

  def create_matrix_from_links([], matrix) do
    matrix
  end

  def add_link_to_key_in_matrix(key, link, matrix) do
    key_links = if nil == matrix[key], do: [], else: matrix[key]
    Map.put(matrix, key, [link | key_links])
  end
end
