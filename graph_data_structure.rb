require_relative "linked_list_data_structure.rb"

class Graph
  class Vertex
    attr_accessor :value, :edges, :parent, :color, :distance, :finised
    def initialize(value)
      @value = value
      @edges = LinkedList.new()
      @parent = nil
      @color = 'white'
      @distance = Float::INFINITY
      @finised = 0
    end
  end

  attr_accessor :vertices
  def initialize()
    @vertices = Array.new()
  end

  def print_graph()
    @vertices.each { |vertex| puts "#{vertex.value}>>#{vertex.edges.get_list()}"}
  end

  def contains?(value)
    @vertices.each { |vertex| return true if vertex.value == value }
    false
  end

  def search(value)
    @vertices.each { |vertex| return vertex if vertex.value == value }
    nil
  end

  def add_vertex(value)
    return nil if self.contains?(value)
    @vertices << Vertex.new(value)
  end

  def connected?(value_a, value_b)
    self.search(value_a).edges.contains?(value_b)
  end

  def add_edge(value_a, value_b)
    a = search(value_a)
    return nil if a == nil
    b = search(value_b)
    return nil if b == nil
    return nil if self.connected?(value_a, value_b)
    a.edges.append(value_b)

  end

  def delete(value)
    temp_vertex = self.search(value)
    @vertices.delete(temp_vertex)
    @vertices.each do |vertex|
      if vertex.edges.contains?(value)
        vertex.edges.delete(value)
      end
    end
    temp_vertex.value
  end

  def delete_edge(value_a, value_b)
    return nil if !self.connected?(value_a, value_b)
    self.search(value_a).edges.delete(value_b)
  end

  def clean_for_search()
    @vertices.each do |vertex|
      vertex.parent = nil
      vertex.color = 'white'
      vertex.distance = Float::INFINITY
      vertex.finised = 0
    end
  end

  def breadth_first_search(start_vertex, target_vertex)
    self.clean_for_search()
    start = search(start_vertex)
    start.distance = 0
    start.color = 'gray'
    start.parent = nil
    queue = Array.new
    queue << start
    until queue.empty?
      temp_vertex = queue.shift()
      current = temp_vertex.edges.head
      until current == nil
        current_vertex = search(current.value)
        if current_vertex.color == 'white'
          current_vertex.color = 'gray'
          current_vertex.distance = temp_vertex.distance + 1
          current_vertex.parent = temp_vertex.value
          queue << current_vertex
        end
        current = current.link
      end
      temp_vertex.color = 'black'
    end 
    bfs_path(target_vertex)
  end

  def depth_first_search(start_vertex, target_vertex)
    self.clean_for_search()
    time = 0
    @vertices.each do |vertex|
      if vertex.color == 'white'
        dfs_visit(vertex, time)
      end
    end
    dfs_path(target_vertex, start_vertex)
  end

  def dfs_visit(vertex, time)
    time = time + 1
    vertex.distance = time
    vertex.color = 'gray'
    current = vertex.edges.head
    until current == nil
      current_vertex = search(current.value)
      if current_vertex.color == 'white'
        current_vertex.parent = vertex.value
        dfs_visit(current_vertex, time)
      end
      current = current.link
    end
    vertex.color = 'black'
    time = time + 1
    vertex.finised = time
  end

  def bfs_path(end_vertex)
    path = []
    x = search(end_vertex)
    until x.parent == nil
      path << x.value
      x = search(x.parent)
    end
    path << x.value
    path.reverse
  end

  def dfs_path(end_vertex, start_vertex)
    path = []
    x = search(end_vertex)
    until x.parent == start_vertex
      path << x.value
      x = search(x.parent)
    end
    path += [x.value, x.parent]
    path.reverse
  end
end

x = Graph.new()
x = Graph.new()
x.add_vertex('S')
x.add_vertex('A')
x.add_vertex('B')
x.add_vertex('C')
x.add_vertex('D')
x.add_vertex('E')
x.add_vertex('F')
x.add_vertex('G')
x.add_vertex('S')
x.add_edge('S', 'A')
x.add_edge('A', 'S')
x.add_edge('S', 'B')
x.add_edge('B', 'S')
x.add_edge('S', 'C')
x.add_edge('C', 'S')
x.add_edge('A', 'D')
x.add_edge('D', 'A')
x.add_edge('B', 'E')
x.add_edge('E', 'B')
x.add_edge('C', 'F')
x.add_edge('F', 'C')
x.add_edge('D', 'G')
x.add_edge('G', 'D')
x.add_edge('E', 'G')
x.add_edge('G', 'E')
x.add_edge('F', 'G')
x.add_edge('G', 'F')
x.add_edge('F', 'C')
x.add_edge('F', 'C')
x.add_edge('F', 'C')
x.print_graph()
p x.depth_first_search('S','C')
