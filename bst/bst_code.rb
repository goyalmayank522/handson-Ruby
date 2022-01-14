=begin
a=5
b=4
total = a+b
puts total
=end

class NewNode
  attr_accessor :data, :left, :right
  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end
  
  
class BSTree
  attr_accessor :root, :inorder_arr, :preorder_arr, :postorder_arr, :levelorder_arr, :large_ele, :small_ele
  def initialize()
    @root = nil
    @inorder_str = ""
    @preorder_str = ""
    @postorder_str = ""
    @levelorder_str = ""
    @large_ele = ""
    @small_ele = ""
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
  
  def largest_element(print = true)
    root_node = @root
    temp = ""
    if root_node == nil
      temp = "The BST is empty. Hence, no largest element found!"
    else
      while root_node.right
        root_node = root_node.right
      end
      temp = "The largest element in the BST is #{root_node.data}."
    end
    if print
      puts temp
      puts "\n"
    end
    @large_ele << temp
  end
  
  def smallest_element(print = true)
    root_node = @root
    temp = ""
    if root_node == nil
      temp = "The BST is empty. Hence, no smallest element found!"
    else
      while root_node.left
        root_node = root_node.left
      end
      temp = "The smallest element in the BST is #{root_node.data}."
    end
    if print
      puts temp
      puts "\n"
    end
    @small_ele << temp
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
  
  def print_in(root_node = self.root, print = true)
    if root_node == nil
      return 
    end
    print_in(root_node.left, print)
    if print
      print "#{root_node.data} "
    end
    @inorder_str += root_node.data + " "
    print_in(root_node.right, print)
  end
  
  def print_pre(root_node = self.root, print = true)
    if root_node == nil
      return 
    end
    if print
      print "#{root_node.data} "
    end
    @preorder_str += root_node.data + " "
    print_pre(root_node.left, print)
    print_pre(root_node.right, print)
  end
  
  def print_post(root_node = self.root, print = true)
    if root_node == nil
      return 
    end
    print_post(root_node.left, print)
    print_post(root_node.right, print)
    if print
      print "#{root_node.data} "
    end
    @postorder_str += root_node.data + " "
  end
  
  def print_level(root_node = self.root, print = true)
    if root_node == nil
      return 
    end
    queue = Queue.new
    queue.push(root_node)
    while queue.size > 0
      temp_node = queue.pop
      if print
        print "#{temp_node.data} "
      end
      @levelorder_str += temp_node.data + " "
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
    if !root_node
      return nil
    elsif ele < root_node.data
      root_node.left = remove_element_util(root_node.left, ele)
    elsif ele > root_node.data
      root_node.right = remove_element_util(root_node.right, ele)
    else
      if !root_node.left and !root_node.right
        root_node = nil
      elsif !root_node.left
        root_node = root_node.right
      elsif !root_node.right
        root_node = root_node.left
      else
        new_node = inorder_successor(root_node.right)
        root_node.data = new_node.data
        root_node.right = remove_element_util(root_node.right, new_node.data)
      end
    end
    root_node
  end
    
    
  def remove_element(ele, root_node = @root)
    if !search_element(ele)
      puts "Given element is not in BST. Hence, can't be removed!"
    else
      remove_element_util(root_node = @root, ele)
      root_node
      puts "Now, the inorder traversal of BST:- "
      print_in()
      puts "\n"
    end
  end
    
  def saving_data()
    file = File.open("results_bst.txt", "w+")
    @inorder_str = "The inorder traversal of BST: "
    @preorder_str = "The preorder traversal of BST: "
    @postorder_str = "The postorder traversal of BST: "
    @levelorder_str = "The levelorder traversal of BST: "
    @large_ele = ""
    @small_ele = ""
    print = false
    print_in(@root, print)
    print_pre(@root, print)
    print_post(@root, print)
    print_level(@root, print)
    largest_element(print)
    smallest_element(print)
   
    file.write(@inorder_str + "\n")
    file.write(@preorder_str + "\n")
    file.write(@postorder_str + "\n")
    file.write(@levelorder_str + "\n")
    file.write(@large_ele + "\n")
    file.write(@small_ele + "\n")
    file.close
    puts "The results are saved into 'results_bst.txt' and exiting..."
    puts "\n\n"
  end
  
end

tree = BSTree.new()
puts "Enter 1 to manually insert elements into BST."
puts "Enter 2 to insert elements using file into BST."
initial_input = gets.chomp.to_i
if initial_input == 2
  array = File.read("input_data.txt").split(",").map(&:strip)
  array.each{|ele| tree.insert_node(ele)}
  puts "The file (input_data.txt) elements are successfully inserted into the BST!."
  puts "\n"
 
elsif initial_input == 1
  puts "Enter comma seperated elements to be inserted into BST: "
  array = gets.chomp.split(",")
  array.each{|ele| tree.insert_node(ele)}
  puts "The given elements are successfully inserted into BST!"
  puts "\n"
end

loop do
 puts "--> Select any operation you wanna perform on this BST:"
 puts "Enter 1 to print largest element from BST\nEnter 2 to print smallest element from BST\nEnter 3 to print various traversals of BST"
 puts "Enter 4 to search any element into BST\nEnter 5 to delete any element from BST\nEnter 6 to print all root to leaf possible paths\nEnter 0 to save and exit\n"
 
 input = gets.chomp.to_i
 
 if input == 1
   tree.largest_element()
   
 elsif input == 2
   tree.smallest_element()
 
 elsif input == 3
   puts "Printing the inorder traversal of BST:- "
   tree.print_in()
   puts "\nPrinting the preorder traversal of BST:- "
   tree.print_pre()
   puts "\nPrinting the postorder traversal of BST:- "
   tree.print_post()
   puts "\nPrinting the levelorder traversal of BST:- "
   tree.print_level()
   puts "\n"
 
 elsif input == 4
   puts "Enter any element you wanna search into BST:- "
   ele = gets.chomp
   if tree.search_element(ele)
     puts "Element is found!"
   else
     puts "Element is not found!"
   end
   puts "\n"
 
 elsif input == 5 
   puts "Enter the element you wanna remove from BST:- "
   ele = gets.chomp
   tree.remove_element(ele)
   puts "The element is successfully removed from the BST!"
   puts "\n"

 elsif input == 6
   puts "Printing all paths from root to leaf:- "
   tree.print_root_to_leaf()
   puts "\n"
   
 elsif input == 0
   #save to a file and then exit
   tree.saving_data()
   break
 end
end   



