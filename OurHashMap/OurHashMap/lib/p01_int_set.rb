class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end
  
  def insert(num)
    raise "Out of bounds" if num > @store.length || num < 0
    @store.each_with_index do |ele, idx|
      if ele
        return false
      else
        @store[idx] = true if num == idx
        return true if @store[idx]
      end
    end
  end
  
  def remove(num)
    @store.each_with_index do |ele, idx|
      if ele && num == idx
        @store[idx] = false
      end
    end
  end

  def include?(num)
    @store.each_with_index do |ele, idx|
      return true if num == idx && @store[idx]
    end
    return false
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    return false unless include?(num)
    self.store.each do |subArr|
      subArr.each do |ele|
        if ele == num
          subArr.delete(ele)
        end
      end
    end
  end

  def include?(num)
    self.store.each do |subArr|
      subArr.each do |el|
        if el == num
          return true
        end
      end
    end
    return false
  end

  private

  def [](num)
    self.store[num % store.length]
  end

  def num_buckets
    self.store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    actual_num = num
    num = num.hash
    resize! if self.count >= num_buckets
    unless self.include?(actual_num)
      self[num] << actual_num
      self.count += 1
    end
  end

  def remove(num)
    return false unless include?(num)
    self.store.each do |subArr|
      subArr.each do |ele|
        if ele == num
          subArr.delete(ele)
          self.count -= 1
        end
      end
    end
  end

  def include?(num)
    self.store.each do |subArr|
      subArr.each do |el|
        if el == num
          return true
        end
      end
    end
    return false
  end

  private

  def [](num)
    self.store[num % store.length]
  end

  def num_buckets
    self.store.length
  end

  def resize!
    self.store += Array.new(self.store.length){[]}
  end
end



