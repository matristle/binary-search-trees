require_relative 'node'

class Tree

  attr_accessor :root, :value_array

  def initialize(value_array)
    @value_array = value_array
                  .sort
                  .uniq
    @root = build_tree(value_array)
  end

  def build_tree(value_array)

    if value_array.length == 1
      only_element = value_array[0]
      return Node.new(only_element) 
    end
    return if value_array.length == 0

    middle_index = value_array.length / 2
    middle_element = value_array[middle_index]

    temp_node = Node.new(middle_element)

    left_side_array = value_array[0..middle_index - 1]
    right_side_array = value_array[middle_index + 1..-1]

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

  def find(value, root_node = root)
    return if root_node.nil?
    return root_node if root_node.data == value
    
    if value < root_node.data
      find(value, root_node.left_child)
    elsif value > root_node.data
      find(value, root_node.right_child)
    end
  end

  def level_order(queue_array = [])
    return value_array unless block_given?

    queue_array.push(root)

    until queue_array.empty?
      current_node = queue_array.shift

      yield current_node
      
      queue_array.push(current_node.left_child) unless current_node.left_child.nil?
      queue_array.push(current_node.right_child) unless current_node.right_child.nil?
    end
  end

  def inorder
  end
end

#---------------------------------------------------------------------------------

tree = Tree.new([1,2,3,4,5,6,7])

# p tree.value_array
# p tree.root

# tree.insert(5)
# tree.insert(11)
# tree.insert(-24)
# p tree.root

# tree.delete(5)

# p tree.root

# p tree.find(4)

 tree.level_order
 tree.level_order { |node| p node }
 tree.level_order { |node| p node.data }

