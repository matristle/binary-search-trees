require_relative 'node'

class Tree

  attr_accessor :root, :value_array

  def initialize(value_array)
    @value_array = value_array
                              .sort!
                              .uniq!
    @root = build_tree(value_array)
  end

  def build_tree(value_array, start_index = 0, end_index = value_array.length - 1)
    return nil if start_index > end_index

    middle_index = (start_index + end_index) / 2
    temp_node = Node.new(value_array[middle_index])

    temp_node.left_child = build_tree(value_array, start_index, middle_index - 1)
    temp_node.right_child = build_tree(value_array, middle_index + 1, end_index)

    temp_node
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

  def level_order(queue_array = [], level_order_value_array = [], &block)
    
    queue_array.push(root)
    
    until queue_array.empty?
      current_node = queue_array.shift

      level_order_value_array.push(current_node.data)
      yield current_node if block_given?
      
      queue_array.push(current_node.left_child) unless current_node.left_child.nil?
      queue_array.push(current_node.right_child) unless current_node.right_child.nil?
    end

    return level_order_value_array unless block_given?
  end

  def inorder(current_node = root, inorder_value_array = [], &block)
    return if current_node.nil?
    
    inorder(current_node.left_child, inorder_value_array, &block)
    inorder_value_array.push(current_node.data) 
    yield current_node if block_given?
    inorder(current_node.right_child, inorder_value_array, &block)
    return inorder_value_array unless block_given?
  end

  

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

#---------------------------------------------------------------------------------

tree = Tree.new([13,5,9,3,7,15,21])

# p tree.value_array
# p tree.root

# tree.insert(5)
# tree.insert(11)
# tree.insert(-24)
# p tree.root

# tree.delete(5)

# p tree.root

# p tree.find(4)

#  tree.level_order
#  tree.level_order { |node| p node }
#  tree.level_order { |node| p node.data }

tree.pretty_print

p tree.level_order
p tree.level_order { |node| p node }

p tree.inorder
p tree.inorder { |node| p node }





