defmodule CodeGenerator do
  @moduledoc """
  Code Generator, this module gets the AST after the parser validation and check all the
  nodes to get the assembler code.
  """

  @doc"""
  This fuction calls the post_order with the ast as
  an argument, and returns the code.
  with :print -Prints the resulting code in the terminal, and the AST postorder traverse.
  with :noprint -It doesn't print the code in the terminal.
  """
  def generate_code(ast, :print) do

    ast_Stack = post_order_traverse(ast,[])  # Get the AST postorder stack.

    ast_Stack = Enum.reverse(ast_Stack) # Convert the ast_Stack to postfix notation

    IO.puts(["\nPostfix notation of the AST with nil's is: ", Enum.join(ast_Stack, " ")])

    ast_Stack_noNIL = Enum.filter(ast_Stack, fn v -> v != "nil" end) # Delete all the "nil" from te ast_Stack (only to print)
    IO.puts(["\nPostfix notation of the AST without nil's is: ", Enum.join(ast_Stack_noNIL, " ")])

    code = post_order(ast, "", ast_Stack) # Get the ASM code


    IO.puts("\nCode Generator output:")
    asm = List.first(code)
    IO.puts(asm) #Print the code.
    asm

  end

  def generate_code(ast, :noprint) do

    ast_Stack = post_order_traverse(ast,[])

    ast_Stack = Enum.reverse(ast_Stack) # Convert the ast_Stack to postfix notation

    code = post_order(ast, "", ast_Stack)

    asm = List.first(code)

    asm

  end

  @doc"""
  Post-order traversal to get the values of the AST nodes in stack form.
  """
  def post_order_traverse(node,stack_aux) do #stack_aux helps to form the AST stack
    case node do

      nil -> #We have a nil node
        ["nil" | stack_aux] # Add the nil to the stack

      ast_node -> #We have a valid node
        stack_aux = post_order_traverse(ast_node.left_node, stack_aux)
        stack_aux = post_order_traverse(ast_node.right_node, stack_aux)
        [ast_node.value | stack_aux] #Add the new value to the stack

    end
  end


  @doc"""
  This fuction applies post_order recursively to the ast and get
  code_snippet's which conform the full code until the ast is fully
  traversed.
  It also considers the AST represented on a stack to make code
  generation decisions.
  """
  def post_order(node, code_snippet, ast_Stack) do
    case node do
      nil ->

        ast_Stack = Enum.drop(ast_Stack, 1) #We make pop to the stack
        [code_snippet, ast_Stack] #Don't get new code

      ast_node ->

        [code_snippet, ast_Stack] = post_order(ast_node.left_node, code_snippet, ast_Stack)
        [code_snippet, ast_Stack] = post_order(ast_node.right_node, code_snippet, ast_Stack)

        ast_Stack = Enum.drop(ast_Stack, 1) #We make pop to the stack


        negative = check_negative(ast_node) #Check if we have a "-" and if it is unary or binary

        place = check_place(ast_Stack) #Check if the asm value needs to be pushed or not in the memory stack

        code_snippet = new_code(ast_node, code_snippet, place, negative) #Get the code snippet

        [code_snippet, ast_Stack]

    end

  end

  @doc"""
  This function checks if we have a negative node,
  if so, check for it's right node, if it have a right node,
  then we have a binary operator.
  If it doesn't have a right node, we have an unary operator.
  If the actual node is not a negative, return a nil.
  """
  def check_negative(node) do
        if(node.value == "-") do
            if (node.right_node == nil) do
            # We have an unary operator
            :unary

            else
            # We have a binary operator
            :binary

            end
        else
            # We don't have a negative operator
            nil
        end
  end

  @doc"""
  This function helps to define the place of an obtained value in the execution of the assembler code.
  It is achieved by checking the first or second position of the current postfix notation, remember that 
  the postfix notation (ast_Stack) does not include the current node, and that in the first position is the 
  next node for which code will be generated.
  The place will be inside the memory stack (:push), or in a rax register (:nopush).
  """
  def check_place(ast_Stack) do

        aux = ast_Stack
        # Helps to check the 2nd position in the postfix notation
        aux = Enum.drop(aux, 1) 


        if  List.first(aux) == :return or # If we need to return

            # If the actual node will be operated by a unOp
            List.first(aux) == "-" or
            List.first(aux) == "!" or
            List.first(aux) == "~" or

            # If we have the right value of a binOp
            List.first(ast_Stack) == "+" or
            List.first(ast_Stack) == "-" or
            List.first(ast_Stack) == "*" or
            List.first(ast_Stack) == "/" or
            List.first(ast_Stack) == "&&" or
            List.first(ast_Stack) == "||" or
            List.first(ast_Stack) == "==" or
            List.first(ast_Stack) == "!=" or
            List.first(ast_Stack) == "<=" or
            List.first(ast_Stack) == ">=" or
            List.first(ast_Stack) == "<" or
            List.first(ast_Stack) == ">" do

            :nopush # Leave it on RAX register
        else

            #If we have the left value of a binOp

            :push #Push it in the stack memory

        end

  end


  @doc"""
  This function adds the push instruction in cases where it is necessary.
  """
  def new_code(ast_node, code_snippet, place, negative) do
    
        if (place == :nopush) or
           (ast_node.node_name == :program) or
           (ast_node.node_name == :function) or
           (ast_node.node_name == :return) do

            #Leave it in the RAX register
            emit_code(ast_node.node_name, code_snippet, ast_node.value, negative)

        else

            #Push the RAX into the mem stack
            emit_code(ast_node.node_name, code_snippet, ast_node.value, negative)  <>
        """
                push    %rax
        """

        end            
  end

  @doc"""
  This function can emit the code corresponding to the received tokens, and it's variations
  consider recursive code generation with the use of code_snippet's.
  """
  def emit_code(:program, code_snippet, _, _) do
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
""" <> code_snippet
  end


  #Emit code for a C main function.
  def emit_code(:function, code_snippet, :main, _) do
"""
        .globl  main         ## -- Begin function main
    main:                    ## @main
