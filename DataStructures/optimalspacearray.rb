

class OptimalSpaceArray

    def initialize
	  @array = Array.new(0)
    end

def push(value)
	  #@array = @array + [value]
	  #
	  count = @array.size
	  buffer = Array.new(count+1)
	  if count > 0
		(0..count-1).to_a.each {|n| buffer[n] = @array[n]}
	  end
	  buffer[count] = value
	  @array = buffer
	  @array.last
    end

    def pop
	  count = @array.size
	  return if count == 0
	  buffer = Array.new(count-1)
	  result = @array.last
	  if count == 1
		@array = Array.new(0)
	  else
		#buffer = @array[0..count-2]
		(0..count-2).to_a.each {|n| buffer[n] = @array[n]}
		@array = buffer
	  end
	  return result
    end

    def unshift(value)
	  count = @array.size
	  buffer = Array.new(count+1)
	  buffer[0] = value
	  #buffer.concat(@array)
	  if count > 0
		(0..count-1).to_a.each {|n| buffer[n+1] = @array[n]}
	  end
	  @array = buffer
	  @array[0]
    end

    def shift
	  count = @array.size
	  return if count == 0
	  buffer = Array.new(count-1)
	  result = @array[0]
	  if count == 1
		@array = Array.new(0)
	  else
		#@array = @array[1..count-1]
		(1..count-1).to_a.each {|n| buffer[n-1] = @array[n]}
		@array = buffer
	  end
	  return result
    end

    def concat(array_to_append)
	  #@array = @array + array_to_append
	  count = @array.size
	  count_add = array_to_append.size
	  buffer = Array.new(count+count_add)
	  if count > 0
		(0..count-1).to_a.each {|n| buffer[n] = @array[n]}
	  end
	  if count_add > 0
		(0..count_add-1).to_a.each {|n| buffer[count+n] = array_to_append[n]}
	  end
 	  @array = buffer
    end

    def size
	  @array.size
    end

end
