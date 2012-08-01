require 'test/unit'
load 'linkedlist.rb'

class LinkedListTest < Test::Unit::TestCase

	def test_pop_empty_list
		linkedlist = LinkedList.new
		assert nil == linkedlist.pop, "pop from empty list should return nil"
	end

	def test_push
		linkedlist = LinkedList.new
		linkedlist.push("first")
		assert "first" == linkedlist.first.to_s, "initial push should add an object to the list"
	end

	def test_pop
		linkedlist = LinkedList.new
		linkedlist.push("first")
		linkedlist.push("second")
		assert "second" == linkedlist.pop, "pop should return the last node object"
		assert "first" == linkedlist.pop, "pop should return the last node object"
	end

	def test_unshift
		linkedlist = LinkedList.new
		linkedlist.unshift("second")
		linkedlist.unshift("first")
		assert "first" == linkedlist.first.to_s, "unshift inserts at the front"
	end

	def test_shift
		linkedlist = LinkedList.new
		linkedlist.push("first")
		linkedlist.push("second")
		assert "first" == linkedlist.shift, "shift should return the first node object"
		assert "second" == linkedlist.shift, "another shift should return the second node object"
	end

	def test_concat
		linkedlist1 = LinkedList.new
		linkedlist1.push("first")
		linkedlist1.push("second")
		linkedlist2 = LinkedList.new
		linkedlist2.push("third")
		linkedlist2.push("fourth")
		linkedlist1.concat(linkedlist2)
		assert "fourth" == linkedlist1.pop, "concat should result in \'fourth\' at end"
	end
end
