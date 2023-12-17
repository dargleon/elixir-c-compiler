defmodule CodeGeneratorTest do
  use ExUnit.Case
  doctest CodeGenerator

  setup_all do
    {:ok,
      code_week1:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $2, %rax
        ret
""",
      code_nestedUnary:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $2, %rax
        cmp     $0, %rax
        mov     $0, %rax
        sete    %al
        not     %rax
        neg     %rax
        push    %rax
        mov $1, %rax
        neg     %rax
        pop     %rcx
        sub     %rax, %rcx
        mov     %rcx, %rax
        ret
""",
      code_2add1:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $2, %rax
        push    %rax
        mov $1, %rax
        pop     %rcx
        add     %rcx, %rax
        ret
""",
      code_2x3:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $2, %rax
        push    %rax
        mov $3, %rax
        pop     %rcx
        imul    %rcx, %rax
        ret
""",
      code_6div2:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $6, %rax
        push    %rax
        mov $2, %rax
        mov     %rax, %rcx
        xor     %rdx, %rdx
        pop     %rax
        idiv    %rcx
        ret
""",
    code_6div_3x2:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $6, %rax
        push    %rax
        mov $3, %rax
        push    %rax
        mov $2, %rax
        pop     %rcx
        imul    %rcx, %rax
        mov     %rax, %rcx
        xor     %rdx, %rdx
        pop     %rax
        idiv    %rcx
        ret
""",
    code_2more1:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $2, %rax
        push    %rax
        mov $1, %rax
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setg    %al
        ret
""",
    code_2more1_and_3less4:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $2, %rax
        push    %rax
        mov $1, %rax
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setg    %al
        push    %rax
        mov $3, %rax
        push    %rax
        mov $4, %rax
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setl    %al
        pop     %rcx
        cmp     $0, %rcx
        jne     label_and1
        mov     %rcx, %rax
        jmp     end_and1
label_and1:
        cmp     $0, %rax
        mov     $0, %rax
        setne   %al
end_and1:
        ret
""",
    code_2less1_or_101more100:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $2, %rax
        push    %rax
        mov $1, %rax
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setl    %al
        push    %rax
        mov $101, %rax
        push    %rax
        mov $100, %rax
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setg    %al
        pop     %rcx
        cmp     $0, %rcx
        je      label_or1
        mov     $1, %rax
        jmp     end_or1
label_or1:
        cmp     $0, %rax
        mov     $0, %rax
        setne   %al
end_or1:
        ret
""",
    code_5equal5:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $5, %rax
        push    %rax
        mov $5, %rax
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        sete    %al
        ret
""",
    code_5different85:
"""
        .section  .text.startup,"ax",@progbits
        .p2align        4, 0x90
        .globl  main         ## -- Begin function main
    main:                    ## @main
        mov $5, %rax
        push    %rax
        mov $85, %rax
        pop     %rcx
        cmp     %rax, %rcx
        mov     $0, %rax
        setne   %al
        ret
"""
    }
  end

  test "return 2", state do

    #code to tokenize
    code = """
      int main() {
        return 2;
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The result is passed to the lexer
    l_tokens = Lexer.scan_words(s_code)

    #The tokens are passed through the parser
    ast = Parser.parse_program(l_tokens)

    assert CodeGenerator.generate_code(ast, :noprint) == state[:code_week1]

  end

  test "return -~!2--1", state do

    #code to tokenize
    code = """
      int main() {
        return (-~!2--1);
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The result is passed to the lexer
    l_tokens = Lexer.scan_words(s_code)

    #The tokens are passed through the parser
    ast = Parser.parse_program(l_tokens)

    assert CodeGenerator.generate_code(ast, :noprint) == state[:code_nestedUnary]
  end

  test "return 2+1", state do

    #code to tokenize
    code = """
      int main() {
        return (2+1);
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The result is passed to the lexer
    l_tokens = Lexer.scan_words(s_code)

    #The tokens are passed through the parser
    ast = Parser.parse_program(l_tokens)

    assert CodeGenerator.generate_code(ast, :noprint) == state[:code_2add1]
  end


  test "return 2*3", state do

    #code to tokenize
    code = """
      int main() {
        return (2*3);
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The result is passed to the lexer
    l_tokens = Lexer.scan_words(s_code)

    #The tokens are passed through the parser
    ast = Parser.parse_program(l_tokens)

    assert CodeGenerator.generate_code(ast, :noprint) == state[:code_2x3]
  end

  test "return 6/2", state do

    #code to tokenize
    code = """
      int main() {
        return (6/2);
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The result is passed to the lexer
    l_tokens = Lexer.scan_words(s_code)

    #The tokens are passed through the parser
    ast = Parser.parse_program(l_tokens)

    assert CodeGenerator.generate_code(ast, :noprint) == state[:code_6div2]
  end

    test "return 6/(3*2)", state do

      #code to tokenize
      code = """
        int main() {
          return (6)/(3*2);
      }
      """
      #The code is passed through the sanitizer
      s_code = Sanitizer.sanitize_source(code)

      #The result is passed to the lexer
      l_tokens = Lexer.scan_words(s_code)

      #The tokens are passed through the parser
      ast = Parser.parse_program(l_tokens)

      assert CodeGenerator.generate_code(ast, :noprint) == state[:code_6div_3x2]
  end

  test "return 2more1", state do

      #code to tokenize
      code = """
      int main(){
        return (2>1);
      }
      """
      #The code is passed through the sanitizer
      s_code = Sanitizer.sanitize_source(code)

      #The result is passed to the lexer
      l_tokens = Lexer.scan_words(s_code)

      #The tokens are passed through the parser
      ast = Parser.parse_program(l_tokens)

      assert CodeGenerator.generate_code(ast, :noprint) == state[:code_2more1]
  end

    test "return 2more1_and_3less4", state do

        #code to tokenize
      code = """
      int main(){
        return (2>1)&&(3<4);
      }
      """
        #The code is passed through the sanitizer
      s_code = Sanitizer.sanitize_source(code)

        #The result is passed to the lexer
      l_tokens = Lexer.scan_words(s_code)

        #The tokens are passed through the parser
      ast = Parser.parse_program(l_tokens)

      assert CodeGenerator.generate_code(ast, :noprint) == state[:code_2more1_and_3less4]
    end

    test "return 2less1_or_101more100", state do

        #code to tokenize
      code = """
      int main(){
        return (2<1)||(101>100);
      }
      """
        #The code is passed through the sanitizer
      s_code = Sanitizer.sanitize_source(code)

        #The result is passed to the lexer
      l_tokens = Lexer.scan_words(s_code)

        #The tokens are passed through the parser
      ast = Parser.parse_program(l_tokens)

      assert CodeGenerator.generate_code(ast, :noprint) == state[:code_2less1_or_101more100]
    end

    test "return 5equal5", state do

        #code to tokenize
      code = """
      int main(){
        return 5==5;
      }
      """
        #The code is passed through the sanitizer
      s_code = Sanitizer.sanitize_source(code)

        #The result is passed to the lexer
      l_tokens = Lexer.scan_words(s_code)

        #The tokens are passed through the parser
      ast = Parser.parse_program(l_tokens)

      assert CodeGenerator.generate_code(ast, :noprint) == state[:code_5equal5]
    end

    test "return 5different85", state do

        #code to tokenize
      code = """
      int main(){
        return 5!=85;
      }
      """
        #The code is passed through the sanitizer
      s_code = Sanitizer.sanitize_source(code)

        #The result is passed to the lexer
      l_tokens = Lexer.scan_words(s_code)

        #The tokens are passed through the parser
      ast = Parser.parse_program(l_tokens)

      assert CodeGenerator.generate_code(ast, :noprint) == state[:code_5different85]
    end
end
