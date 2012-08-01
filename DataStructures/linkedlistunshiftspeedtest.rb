require 'test/unit'
load 'linkedlist.rb'

class LinkedListUnshiftSpeedTest < Test::Unit::TestCase

	def test_speed_push
		linkedlist = LinkedList.new
		100.times {linkedlist.unshift("test")}
	end

end