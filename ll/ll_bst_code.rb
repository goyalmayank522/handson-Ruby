=begin
a=5
b=4
total = a+b
puts total
=end

class Node
  attr_accessor :data, :left, :right
  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Linked_list
  attr_accessor :head, :linked_list_orig
  def initialize
    @head = nil
    @linked_list_original = ""
  end
  
  def insert_node(data)
    if @head == nil
      @head = Node.new(data)
    else
      temp = @head
      while temp.right
        temp = temp.right
      end
      temp.right = Node.new(data)
    end
  end  
  
  def search_element(element)
    temp = @head
    if temp == nil
      puts "The LL is empty!"
      return false
    end
    while temp != nil
      return true if temp.data.to_i == element
      temp = temp.right
    end
    return false
  end
  
  def remove_element(element)
    if !search_element(element)
      puts "Given element is not in LL. Hence, can't be removed!"
    else
      if @head.data.to_i == element
        @head = @head.right
      else
        prev = @head
        while prev.right
          if prev.right.data.to_i == element
            prev.right = prev.right.right
            break
          else
            prev = prev.right
          end
        end
      end     
      puts "The element is successfully removed from the LL!" 
      print_ll()
      puts "\n"
    end
  end
  
  def print_ll(if_print = true)
    temp = @head
    if temp == nil
      @linked_list_original = "The Linked List is empty!"
      if if_print
        puts "The Linked List is empty!"
      end
    else
      puts "The Linked List elements are:- " if if_print
      while temp
        print "#{temp.data} " if if_print
        @linked_list_original += temp.data.to_s + " "
        temp = temp.right
      end
    end
  end
  
  def reverse_ll
    if @head == nil
      puts "The Linked List is empty. Hence, nothing to reverse!"
    else
      curr = @head
      prev = nil
      next_node = nil
      while curr
        next_node = curr.right
        curr.right = prev
        prev = curr
        curr = next_node
      end
      @head = prev
    end
  end
  
  def save_data
    file = File.open("results_ll.txt", "w+")
    @linked_list_orig = "The Linked List is: "
    if_print = false
    print_ll(if_print)
    file.write(@linked_list_orig + "\n")
    file.close
    puts "The results are saved into 'results_ll.txt' and exiting..."
    puts "\n\n"
  end
end
  
class BSTree
  attr_accessor :root, :inorder_arr
  def initialize
    @root = nil
    @inorder_str = ""
  end
  
  def insert_node(data)
    if @root == nil
      @root = Node.new(data) # new node
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
        prev_node.right = Node.new(data)
      else
        prev_node.left = Node.new(data)
      end
    end
  end
  
  def largest_element()
    root_node = @root
    if root_node == nil
      puts "The BST is empty. Hence, no largest element found!"
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
      puts "The BST is empty. Hence, no smallest element found!"
    else
      while root_node.left
        root_node = root_node.left
      end
      puts "The smallest element in the BST is #{root_node.data}."
    end
  end
    
  def search_element_util(temp_root, element)
    if temp_root == nil
      return false
    elsif temp_root.data == element
      return true
    elsif element < temp_root.data
      search_element_util(temp_root.left, element)
    else
      search_element_util(temp_root.right, element)
    end
  end
    
  def search_element(element)
    return search_element_util(@root, element)
  end  
  
  def print_inorder(root_node = self.root, if_print = true)
    return if root_node == nil
    print_inorder(root_node.left, if_print)
    print "#{root_node.data} " if if_print
    @inorder_str += root_node.data.to_s + " "
    print_inorder(root_node.right, if_print)
  end
  
  def print_preorder(root_node = self.root)
    return if root_node == nil
    print "#{root_node.data} "
    print_preorder(root_node.left)
    print_preorder(root_node.right)
  end
  
  def print_postorder(root_node = self.root)
    return if root_node == nil
    print_postorder(root_node.left)
    print_postorder(root_node.right)
    print "#{root_node.data} "
  end
  
  def print_levelorder(root_node = self.root)
    return if root_node == nil
    queue = Queue.new
    queue.push(root_node)
    while queue.size > 0
      temp_node = queue.pop
      print "#{temp_node.data} "
      queue.push(temp_node.left) if temp_node.left
      queue.push(temp_node.right) if temp_node.right
    end
  end
  
  def print_root_to_leaf_util(arr, root_node)
    return if !root_node
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
  
  def remove_element_util(root_node, element)
    if !root_node
      return nil
    elsif element < root_node.data
      root_node.left = remove_element_util(root_node.left, element)
    elsif element > root_node.data
      root_node.right = remove_element_util(root_node.right, element)
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
    
    
  def remove_element(element, root_node = @root)
    if !search_element(element)
      puts "Given element is not in BST. Hence, can't be removed!"
    else
      remove_element_util(root_node = @root, element)
      root_node
      puts "The element is successfully removed from the BST!"
      puts "Now, the inorder traversal of BST:- "
      print_inorder()
      puts "\n"
    end
  end
    
  def save_data
    file = File.open("results_bst.txt", "w+")
    @inorder_str = "The inorder traversal of BST: "
    if_print = false
    print_inorder(@root, if_print)
    file.write(@inorder_str + "\n")
    file.close
    puts "The results are saved into 'results_bst.txt' and exiting..."
    puts "\n\n"
  end
end

