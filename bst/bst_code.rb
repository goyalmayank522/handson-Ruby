=begin
a=5
b=4
total = a+b
puts total
=end

class NewNode
  attr_accessor :data,:left,:right
  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end
  
  
class BSTree
  attr_accessor :root
  def initialize()
    @root=nil
  end
  
  def insert_node(data)
    if @root == nil
      @root = NewNode.new(data) # new node
    else
      curr_node = @root
      prev_node = @root
      
      while curr_node
      	prev_node = curr_node
      	if data < curr_node.data
          curr_node = curr_node.left
        else 
          curr_node = curr_node.right
        end
      end
      
      if data > prev_node.data
        prev_node.right = NewNode.new(data)
      else
        prev_node.left = NewNode.new(data)
      end
    end
  end
  
  def largest_element()
    root_node = @root
    if root_node == nil
      puts "The BST is empty."
    else
      while root_node.right
        root_node = root_node.right
      end
      puts "The largest element in the BST is #{root_node.data}."
    end
  end
  
  def smallest_element()
    root_node = @root
    if root_node == nil
      puts "The BST is empty."
    else
      while root_node.left
        root_node = root_node.left
      end
      puts "The smallest element in the BST is #{root_node.data}."
    end
  end
      
  def search_element_util(temp_root, ele)
    if temp_root == nil
      return false
      #puts "Element is not found in the BST"
    elsif temp_root.data == ele
      return true
      #puts "Element is found"
    elsif ele < temp_root.data
      search_element_util(temp_root.left, ele)
    else
      search_element_util(temp_root.right, ele)
    end
  end
    
  def search_element(ele)
    return search_element_util(@root, ele)
  end  
  
  def print_in(root_node = self.root)
    if root_node == nil
      return 
    end
    print_in(root_node.left)
    print "#{root_node.data} "
    print_in(root_node.right)
  end
  
  def print_pre(root_node = self.root)
    if root_node == nil
      return 
    end
    print "#{root_node.data} "
    print_pre(root_node.left)
    print_pre(root_node.right)
  end
  
  def print_post(root_node = self.root)
    if root_node == nil
      return 
    end
    print_post(root_node.left)
    print_post(root_node.right)
    print "#{root_node.data} "
  end
  
  def print_level(root_node = self.root)
    if root_node == nil
      return 
    end
    queue = Queue.new
    queue.push(root_node)
    while queue.size > 0
      temp_node = queue.pop
      print "#{temp_node.data} "
      if temp_node.left
        queue.push(temp_node.left)
      end
      if temp_node.right
        queue.push(temp_node.right)
      end
    end
  end
  
  def print_root_to_leaf_util(arr, root_node)
    if !root_node
      return
    end
    if !root_node.left and !root_node.right
      for ele in arr do
        print "#{ele} "
      end
      puts "\n"
      return
    end
    if root_node.left
      arr << root_node.left.data
      print_root_to_leaf_util(arr, root_node.left)
      arr.pop
    end
    if root_node.right
      arr << root_node.right.data
      print_root_to_leaf_util(arr, root_node.right)
      arr.pop
    end
  end
  
  def print_root_to_leaf()
    arr = Array.new()
    arr << @root.data
    print_root_to_leaf_util(arr,@root)
  end
  
  def inorder_successor(root_node)
    while root_node.left
      root_node = root_node.left
    end
    return root_node
  end
  
  def remove_element_util(root_node, ele)
    if ele < root_node.data
      root_node.left = remove_element_util(root_node.left, ele)
    elsif ele > root_node.data
      root_node.right = remove_element_util(root_node.right, ele)
    else
      if !root_node.left and !root_node.right
        return nil
      elsif !root_node.left
        return root_node.right
      elsif !root_node.right
        return root_node.left
      else
        new_node = inorder_successor(root_node.right)
        root_node.data = new_node.data
        root_node.right = remove_element_util(root_node.right, new_node.data)
      end
    end
  end
    
    
  def remove_element(ele)
    if !search_element(ele)
      puts "Given element is not in BST. Hence, can't be removed!"
    else
      root = remove_element_util(@root, ele)
      puts "Now, the inorder traversal of BST:- "
      print_in()
      puts "\n"
    end
  end
  
end

tree = BSTree.new()
puts "Enter comma seperated elements to be inserted into BST"
array = gets.chomp.split(",")
array.each{|ele| tree.insert_node(ele)}
tree.largest_element()
tree.smallest_element()

puts "Enter any element you wanna search into BST:- "
ele = gets.chomp
if tree.search_element(ele)
 puts "Element is found!"
else
 puts "Element is not found!"
end

puts "Printing the inorder traversal of BST:- "
tree.print_in()
puts "\nPrinting the preorder traversal of BST:- "
tree.print_pre()
puts "\nPrinting the postorder traversal of BST:- "
tree.print_post()
puts "\nPrinting the levelorder traversal of BST:- "
tree.print_level()
puts "\n"

puts "Printing all paths from root to leaf:- "
tree.print_root_to_leaf()

puts "Enter the element you wanna remove from BST:- "
ele = gets.chomp
tree.remove_element(ele)

