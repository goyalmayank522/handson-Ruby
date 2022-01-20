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

class Linked_list
  attr_accessor :head, :linked_list_orig
  def initialize
    @head = nil
    @linked_list_orig = ""
  end
  
  def insert_node(data)
    if @head == nil
      @head = NewNode.new(data)
    else
      temp = @head
      while temp.right
        temp = temp.right
      end
      temp.right = NewNode.new(data)
    end
  end  
  
  def search_element(ele)
    temp = @head
    if temp == nil
      puts "The LL is empty!"
      return false
    end
    while temp != nil
      return true if temp.data.to_i == ele
      temp = temp.right
    end
    return false
  end
  
  def remove_element(ele)
    if !search_element(ele)
      puts "Given element is not in LL. Hence, can't be removed!"
    else
      if @head.data.to_i == ele
        @head = @head.right
      else
        prev = @head
        while prev.right
          if prev.right.data.to_i == ele
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
  
  def print_ll(print = true)
    temp = @head
    if temp == nil
      @linked_list_orig = "The Linked List is empty!"
      if print
        puts "The Linked List is empty!"
      end
    else
      puts "The Linked List elements are:- " if print
      while temp
        print "#{temp.data} " if print
        @linked_list_orig += temp.data.to_s + " "
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
  
  def saving_data
    file = File.open("results_ll.txt", "w+")
    @linked_list_orig = "The Linked List is: "
    print = false
    print_ll(print)
    file.write(@linked_list_orig + "\n")
    file.close
    puts "The results are saved into 'results_ll.txt' and exiting..."
    puts "\n\n"
  end
end
  
class BSTree
  attr_accessor :root, :inorder_arr, :preorder_arr, :postorder_arr, :levelorder_arr, :large_ele, :small_ele
  def initialize
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
    puts "#{temp}\n\n" if print
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
    puts "#{temp}\n\n" if print
    @small_ele << temp
  end
      
  def search_element_util(temp_root, ele)
    if temp_root == nil
      return false
    elsif temp_root.data == ele
      return true
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
    return if root_node == nil
    print_in(root_node.left, print)
    print "#{root_node.data} " if print
    @inorder_str += root_node.data.to_s + " "
    print_in(root_node.right, print)
  end
  
  def print_pre(root_node = self.root, print = true)
    return if root_node == nil
    print "#{root_node.data} " if print
    @preorder_str += root_node.data.to_s + " "
    print_pre(root_node.left, print)
    print_pre(root_node.right, print)
  end
  
  def print_post(root_node = self.root, print = true)
    return if root_node == nil
    print_post(root_node.left, print)
    print_post(root_node.right, print)
    print "#{root_node.data} " if print
    @postorder_str += root_node.data.to_s + " "
  end
  
  def print_level(root_node = self.root, print = true)
    return if root_node == nil
    queue = Queue.new
    queue.push(root_node)
    while queue.size > 0
      temp_node = queue.pop
      print "#{temp_node.data} " if print
      @levelorder_str += temp_node.data.to_s + " "
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
      puts "The element is successfully removed from the BST!"
      puts "Now, the inorder traversal of BST:- "
      print_in()
      puts "\n"
    end
  end
    
  def saving_data
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

def start_bst()
  tree = BSTree.new()
  puts "Enter 1 to manually insert elements into BST."
  puts "Enter 2 to insert elements using file into BST."
  puts "Enter anything else to go to main menu."
  initial_input = gets.chomp.to_i
  
  if initial_input == 2
    array = File.read("input_data.txt").split(",").map(&:strip)
    for i in array do
      ele = i.to_i
      if tree.search_element(ele) == false
        tree.insert_node(ele)
      end
    end
    #array.each{|ele| tree.insert_node(ele)}
    puts "The file (input_data.txt) elements are successfully inserted into the BST!."
    puts "\n"
 
  elsif initial_input == 1
    puts "Enter comma seperated elements to be inserted into BST: "
    array = gets.chomp.split(",")
    for i in array do
      ele = i.to_i
      if tree.search_element(ele) == false
        tree.insert_node(ele)
      end
    end
    #for ele in array do
      #tree.insert_node(ele)
    #end
    puts "The given elements are successfully inserted into BST!"
    puts "\n"
    
  else
    puts "Going to main menu..."
    return
  end
  
  puts "--> Select any operation you wanna perform on this BST:"
  puts "->Enter 1 to print largest element from BST\n->Enter 2 to print smallest element from BST\n->Enter 3 to print various traversals of BST"
  puts "->Enter 4 to search any element into BST\n->Enter 5 to delete any element from BST\n->Enter 6 to print all root to leaf possible paths\n->Enter 7 to insert a element into BST\n->Enter 0 to save and exit\n"
  loop do
    print "==> "
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
      puts "\n"

    elsif input == 6
      puts "Printing all paths from root to leaf:- "
      tree.print_root_to_leaf()
      puts "\n"
   
   elsif input == 7
     puts "Enter a element you wanna insert into BST:- "
     ele = gets.chomp.to_i
     if tree.search_element(ele) == false
       tree.insert_node(ele)
       puts "The element is successfully inserted into BST!"
     else
       puts "The element already exists into BST!"
     end
     #tree.insert_node(ele)
     #puts "The element is successfully inserted into BST!"
     puts "\n"
     
    elsif input == 0
      #save to a file and then exit
      tree.saving_data()
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
    array = File.read("input_data.txt").split(",").map(&:strip)
    array.each{|ele| linked_list.insert_node(ele)}
    puts "The file (input_data.txt) elements are successfully inserted into the LL!."
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
  
  puts "--> Select any operation you wanna perform on Linked List:"
  puts "->Enter 1 to add new node into LL."
  puts "->Enter 2 to search any element into LL."
  puts "->Enter 3 to delete any node from LL."
  puts "->Enter 4 to reverse the LL."
  puts "->Enter 5 to print the LL."
  puts "->Enter 0 to save and exit."
    
  loop do
    print "==> "
    input = gets.chomp.to_i
    
    if input == 1
      puts "Enter the element you wanna add into LL:"
      ele = gets.chomp
      ele = ele.to_i
      linked_list.insert_node(ele)
      puts "The element is successfully inserted into LL!"
      puts "\n"
      
    elsif input == 2
      puts "Enter the element you wanna search into LL:"
      ele = gets.chomp.to_i
      if linked_list.search_element(ele)
        puts "Element is found!"
      else
        puts "Element is not found!"
      end
      puts "\n"
      
    elsif input == 3
      puts "Enter the element you wanna remove from LL:- "
      ele = gets.chomp.to_i
      linked_list.remove_element(ele)
      puts "\n"
    
    elsif input == 4
      linked_list.reverse_ll()
      puts "The linked list is successfully reversed!"
      puts "\n"
    
    elsif input == 5
      linked_list.print_ll()
      puts "\n"
    
    elsif input == 0
      linked_list.saving_data()
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
