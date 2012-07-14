require 'test/unit'
load 'optimalspacearray.rb'

class OptimalSpaceArrayTest < Test::Unit::TestCase

    def test_new
	  osa = OptimalSpaceArray.new
	  assert_not_nil(osa)
	  assert_equal(0,osa.size)
    end
    def test_push
	  osa = OptimalSpaceArray.new
	  assert_equal(5, osa.push(5))
	  assert_equal(1, osa.size)
	  assert_equal(6, osa.push(6))
	  assert_equal(2, osa.size)
    end
    def test_pop
	  osa = OptimalSpaceArray.new
	  puts("pushing 5")
	  osa.push(5)
	  puts("pushing 6")
	  osa.push(6)
	  assert_equal(6, osa.pop)
	  assert_equal(5, osa.pop)
	  assert_equal(0, osa.size)
   end
   def test_shift
	  osa = OptimalSpaceArray.new
	  osa.push(5)
	  osa.push(6)
	  assert_equal(5, osa.shift)
	  assert_equal(6, osa.shift)
	  assert_equal(0, osa.size)
   end
   def test_unshift
	  osa = OptimalSpaceArray.new
	  osa.unshift(5)
	  osa.unshift(4)
	  assert_equal(5, osa.pop)
	  assert_equal(4, osa.pop)
	  assert_equal(0, osa.size)
    end
    def test_concat
	  osa = OptimalSpaceArray.new
	  osa.push(5)
	  osa.concat([6, 7, 8])
	  assert_equal(4, osa.size)
	  assert_equal(8, osa.pop)
	  assert_equal(5, osa.shift)
    end
    def test_array
	  a1 = [1, 3, 5]
	  a2 = a1
	  a1[1] = 33
	  assert_equal(33, a2[1])	# proves that the arrays point to the same data
	  #
	  a3 = a1 + [7]
	  a1[1] = 333
	  assert_equal(33, a3[1])	# proves that the arrays do not point to the same data
    end
end