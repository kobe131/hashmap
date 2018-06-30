require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |e1,i1|
      save = e1*i1 
      result += save
    end 
    result 
  end
end

class String
  def hash
    result = 0
    
    self.split("").each_with_index do |c,i|
      result += ((c.ord - 'a'.ord)*i)
    end
    result
    
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    
    self.each do |k,v|
      result += (k.to_s.ord - 'a'.ord) * v.ord
      
    end
    result
  end
end
