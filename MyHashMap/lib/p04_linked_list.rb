class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
    @next.prev = @prev
    @prev.next = @next
  end
end



class LinkedList
  # attr_accessor :head, :tail
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    res = find_by_key(key)
    return res.nil? ? nil : res.val
  end

  def include?(key)
    node = find_by_key(key)
    return !node.nil?
  end

  def append(key, val)
    new_node = Node.new(key,val)
    new_node.prev = last
    new_node.next = @tail
    last.next = new_node
    @tail.prev = new_node
  end

  def update(key, val)
    the_node = find_by_key(key)
    the_node.val = val unless the_node.nil?
  end

  def remove(key)
    find_by_key(key).remove
  end

  def each(&prc)
    current = first
    until current == @tail
      prc.call(current)
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private

  def find_by_key(key)
    current = first
    until current == @tail
      return current if current.key == key
      current = current.next
    end
    nil
  end
end
