require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    is_valid?(num)
    @store[num-1] = true 
  end

  def remove(num)
    is_valid?(num)
    @store[num-1] = false 
  end

  def include?(num)
    is_valid?(num)
    @store[num-1]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num >= @store.length || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num) if include?(num)
    
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # debugger if num == 20
    resize! if count == num_buckets
    unless include?(num)
      self[num] << num 
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) {[]}
    @store.each_with_index do |bucket, idx|
      
      bucket.each do |el|
        new_store[el % new_store.length] << el
      end
    end
    
    # bye
    @store = new_store
  end
end