""" <> code_snippet
  end

  ###


  # Emit code for a return statement, the received code_snippet it's
  # expected to have the final calculated value in the rax register.
  def emit_code(:return, code_snippet, _, _) do
    code_snippet <>
"""
        ret
"""
  end


  #Emit code for a constant, check it's value
  def emit_code(:constant, code_snippet, value, _) do

        code_snippet <>
"""
        mov $#{value}, %rax
"""


  end

  # Emit code for a complement unOp
  def emit_code(:complement, code_snippet, _, _) do

    code_snippet <>
"""
        not     %rax
"""

  end

  #Emit code for a logic negation unOp
  def emit_code(:logic, code_snippet, _, _) do

    code_snippet <>
"""
        cmp     $0, %rax
        mov     $0, %rax
        sete    %al
"""

  end

  #Emit code for the addition binOp
  def emit_code(:addition, code_snippet, _, _) do

    code_snippet <>
"""
        pop     %rcx
        add     %rcx, %rax
"""

  end

  #Emit code for the multiplication binOp
  def emit_code(:multiplication, code_snippet, _, _) do

    code_snippet <>
"""
        pop     %rcx
        imul    %rcx, %rax
"""

  end

  #Emit code for the division binOp
  def emit_code(:division, code_snippet, _, _) do

    code_snippet <>
"""
        mov     %rax, %rcx
        xor     %rdx, %rdx
        pop     %rax
        idiv    %rcx
"""

  end

  #Emit code for a negative unOp.
  def emit_code(:negative, code_snippet, _, :unary) do


      code_snippet <>
"""
        neg     %rax
"""

  end


  #Emit code for a negative binOp, it's a substraction operator.
  def emit_code(:negative, code_snippet, _, :binary) do

      code_snippet <>
"""
        pop     %rcx
        sub     %rax, %rcx
        mov     %rcx, %rax
"""

  end


  #Emit code for a "&&" shortcircuit evaluation binOp
  def emit_code(:and, code_snippet, _, _) do


    count = Regex.scan(~r/label_and\d{1,}:/, code_snippet)
    id = Integer.to_string(length(count)+1)


    code_snippet <>
"""
        pop     %rcx
        cmp     $0, %rcx
        jne     label_and#{id}
        mov     %rcx, %rax
        jmp     end_and#{id}
label_and#{id}:
        cmp     $0, %rax
        mov     $0, %rax
        setne   %al
end_and#{id}:
"""

  end

  #Emit code for a "||" shortcircuit evaluation binOp
  def emit_code(:or, code_snippet, _, _) do


    count = Regex.scan(~r/label_or\d{1,}:/, code_snippet)
    id = Integer.to_string(length(count) + 1)

    code_snippet <>
"""
        pop     %rcx
        cmp     $0, %rcx
        je      label_or#{id}
        mov     $1, %rax
        jmp     end_or#{id}
label_or#{id}:
        cmp     $0, %rax
        mov     $0, %rax
        setne   %al
end_or#{id}:
"""

  end

  #Emit code for an equal "==" relational binOp.
  def emit_code(:equal, code_snippet, _, _) do

    code_snippet <>
"""
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        sete    %al
"""

  end

  #Emit code for a not equal "!=" relational binOp.
  def emit_code(:not_equal, code_snippet, _, _) do

    code_snippet <>
"""
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setne   %al
"""

  end

  #Emit code for a less than "<" relational binOp.
  def emit_code(:less_than, code_snippet, _, _) do


    code_snippet <>
"""
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setl    %al
"""

  end

  #Emit code for a greater than ">" relational binOp.
  def emit_code(:greater_than, code_snippet, _, _) do

    code_snippet <>
"""
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setg    %al
"""

  end

  #Emit code for a "<=" relational binOp.
  def emit_code(:less_eq_than, code_snippet, _, _) do

    code_snippet <>
"""
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setle   %al
"""

  end

  #Emit code for a ">=" relational binOp.
  def emit_code(:greater_eq_than, code_snippet, _, _) do

    code_snippet <>
"""
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setge   %al
"""

  end

end
