class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if include?(key)
      return false
    else
      resize! if @count == num_buckets
      self[key.hash] << key
      @count += 1
      return true
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end
  end

  private

  def [](key_hash)
    # optional but useful; return the bucket corresponding to `num`
    @store[key_hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.each do |bucket|
      bucket.each do |el|
        self[el.hash] << el
      end
    end
  end
end
