require 'test/unit'
load 'linkedlist.rb'

class LinkedListSpeedTest < Test::Unit::TestCase

	def test_speed_push
		linkedlist = LinkedList.new
		100.times {linkedlist.push("test")}
	end

end