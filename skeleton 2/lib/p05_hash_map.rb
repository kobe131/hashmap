require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    #byebug
    
    if bucket(key).include?(key)
      bucket(key).update(key,val)
    else 
      bucket(key).append(key,val)
      @count += 1
    end 
  end

  def get(key)    
    bucket(key).get(key)
  end

  def delete(key)
    
    if bucket(key).include?(key)
      bucket(key).remove(key)
      @count -= 1
    end 
  end

  def each
    # byebug
    
    @store.each do |buckets|
       buckets.each {|node| yield [node.key,node.val]}
    end 
  end
  
  def inspect
    "size #{num_buckets}"
  end

  
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end
  
  

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
  end

  def bucket(key)
    
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
    
  end
end
