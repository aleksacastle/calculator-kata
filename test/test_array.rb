require 'test_helper'

class TestArray < Minitest::Test
  def setup
    @list = [1, 2, 3, 4, 5, 6]
  end
  
  # in_groups_of method
  def test_inGroupsOf_Error
    assert_raises(ArgumentError){ in_groups_of(-1) }
  end
  def test_inGroupsOf_fillWithFalse
    assert_equal([[1, 2, 3, 4], [5, 6]], in_groups_of(4, false))
  end

# fill_with_types
  def test_inGroupsOf_fillWithNil
    assert_equal([[1, 2, 3, 4], [5, 6, nil, nil]], in_groups_of(4, nil))
  end
  def test_inGroupsOf_fillWithString
    assert_equal([[1, 2, 3, 4], [5, 6, "w", "w"]], in_groups_of(4, "w"))
  end
  def test_inGroupsOf_fillWithInt
    assert_equal([[1, 2, 3, 4], [5, 6, 5, 5]], in_groups_of(4, 5))
  end
  def test_inGroupsOf_withoutFill
    assert_equal([[1, 2, 3], [4, 5, 6]], in_groups_of(3, 5))
  end

  # in_groups
  def test_inGroups_Nil
    assert_raises(ZeroDivisionError){in_groups(0)}
  end
  def test_inGroups_lessThanArrayLength
    assert_equal([[1, 2], [3, 4], [5, 6]], in_groups(3, nil))
  end
  def test_inGroups_greaterThanArrayLength
    assert_equal([[1], [2], [3], [4], [5], [6], [nil]], in_groups(7, nil))
  end
  def test_inGroups_greaterThanArrayLength
    assert_equal([[1], [2], [3], [4], [5], [6], []], in_groups(7, false))
  end

  # split
  def test_split_zero
    assert_equal([@list], split(0))
  end
  def test_split_first
    assert_equal([[], [2, 3, 4, 5, 6]], split(1))
  end
  def test_split_middle
    assert_equal([[1, 2], [4, 5, 6]], split(3))
  end
  def test_split_last
    assert_equal([[1, 2, 3, 4, 5], []], split(6))
  end

  # from method
  def test_From
    assert_equal([5, 6], @list.from(4))
  end

  # to method
  def test_To_Positive
    assert_equal([1, 2, 3, 4], @list.to(3))
  end
  def test_To_Negative
    assert_equal([1, 2, 3, 4], @list.to(-3))
  end

  private

  def in_groups_of(number, fill_with = nil)
    @list.in_groups_of(number, fill_with)
  end
  def in_groups(number, fill_with = nil)
    @list.in_groups(number, fill_with)
  end
  def split(value)
    @list.split(value)
  end
end
