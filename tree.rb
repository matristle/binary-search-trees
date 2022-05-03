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
    return if array.length == 0

    middle_index = array.length / 2
    middle_element = array[middle_index]

    temp_node = Node.new(middle_element)

    left_side_array = array[0..middle_index - 1]
    right_side_array = array[middle_index + 1..-1]

    temp_node.left_child = build_tree(left_side_array)
    temp_node.right_child = build_tree(right_side_array) 

    return temp_node
  end

  def insert(value, temp_node = root)
    if temp_node.nil?
      temp_node = Node.new(value)
      return temp_node
    end

    if value < temp_node.data
      temp_node.left_child = insert(value, temp_node.left_child)
    elsif value > temp_node.data
      temp_node.right_child = insert(value, temp_node.right_child)
    end

    return temp_node
  end

  def delete(value, root_node = root)
    return root_node if root_node.nil?

    if value < root_node.data
      root_node.left_child = delete(value, root_node.left_child)
    elsif value > root_node.data
      root_node.right_child = delete(value, root_node.right_child)
    else
      if root_node.left_child.nil?
        temp_node = root_node.right_child
        root_node = nil
        return temp_node
      elsif root_node.right_child.nil?
        temp_node = root_node.left_child
        root_node = nil
        return temp_node
      end
    end
      
    return root_node
  end

  
end

#---------------------------------------------------------------------------------

tree = Tree.new([2,3,4,6,8,3,1])

p tree.array
# p tree.root

tree.insert(5)
tree.insert(11)
tree.insert(-24)
p tree.root

tree.delete(5)

p tree.root
