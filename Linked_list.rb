class LinkedList
    class Node
        attr_accessor :value, :next_node
    
        def initialize(value = nil, link = nil)
            @value = value
            @next_node = link
        end
    end

    def append(value)
        node = Node.new(value)
        if(@first_node == nil)
            @first_node = node
        else
            tail.next_node = node
        end
    end

    def prepend(value)
        node = Node.new(value)
        if(@first_node == nil)
            @first_node = node
        else
            node.next_node = @first_node
            @first_node = node.next_node
        end
    end

    def size
        if(@first_node == nil)
            return 0
        end
        temp_node = @first_node
        counter = 1
        while(temp_node.next_node != nil)
            temp_node = temp_node.next_node
            counter += 1
        end
        return counter
    end

    def head
        return @first_node
    end

    def tail
        if(@first_node == nil)
            return nil
        end
        temp_node = @first_node
        while(temp_node.next_node != nil)
            temp_node = temp_node.next_node
        end
        return temp_node
    end

    def at(index)
        if(@first_node == nil)
            return nil
        end
        counter = 0
        current_node = @first_node
        while(@first_node.next_node != nil && counter < index)
            counter += 1
            current_node = current_node.next_node
        end
        if(counter != index)
            return nil
        end
        return current_node
    end

    def pop
        if(@first_node == nil)
            return nil
        elsif(@first_node.next_node == nil)
            return @first_node
        end

        current_node = @first_node
        next_current_node = current_node.next_node
        while(next_current_node.next_node != nil)
            current_node = next_current_node
            next_current_node = next_current_node.next_node
        end
        current_node.next_node = nil
        return next_current_node
    end

    def contains?(value)
        if(@first_node == nil)
            return false
        end

        current_node = @first_node
        while(current_node != nil)
            if(current_node.value == value)
                return true
            end
            current_node = current_node.next_node
        end
        return false
    end

    def find(value)
        if(@first_node == nil)
            return nil
        end
        
        index = 0
        current_node = @first_node
        while(current_node != nil)
            if(@current_node.value = value)
                return index
            end
            current_node = current_node.next_node
            index += 1
        end
        return nil
    end

    def to_s
        str = "nil"
        current_node = @first_node
        while(current_node != nil)
            str.prepend("( #{current_node.value} ) -> ")
            current_node = current_node.next_node
        end
        return str
    end
end

list = LinkedList.new()

list.append(42)
list.append(1)
list.append(32)

puts "Size: #{list.size}"
puts "Head: #{list.head.value}"
puts "Tail: #{list.tail.value}"
puts "List.to_s: #{list.to_s}"