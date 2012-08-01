class Node
	attr_accessor :object, :next

	def initialize(object, next_node)
		@object = object
		@next = next_node
	end

	def to_s
		@object.to_s
	end

end
