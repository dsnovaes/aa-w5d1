class MaxIntSet
  attr_reader :store
  def initialize(max)
    @max = max
    @store = Array.new(max+1, false)
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    else
      raise 'Out of bounds'
    end
  end

  def remove(num)
    if is_valid?(num)
      @store[num] = false
    else
      raise 'Out of bounds'
    end  
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    (0..@max).include?(num)
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
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
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
    #check number of elements
    #resize if we're at num_buckets + 1
    if include?(num)
      return false
    else
      resize! if @count == num_buckets
      self[num] << num
      @count += 1
      return true
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
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.each do |bucket|
      bucket.each do |el|
        self[el] << el
      end
    end
  end
end