def start_bst()
  tree = BSTree.new()
  puts "Enter 1 to manually insert elements into BST."
  puts "Enter 2 to insert elements using file into BST."
  puts "Enter anything else to go to main menu."
  initial_input = gets.chomp.to_i
  
  if initial_input == 2
    array = File.read("test/input_data.txt").split(",").map(&:strip)
    for i in array do
      element = i.to_i
      if tree.search_element(element) == false
        tree.insert_node(element)
      end
    end
    puts "The file (test/input_data.txt) elements are successfully inserted into the BST!."
    puts "\n"
 
  elsif initial_input == 1
    puts "Enter comma seperated elements to be inserted into BST: "
    array = gets.chomp.split(",")
    for i in array do
      element = i.to_i
      if tree.search_element(element) == false
        tree.insert_node(element)
      end
    end
    puts "The given elements are successfully inserted into BST!"
    puts "\n"
    
  else
    puts "Going to main menu..."
    return
  end
  
  loop do
    puts "--> Select any operation you wanna perform on this BST:"
    puts "->Enter 1 to print largest element from BST"
    puts "->Enter 2 to print smallest element from BST"
    puts "->Enter 3 to print various traversals of BST"
    puts "->Enter 4 to search any element into BST"
    puts "->Enter 5 to delete any element from BST"
    puts "->Enter 6 to print all root to leaf possible paths"
    puts "->Enter 7 to insert a element into BST"
    puts "->Enter 0 to save and exit"
    print "==> "
    input = gets.chomp.to_i
    
    case input
    when 1
      tree.largest_element()
   
    when 2
      tree.smallest_element()
 
    when 3
      puts "Printing the inorder traversal of BST:- "
      tree.print_inorder()
      puts "\nPrinting the preorder traversal of BST:- "
      tree.print_preorder()
      puts "\nPrinting the postorder traversal of BST:- "
      tree.print_postorder()
      puts "\nPrinting the levelorder traversal of BST:- "
      tree.print_levelorder()
      puts "\n"
 
    when 4
      puts "Enter any element you wanna search into BST:- "
      element = gets.chomp.to_i
      if tree.search_element(element)
        puts "Element is found!"
      else
        puts "Element is not found!"
      end
      puts "\n"
 
    when 5
      puts "Enter the element you wanna remove from BST:- "
      element = gets.chomp.to_i
      tree.remove_element(element)
      puts "\n"

    when 6
      puts "Printing all paths from root to leaf:- "
      tree.print_root_to_leaf()
      puts "\n"
   
   when 7
     puts "Enter a element you wanna insert into BST:- "
     element = gets.chomp.to_i
     if tree.search_element(element) == false
       tree.insert_node(element)
       puts "The element is successfully inserted into BST!"
     else
       puts "The element already exists into BST!"
     end
     puts "\n"
     
    when 0
      #save to a file and then exit
      tree.save_data()
      break
    end
  end
end   

def start_ll()
  linked_list = Linked_list.new()
  puts "->Enter 1 to manually insert elements into LL."
  puts "->Enter 2 to insert elements using file into LL."
  puts "->Enter anything else to go to main menu."
  initial_input = gets.chomp.to_i
  if initial_input == 2
    array = File.read("test/input_data.txt").split(",").map(&:strip)
    array.each{|ele| linked_list.insert_node(ele)}
    puts "The file (test/input_data.txt) elements are successfully inserted into the LL!."
    puts "\n"
 
  elsif initial_input == 1
    puts "Enter comma seperated elements to be inserted into LL: "
    array = gets.chomp.split(",")
    array.each{|ele| linked_list.insert_node(ele)}
    puts "The given elements are successfully inserted into LL!"
    puts "\n"
  else
    puts "Going to main menu..."
    return
  end 
  
    
  loop do
    puts "--> Select any operation you wanna perform on Linked List:"
    puts "->Enter 1 to add new node into LL."
    puts "->Enter 2 to search any element into LL."
    puts "->Enter 3 to delete any node from LL."
    puts "->Enter 4 to reverse the LL."
    puts "->Enter 5 to print the LL."
    puts "->Enter 0 to save and exit."
    print "==> "
    input = gets.chomp.to_i
    
    case input
    when 1
      puts "Enter the element you wanna add into LL:"
      element = gets.chomp.to_i
      linked_list.insert_node(element)
      puts "The element is successfully inserted into LL!"
      puts "\n"
      
    when 2
      puts "Enter the element you wanna search into LL:"
      element = gets.chomp.to_i
      if linked_list.search_element(element)
        puts "Element is found!"
      else
        puts "Element is not found!"
      end
      puts "\n"
      
    when 3
      puts "Enter the element you wanna remove from LL:- "
      element = gets.chomp.to_i
      linked_list.remove_element(element)
      puts "\n"
    
    when 4
      linked_list.reverse_ll()
      puts "The linked list is successfully reversed!"
      puts "\n"
    
    when 5
      linked_list.print_ll()
      puts "\n"
    
    when 0
      linked_list.save_data()
      break
    end
  end
end


loop do
  puts "--> Choose which DS you wanna use:-"
  puts "->Enter 1 to select Linked List."
  puts "->Enter 2 to select Binary Search Tree."
  puts "->Enter anything else to exit."
  print "==> "
  start = gets.chomp.to_i
  if start == 1
    start_ll()
  elsif start == 2
    start_bst()
  else
    puts "Exiting..."
    break
  end
end
