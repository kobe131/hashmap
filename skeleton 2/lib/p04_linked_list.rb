require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  
  attr_accessor :head, :tail
  
  def initialize
    @head = Node.new
    @tail = Node.new   
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end
  
  def inspect
    "head #{head} tail #{tail}"
  end

  def first
    return @head.next
  end

  def last
    return @tail.prev 
  end

  def empty?
    first == nil 
  end

  def get(key)
    node_pointer = head.next 
    until node_pointer == nil
      if node_pointer.key == key 
        return node_pointer.val 
      end
      node_pointer = node_pointer.next 
    end  
    return nil 
  end

  def include?(key)
    # byebug
    node_pointer = head.next unless head.nil?
    until node_pointer == nil
      if node_pointer.key == key 
        return true
      end
      node_pointer = node_pointer.next 
    end  
    return false 
    
    
  end

  def append(key, val)
    new_node = Node.new(key,val)
    if empty?
      head.next = new_node
      new_node.prev = head
      new_node.next = tail
      tail.prev = new_node
    else
      tail.prev.next = new_node
      new_node.next = tail
      new_node.prev = tail.prev
      tail.prev = new_node
    end
  end

  def update(key, val)
    node_pointer = head.next
    until node_pointer.nil?
      if node_pointer.key == key
        node_pointer.val = val
        break
      end
      node_pointer = node_pointer.next
      
    end
  end

  def remove(key)
    node_pointer = head.next 
    #debugger
    until node_pointer == nil
      if node_pointer.key == key
        node_pointer.prev.next = node_pointer.next
        node_pointer.next.prev = node_pointer.prev 
        return 
      end
      node_pointer = node_pointer.next 
    end  
    return nil 
  end 
    


  def each
    unless empty?
      node_pointer = head.next
      
      until node_pointer.next.nil?
        yield node_pointer
        node_pointer = node_pointer.next
      end
    end
    
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
