class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    res = 0
    self.each_with_index do |el,i|
      subres = el.hash + i.hash
      res ^= subres
    end
    res
  end
end

class String
  def hash
    res = 0
    self.bytes.each.with_index do |el,i|
      subres = el.hash + i.hash
      res ^= subres
    end
    res
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    res = 0
    self.each do |k,v|
      subres = k.hash + v.hash
      res ^= subres
    end
    res
  end
end