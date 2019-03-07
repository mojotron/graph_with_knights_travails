require_relative "graph_data_structure.rb"
require_relative "linked_list_data_structure.rb"

def knight_chess_moves(board_size = 8)
  new_graph = Graph.new()
  board_size.size.times do |i|
    board_size.size.times do |j|
      new_graph.add_vertex([i,j])
    end
  end
  knights_legal_moves(new_graph)
  new_graph
end

def knights_legal_moves(graph)
  legal_positions = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
  graph.vertices.each do |vertex|
    x = vertex.value[0]
    y = vertex.value[1]
    legal_positions.each do |move|
      a = move[0]
      b = move[1]
      temp_position = [x + a, y + b]
      graph.add_edge(vertex.value, temp_position) if graph.contains?(temp_position)
    end
  end
end

x = knight_chess_moves(8)
p x.breadth_first_search([0,0],[1,2])
p x.breadth_first_search([0,0],[3,3])
p x.breadth_first_search([3,3],[0,0])
p x.breadth_first_search([3,3],[4,3])
