#not complete LL implementation, this is helper class for Graph class
class LinkedList
  class Node
    attr_accessor :value, :link
    def initialize(value)
      @value = value
      @link = nil
    end
  end

  attr_accessor :head, :tail
  def initialize()
    @head = nil
    @tail = nil
  end

  def get_list()
    container = Array.new
    temp_node = @head
    until temp_node == nil
      container << temp_node.value
      temp_node = temp_node.link
    end
    container
  end

  def contains?(value)
    temp_node = @head
    until temp_node == nil
      return true if temp_node.value == value
      temp_node = temp_node.link
    end
    false
  end

  def append(value)
    new_node = Node.new(value)
    if @head == nil
      @head = new_node
      @tail = new_node
    else
      @tail.link = new_node
      @tail = @tail.link
    end
  end

  def delete(value)
    return nil if !self.contains?(value)
    if @head.value == value
      if @head == @tail
        @head = nil
        @tail = nil
        return
      end
      return @head = @head.link
    end
    temp_node = @head.link
    prev_node = @head
    until temp_node == nil
      if temp_node.value == value
        prev_node.link = temp_node.link
        @tail = prev_node if @tail == value
        return
      end
      temp_node = temp_node.link
      prev_node = prev_node.link
    end
  end

end

