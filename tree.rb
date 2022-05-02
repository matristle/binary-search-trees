require_relative 'node'

class Tree

  attr_accessor :root, :array

  def initialize(array)
    @array = array
                  .sort
                  .uniq
    @root = build_tree(array)
  end

  def build_tree(array)

    if array.length == 1
      only_element = array[0]
      return Node.new(only_element) 
    end
    return nil if array.length == 0

    middle_index = array.length / 2
    middle_element = array[middle_index]

    temp_node = Node.new(middle_element)

    left_side_array = array[0..middle_index - 1]
    right_side_array = array[middle_index + 1..-1]

    temp_node.left_child = build_tree(left_side_array)
    temp_node.right_child = build_tree(right_side_array) 

    return temp_node
  end
end

#---------------------------------------------------------------------------------

tree = Tree.new([2,3,4,6,8,3,1])

p tree.array
p tree.root