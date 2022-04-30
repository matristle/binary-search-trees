class Node
    include Comparable

    attr_reader :data

    def initialize(data, left_child = nil, right_child = nil)
        @data = data
        @left_child = left_child
        @right_child = right_child
    end

    def <=>(other_node)
        data <=> other_node.data
    end

    def inspect
        data
    end
end

#------------------------------------

node1 = Node.new(1)
node2 = Node.new(6)
node3= Node.new(0)
node4 = Node.new(5)

p node3.between?(node1, node2)
p node4.between?(node1, node2)

p [node3, node4, node2, node1].sort

p node1.clamp(node3, node4)