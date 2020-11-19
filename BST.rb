class Tree
    attr_reader :root

    def initialize(array)
        @root = build_tree(array)
    end

    class Node
        include Comparable
        attr_accessor :value, :right, :left
    
        def <=>(other)
            value2 = other.class == Node ? other.value : other
            @value <=> value2
        end

        def to_s
            @value.to_s
        end

        def initialize(value = nil, right = nil, left = nil)
            @value = value
            @right = right
            @left = left
        end
    end

    private def build_tree(array)
        arr = array.uniq.sort
        splitter = arr.length/2
        current_root = Node.new(arr[splitter])
        
        if(arr.length > 2)
            current_root.right = build_tree(arr[splitter+1..arr.length-1])
            current_root.left = build_tree(arr[0..splitter-1])
        elsif(arr.length == 2)
            current_root.left = Node.new(arr[0])
        end
        return current_root
    end

    public def insert(value, current_node = @root)
        if(current_node != nil)
            if(value < current_node.value)
                if(current_node.left == nil)
                    current_node.left = Node.new(value)
                else
                    insert(value, current_node.left)
                end
            elsif(value > current_node.value)
                if(current_node.right == nil)
                    current_node.right = Node.new(value)
                else
                    insert(value, current_node.right)
                end
            end
        else 
            current_node = Node.new(value)
        end
    end

    public def delete(value, current_node = @root, parent_node = nil)
        if(current_node != nil)
            if(value < current_node.value && current_node.left != nil)
                delete(value, current_node.left, current_node)
            elsif(value > current_node.value && current_node.right != nil)
                delete(value, current_node.right, current_node)
            elsif(value == current_node.value)
                successor = remove_inorder_successor(current_node, parent_node)
                puts "CURRVAL #{current_node.value}"
                puts "Succ #{successor.value}"
                if(successor.value != current_node)
                    successor.left = current_node.left
                    successor.right = current_node.right
                    if(parent_node != nil)
                        if(parent_node.value > current_node.value)
                            parent_node.left = successor
                        else
                            parent_node.right = successor
                        end
                    else
                        @root = successor
                    end
                end

                current_node = nil
            end
        end
    end

    private def remove_inorder_successor(current_node, parent_node)
        if(current_node.left != nil)
            remove_inorder_successor(current_node.left, current_node)
        elsif(current_node.right != nil)
            remove_inorder_successor(current_node.right, current_node)
        else
            if(parent_node != nil)
                if(parent_node.value > current_node.value)
                    parent_node.left = nil
                else
                    parent_node.right = nil
                end
            end
            return current_node
        end
    end

    public def find(value, current_node = @root)
        if(current_node.value == value)
            return current_node
        elsif(value < current_node.value && current_node.left != nil)
            return find(value, current_node.left)
        elsif(value > current_node.value && current_node.right != nil)
            return find(value, current_node.right)
        else
            return nil
        end
    end

    def level_order_recursive(queue = [@root])
        return [] if queue.empty?
  
        node = queue.shift
        queue << node.left unless node.left.nil?
        queue << node.right unless node.right.nil?
        [node.value].concat(level_order_recursive(queue))
      end

    public def print_tree_inorder(current_node = @root)
        if(current_node != nil)
            if(current_node.left != nil)
                print_tree_inorder(current_node.left)
            end
            puts current_node.value
            if(current_node.right != nil)
                print_tree_inorder(current_node.right)
            end
        end
    end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.print_tree_inorder

tree.insert(2)
tree.print_tree_inorder

tree.delete(8)
tree.print_tree_inorder

tree.level_order_recursive