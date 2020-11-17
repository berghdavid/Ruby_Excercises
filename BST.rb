class Tree
    attr_reader :root

    def initialize(array)
        @root = nil
    end

    class Node
        include Comparable
        attr_accessor :value, :r_child, :l_child
    
        def <=> (other)
            value <=> other.value
        end

        def initialize(value = nil, r_child = nil, l_child = nil)
            @value = value
            @r_child = r_child
            @l_child = l_child
        end
    end

    def build_tree(array)
        arr = array.uniq.sort
        current_root = Node.new(arr.delete_at(arr.length/2))
        current_root.r_child = build_tree(arr[(arr.length/2)..arr.length-1])
        current_root.l_child = build_tree(arr[(arr.length/2)..arr.length-1])
    end
end