load 'node.rb'

class LinkedList
	attr_reader :first, :node

	def initialize
		@first = nil
	end

	def push(object)
		@node = Node.new(object, nil)
		if !@first
			@first = @node
		else
			node = @first
			#find the last node
			while node.next != nil do
				node = node.next
			end
			node.next = @node
		end
	end

	def pop
		node = @first
		if !node
			return nil
		end
		#find the last node
		while node.next != nil do
			prev = node
			node = node.next
		end
		if @first.next == nil
			@first = nil
		else
			prev.next = nil
		end
		return node.object
	end

	def unshift(object)
		@node = Node.new(object, @first)
		@first = @node
	end

	def shift
		first_node = @first
		second_node = @first.next
		@first = second_node
		return first_node.object
	end

	def concat(otherlist)
		while otherlist.first do
			self.push(otherlist.shift)
		end
	end
end
