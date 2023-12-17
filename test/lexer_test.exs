defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  setup_all do
    #A tuple is defined
    {:ok,
      #A list is defined with the tentative tokens that the lexer must obtain
     tokens_week1: [
       :int_keyword,
       :main_keyword,
       :open_paren,
       :close_paren,
       :open_brace,
       :return_keyword,
       {:constant, 2},
       :semicolon,
       :close_brace
     ],
     tokens_week2_Negation: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      :negative,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week2_LogicN: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      :logic,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week2_Bitwise: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      :complement,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week3_addition1: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 2},
      :addition,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week3_addition2: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      :addition,
      {:constant, 2},
      :addition,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week3_subtraction1: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 2},
      :negative,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week3_subtraction2: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      :negative,
      {:constant, 2},
      :negative,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week3_binary1: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      :negative,
      {:constant, 2},
      :addition,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week3_binary2: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      :addition,
      {:constant, 2},
      :negative,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week3_multiplication1: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 2},
      :multiplication,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week3_multiplication2: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      :open_paren,
      {:constant, 2},
      :close_paren,
      :multiplication,
      :open_paren,
      {:constant, 2},
      :close_paren,
      :semicolon,
      :close_brace
    ],
    tokens_week3_division: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 2},
      :division,
      {:constant, 2},
      :semicolon,
      :close_brace
    ],
    tokens_week3_division2: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      :open_paren,
      {:constant, 2},
      :close_paren,
      :division,
      :open_paren,
      {:constant, 2},
      :close_paren,
      :semicolon,
      :close_brace
    ],
    tokens_week4_and: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 3},
      :and,
      {:constant, 3},
      :semicolon,
      :close_brace
    ],
    tokens_week4_or: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 3},
      :or,
      {:constant, 3},
      :semicolon,
      :close_brace
    ],
    tokens_week4_equal: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 3},
      :equal,
      {:constant, 3},
      :semicolon,
      :close_brace
    ],
    tokens_week4_noEqual: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 3},
      :not_equal,
      {:constant, 3},
      :semicolon,
      :close_brace
    ],
    tokens_week4_less: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 3},
      :less_than,
      {:constant, 3},
      :semicolon,
      :close_brace
    ],
    tokens_week4_lessEqual: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 3},
      :less_eq_than,
      {:constant, 3},
      :semicolon,
      :close_brace
    ],
    tokens_week4_greater: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 3},
      :greater_than,
      {:constant, 3},
      :semicolon,
      :close_brace
    ],
    tokens_week4_greaterEqual: [
      :int_keyword,
      :main_keyword,
      :open_paren,
      :close_paren,
      :open_brace,
      :return_keyword,
      {:constant, 3},
      :greater_eq_than,
      {:constant, 3},
      :semicolon,
      :close_brace
    ]
    }
  end

  # tests to pass
  #test 1
  test "return 2", state do

    #code to tokenize
    code = """
      int main() {
        return 2;
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The result is passed to the lexer   |  It is compared with the list of tentative tokens
    assert Lexer.scan_words(s_code)      ==  state[:tokens_week1]

    #"assert" is responsible for comparing the two expressions and if they are equal, the test is approved
  end

  #test 2
  test "return 0", state do
    #code to tokenize
    code = """
      int main() {
        return 0;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The list is updated so that the constant 0 is expected as a token
    #The method List.updated_at() is used, indicating which list, the position of the element and the new value
    expected_result = List.update_at(state[:tokens_week1], 6, fn _ -> {:constant, 0} end)

    #The sanitized code is passed to the lexer and compared to the updated list of tentative tokens
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test 3
  test "multi_digit", state do
    code = """
      int main() {
        return 100;
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The list is updated so that the multi-digit constant 100 is expected as a token
    expected_result = List.update_at(state[:tokens_week1], 6, fn _ -> {:constant, 100} end)

    #The sanitized code is passed to the lexer and compared to the updated list of tentative tokens
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test 4
  test "new_lines", state do
    #code to tokenize
    code = """
    int
    main
    (
    )
    {
    return
    2
    ;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #compare the output of the lexer with the list of tokens
    assert Lexer.scan_words(s_code) == state[:tokens_week1]
  end

  #test 5
  test "no_newlines", state do
    #code to tokenize
    code = """
    int main(){return 2;}
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #compare the output of the lexer with the list of tokens
    assert Lexer.scan_words(s_code) == state[:tokens_week1]
  end

  #test 6
  test "spaces", state do
    #code to tokenize
    code = """
    int   main    (  )  {   return  2 ; }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #compare the output of the lexer with the list of tokens
    assert Lexer.scan_words(s_code) == state[:tokens_week1]
  end

  #test 7
  test "mix of spaces", state do
    #code to tokenize
    code = """
    int main
    (
                )
    {   return
    2000000000000
    ;}
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The list is updated so that the multi-digit constant 2000000000000 is expected as a token
    expected_result = List.update_at(state[:tokens_week1], 6, fn _ -> {:constant, 2000000000000} end)

    #The sanitized code is passed to the lexer and compared to the updated list of tentative tokens
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test 8
  test "return value in parentheses", state do
    #code to tokenize
    code = """
      int main() {
        return (2) ;
    }
    """
     #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the list of tokens is updated, using the List.insert_at method, adding the parentheses that the lexer must detect.

    expected_result = List.insert_at(state[:tokens_week1], 6, :open_paren)
    expected_result2 = List.insert_at(expected_result, 8, :close_paren)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end

  #test 9
  test "elements separated just by spaces", state do

    #The lexer is given a tokenizer code and the output is directly compared to the list of expected tokens.
    assert Lexer.scan_words(["int", "main(){return", "2;}"]) == state[:tokens_week1]
  end

  #test 10
  test "function name separated of function body", state do

    #The lexer is given a tokenizer code and the output is directly compared to the list of expected tokens.
    assert Lexer.scan_words(["int", "main()", "{return", "2;}"]) == state[:tokens_week1]
  end

  #test 11
  test "everything is separated", state do

    #The lexer is given a tokenizer code and the output is directly compared to the list of expected tokens.
    assert Lexer.scan_words(["int", "main", "(", ")", "{", "return", "2", ";", "}"]) == state[:tokens_week1]
  end

  #test 12
  test "Bitwise", state do
    code = """
      int main() {
      return ~12;
      }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens_week2_Bitwise], 7, fn _ -> {:constant, 12} end)
    assert Lexer.scan_words(s_code) == expected_result
    end

  #test 13
  test "Negation", state do
    code = """
      int main() {
      return -12;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens_week2_Negation], 7, fn _ -> {:constant, 12} end)
    assert Lexer.scan_words(s_code) == expected_result
    end

  #test 14
    test "Logical negation", state do
      code = """
        int main() {
        return !12;
        }
      """
      #The code is passed through the sanitizer
      s_code = Sanitizer.sanitize_source(code)

      expected_result = List.update_at(state[:tokens_week2_LogicN], 7, fn _ -> {:constant, 12} end)
      assert Lexer.scan_words(s_code) == expected_result
      end

  #test 15
    test "Negation+Bitwise+Logical negation", state do
      code = """
        int main() {
        return -~!2;
        }
      """
      #The code is passed through the sanitizer
      s_code = Sanitizer.sanitize_source(code)

      expected_result = List.insert_at(state[:tokens_week2_Negation],7,:complement)
      expected_result2 = List.insert_at(expected_result,8,:logic)
      assert Lexer.scan_words(s_code) == expected_result2
      end

  #test 16
  test "Bitwise+Logical negation+Negation", state do
    code = """
      int main() {
      return ~!-2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.insert_at(state[:tokens_week2_Bitwise],7,:logic)
    expected_result2 = List.insert_at(expected_result, 8, :negative)
    assert Lexer.scan_words(s_code) == expected_result2
  end


  #test 17
  test "Logical negation+Negation+Bitwise", state do
    code = """
      int main() {
      return !-~2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.insert_at(state[:tokens_week2_LogicN], 7, :negative)
    expected_result2 = List.insert_at(expected_result, 8, :complement)
    assert Lexer.scan_words(s_code) == expected_result2
  end

  #test 18expected_result2
  test "Bitwise+Negation+Logical negation", state do
    code = """
      int main() {
      return ~-!2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.insert_at(state[:tokens_week2_Bitwise],7,:negative)
    expected_result2 = List.insert_at(expected_result, 8, :logic)
    assert Lexer.scan_words(s_code) == expected_result2
  end

  #test 19
  test "No_Five", state do
    code = """
      int main() {
      return !5;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens_week2_LogicN], 7, fn _ -> {:constant, 5} end)
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test 20
  test "No_Zero", state do
    code = """
      int main() {
      return !0;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens_week2_LogicN], 7, fn _ -> {:constant, 0} end)
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test 21
  test "Bitwise_Zero", state do
    code = """
      int main() {
      return ~0;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    expected_result = List.update_at(state[:tokens_week2_Bitwise], 7, fn _ -> {:constant, 0} end)
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test 22 Week 3
  test "Normal_addition", state do
    code = """
      int main() {
      return 2+2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_addition1]
  end

  #Test 23 Week 3
  test "Addition_after_constant", state do
    code = """
      int main() {
      return +2+2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_addition2]
  end

  #Test 24 Week 3
  test "Normal_subtraction", state do
    code = """
      int main() {
      return 2-2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_subtraction1]
  end

  #Test 25 Week 3
  test "Negative_after_constant", state do
    code = """
      int main() {
      return -2-2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_subtraction2]
  end

  #Test 26 Week 3
  test "Mixed_Binary_Case1", state do
    code = """
      int main() {
      return -2+2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_binary1]
  end

  #Test 27 Week 3
  test "Mixed_Binary_Case2", state do
    code = """
      int main() {
      return +2-2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_binary2]
  end

  #Test 28 Week 3
  test "Normal_multiplication", state do
    code = """
      int main() {
      return 2*2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_multiplication1]
  end

  #Test 29 Week 3
  test "Normal_division", state do
    code = """
      int main() {
      return 2/2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_division]
  end

  #Test 30 Week 3
  test "Addition_with_parens_Case1", state do
    code = """
      int main() {
      return (2)+(2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_addition1],6,:open_paren)
    expected_result2 = List.insert_at(expected_result, 8, :close_paren)
    expected_result3 = List.insert_at(expected_result2, 10, :open_paren)
    expected_result4 = List.insert_at(expected_result3, 12, :close_paren)

    assert Lexer.scan_words(s_code) == expected_result4
  end

  #Test 31 Week 3
  test "Subtraction_with_parens_Case1", state do
    code = """
      int main() {
      return (2)-(2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_subtraction1],6,:open_paren)
    expected_result2 = List.insert_at(expected_result, 8, :close_paren)
    expected_result3 = List.insert_at(expected_result2, 10, :open_paren)
    expected_result4 = List.insert_at(expected_result3, 12, :close_paren)

    assert Lexer.scan_words(s_code) == expected_result4
  end

  #Test 32 Week 3
  test "Addition_with_parens_Case2", state do
    code = """
      int main() {
      return (+2)+(+2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_addition2],6,:open_paren)
    expected_result2 = List.insert_at(expected_result, 9, :close_paren)
    expected_result3 = List.insert_at(expected_result2, 10, :addition)
    expected_result4 = List.insert_at(expected_result3, 11, :open_paren)
    expected_result5 = List.insert_at(expected_result4, 14, :close_paren)

    assert Lexer.scan_words(s_code) == expected_result5
  end

  #Test 33 Week 3
  test "Subtraction_with_parens_Case2", state do
    code = """
      int main() {
      return (-2)-(-2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_subtraction2],6,:open_paren)
    expected_result2 = List.insert_at(expected_result, 9, :close_paren)
    expected_result3 = List.insert_at(expected_result2, 10, :negative)
    expected_result4 = List.insert_at(expected_result3, 11, :open_paren)
    expected_result5 = List.insert_at(expected_result4, 14, :close_paren)

    assert Lexer.scan_words(s_code) == expected_result5
  end

  #Test 34 Week 3
  test "Binary1_with_parens_Case1", state do
    code = """
      int main() {
      return (+2)+(-2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_binary2],6,:open_paren)
    expected_result2 = List.insert_at(expected_result, 9, :close_paren)
    expected_result3 = List.insert_at(expected_result2, 10, :addition)
    expected_result4 = List.insert_at(expected_result3, 11, :open_paren)
    expected_result5 = List.insert_at(expected_result4, 14, :close_paren)

    assert Lexer.scan_words(s_code) == expected_result5
  end

  #Test 35 Week 3
  test "Binary2_with_parens_Case2", state do
    code = """
      int main() {
      return (-2)+(+2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_binary1],6,:open_paren)
    expected_result2 = List.insert_at(expected_result, 9, :close_paren)
    expected_result3 = List.insert_at(expected_result2, 10, :addition)
    expected_result4 = List.insert_at(expected_result3, 11, :open_paren)
    expected_result5 = List.insert_at(expected_result4, 14, :close_paren)

    assert Lexer.scan_words(s_code) == expected_result5
  end

  #Test 36 Week 3
  test "Binary1_with_parens_Case2", state do
    code = """
      int main() {
      return (-2)-(+2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_binary1],6,:open_paren)
    expected_result2 = List.insert_at(expected_result, 9, :close_paren)
    expected_result3 = List.insert_at(expected_result2, 10, :negative)
    expected_result4 = List.insert_at(expected_result3, 11, :open_paren)
    expected_result5 = List.insert_at(expected_result4, 14, :close_paren)

    assert Lexer.scan_words(s_code) == expected_result5
  end

  #Test 37 Week 3
  test "Binary2_with_parens_Case1", state do
    code = """
      int main() {
      return (+2)-(-2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_binary2],6,:open_paren)
    expected_result2 = List.insert_at(expected_result, 9, :close_paren)
    expected_result3 = List.insert_at(expected_result2, 10, :negative)
    expected_result4 = List.insert_at(expected_result3, 11, :open_paren)
    expected_result5 = List.insert_at(expected_result4, 14, :close_paren)

    assert Lexer.scan_words(s_code) == expected_result5
  end

  #Test 38 Week 3
  test "Normal_multiplication_with_parens_Case1", state do
    code = """
      int main() {
      return (2)*(2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_multiplication2]
  end

  #Test 39 Week 3
  test "Normal_multiplication_with_parens_Case2", state do
    code = """
      int main() {
      return (+2)*(+2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_multiplication2],7,:addition)
    expected_result2 = List.insert_at(expected_result, 12, :addition)

    assert Lexer.scan_words(s_code) == expected_result2
  end

  #Test 40 Week 3
  test "Normal_multiplication_with_parens_Case3", state do
    code = """
      int main() {
      return (+2)*(-2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_multiplication2],7,:addition)
    expected_result2 = List.insert_at(expected_result, 12, :negative)

    assert Lexer.scan_words(s_code) == expected_result2
  end

  #Test 41 Week 3
  test "Normal_multiplication_with_parens_Case4", state do
    code = """
      int main() {
      return (-2)*(+2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_multiplication2],7,:negative)
    expected_result2 = List.insert_at(expected_result, 12, :addition)

    assert Lexer.scan_words(s_code) == expected_result2
  end

  #Test 42 Week 3
  test "Normal_multiplication_with_parens_Case5", state do
    code = """
      int main() {
      return (-2)*(-2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_multiplication2],7,:negative)
    expected_result2 = List.insert_at(expected_result, 12, :negative)

    assert Lexer.scan_words(s_code) == expected_result2
  end

  #Test 43 Week 3
  test "Normal_division_with_parens_Case1", state do
    code = """
      int main() {
      return (2)/(2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    assert Lexer.scan_words(s_code) == state[:tokens_week3_division2]
  end

  #Test 44 Week 3
  test "Normal_division_with_parens_Case2", state do
    code = """
      int main() {
      return (+2)/(+2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_division2],7,:addition)
    expected_result2 = List.insert_at(expected_result, 12, :addition)

    assert Lexer.scan_words(s_code) == expected_result2
  end

  #Test 45 Week 3
  test "Normal_division_with_parens_Case3", state do
    code = """
      int main() {
      return (+2)/(-2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_division2],7,:addition)
    expected_result2 = List.insert_at(expected_result, 12, :negative)

    assert Lexer.scan_words(s_code) == expected_result2
  end

  #Test 46 Week 3
  test "Normal_division_with_parens_Case4", state do
    code = """
      int main() {
      return (-2)/(+2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_division2],7,:negative)
    expected_result2 = List.insert_at(expected_result, 12, :addition)

    assert Lexer.scan_words(s_code) == expected_result2
  end

  #Test 47 Week 3
  test "Normal_division_with_parens_Case5", state do
    code = """
      int main() {
      return (-2)/(-2);
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    expected_result = List.insert_at(state[:tokens_week3_division2],7,:negative)
    expected_result2 = List.insert_at(expected_result, 12, :negative)

    assert Lexer.scan_words(s_code) == expected_result2
  end

  # tests to fail

  #test
  test "missing open_paren", state do
    #code to tokenize
    code = """
      int main){
        return 2;
      }
    """
     #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The opening parenthesis is removed from the list of expected tokens, since the lexer is expected to detect that it is missing.
    expected_result  = List.delete_at(state[:tokens_week1], 2)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test
  test "missing close_paren", state do
    #code to tokenize
    code = """
      int main( {
        return 2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The closing parenthesis is removed from the list of expected tokens, since the lexer is expected to detect that it is missing.
    expected_result  = List.delete_at(state[:tokens_week1], 3)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test
  test "missing open_brace", state do
    #code to tokenize
    code = """
      int main()
        return 2;
      }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The opening brace is removed from the list of expected tokens, since the lexer is expected to detect that it is missing.
    expected_result = List.delete_at(state[:tokens_week1], 4)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test
  test "missing close_brace", state do
    #code to tokenize
    code = """
      int main() {
        return 2;

    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The closing brace is removed from the list of expected tokens, since the lexer is expected to detect that it is missing.
    expected_result = List.delete_at(state[:tokens_week1], 8)

    #compare the output of the lexer with the list of tokens
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test
  test "wrong case", state do
    #code to tokenize
    code = """
    int main() {
      RETURN 2;
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The expected result is defined: error on the keyword "return".
    expected_result = List.update_at(state[:tokens_week1], 5, fn _ -> :error end)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test
  test "missing return value", state do
    #code to tokenize
    code = """
      int main() {
        return;
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the return constant is missing.
    expected_result = List.delete_at(state[:tokens_week1], 6)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test
  test "missing semicolon", state do
    #code to tokenize
    code = """
      int main() {
        return 2
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = List.delete_at(state[:tokens_week1], 7)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test
  test "wrong symbol", state do
    #code to tokenize
    code = """
      int main() {
        return 2 :
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #T he expected result is defined: the symbol in the position of the semicolon is incorrect.
    expected_result = List.update_at(state[:tokens_week1], 7, fn _ -> :error end)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test
  test "wrong return value", state do
    #code to tokenize
    code = """
      int main() {
        return a ;
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #The expected result is defined: the return value is incorrect.
    expected_result = List.update_at(state[:tokens_week1], 6, fn _ -> :error end)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "bitwise after constant", state do
    #code to tokenize
    code = """
      int main() {
        return 2~;
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the return constant is missing.
    expected_result = List.delete_at(state[:tokens_week2_Bitwise], 6)
    expected_result2 = List.insert_at(expected_result,7,:complement)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end


  #test
  test "missing return value - logic", state do
    #code to tokenize
    code = """
      int main() {
        return !;
    }
    """
    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the return constant is missing.
    expected_result = List.delete_at(state[:tokens_week2_LogicN], 7)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #test
  test "missing semicolon - logic", state do
    #code to tokenize
    code = """
      int main() {
        return !2
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = List.delete_at(state[:tokens_week2_LogicN], 8)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "missing semicolon - negative", state do
    #code to tokenize
    code = """
      int main() {
        return -2
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = List.delete_at(state[:tokens_week2_Negation], 8)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  test "missing semicolon - Bitwise", state do
    #code to tokenize
    code = """
      int main() {
        return ~2
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = List.delete_at(state[:tokens_week2_Bitwise], 8)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 1 Week 3 - Error Case
  test "literal_Case1", state do
    code = """
    int main() {
      return a+2;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = List.update_at(state[:tokens_week3_addition1], 6, fn _ -> :error end)
    expected_result2=List.delete_at(expected_result, 7)
    expected_result3=List.delete_at(expected_result2, 7)
    expected_result4=List.delete_at(expected_result3, 7)
    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result4
  end

  #Test 1 Week 4
  test "And_Case1", state do
    code = """
    int main() {
      return 3&&3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = state[:tokens_week4_and]

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 2 Weak 4
  test "And_Case2", state do
    code = """
    int main() {
      return 3&&-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    #List.update_at(state[:tokens_week3_addition1], 6, fn _ -> :error end)
    #fn _ -> {:constant, 0} end
    #expected_result = List.insert_at(state[:tokens_week4_and],7,:negative) -->with insert or replace
    #expected_result = List.update_at(state[:tokens_week4_and],7,fn _ -> :negative end) --> with function update
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_and],8,:negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 3 Weak 4
  test "And_Case3", state do
    code = """
    int main() {
      return -3&&3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_and],6,:negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 3 Weak 4
  test "And_Case4", state do
    code = """
    int main() {
      return -3&&-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_and], 6, :negative)
    expected_result2 = List.insert_at(expected_result, 9, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end

  ######

  #Test 5 Week 4
  test "Or_Case1", state do
    code = """
    int main() {
      return 3||3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = state[:tokens_week4_or]

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 6 Weak 4
  test "Or_Case2", state do
    code = """
    int main() {
      return 3||-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_or],8,:negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 7 Weak 4
  test "Or_Case3", state do
    code = """
    int main() {
      return -3||3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_or],6,:negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 8 Weak 4
  test "Or_Case4", state do
    code = """
    int main() {
      return -3||-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_or], 6, :negative)
    expected_result2 = List.insert_at(expected_result, 9, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end

  ######

  #Test 9 Week 4
  test "Equal_Case1", state do
    code = """
    int main() {
      return 3==3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = state[:tokens_week4_equal]

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 10 Weak 4
  test "Equal_Case2", state do
    code = """
    int main() {
      return 3==-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_equal],8,:negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 11 Weak 4
  test "Equal_Case3", state do
    code = """
    int main() {
      return -3==3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_equal],6,:negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 12 Weak 4
  test "Equal_Case4", state do
    code = """
    int main() {
      return -3==-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_equal], 6, :negative)
    expected_result2 = List.insert_at(expected_result, 9, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end

  #####

  #Test 13 Week 4
  test "notEqual_Case1", state do
    code = """
    int main() {
      return 3!=3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = state[:tokens_week4_noEqual]

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 14 Weak 4
  test "notEqual_Case2", state do
    code = """
    int main() {
      return 3!=-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_noEqual], 8, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 15 Weak 4
  test "notEqual_Case3", state do
    code = """
    int main() {
      return -3!=3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_noEqual], 6, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 16 Weak 4
  test "notEqual_Case4", state do
    code = """
    int main() {
      return -3!=-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_noEqual], 6, :negative)
    expected_result2 = List.insert_at(expected_result, 9, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end

  #####

  #Test 17 Week 4
  test "less_Case1", state do
    code = """
    int main() {
      return 3<3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = state[:tokens_week4_less]

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 18 Weak 4
  test "less_Case2", state do
    code = """
    int main() {
      return 3<-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_less], 8, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 19 Weak 4
  test "less_Case3", state do
    code = """
    int main() {
      return -3<3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_less], 6, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 20 Weak 4
  test "less_Case4", state do
    code = """
    int main() {
      return -3<-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_less], 6, :negative)
    expected_result2 = List.insert_at(expected_result, 9, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end

  #####

  #Test 21 Week 4
  test "lessEqual_Case1", state do
    code = """
    int main() {
      return 3<=3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = state[:tokens_week4_lessEqual]

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 22 Weak 4
  test "lessEqual_Case2", state do
    code = """
    int main() {
      return 3<=-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_lessEqual], 8, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 23 Weak 4
  test "lessEqual_Case3", state do
    code = """
    int main() {
      return -3<=3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_lessEqual], 6, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 24 Weak 4
  test "lessEqual_Case4", state do
    code = """
    int main() {
      return -3<=-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_lessEqual], 6, :negative)
    expected_result2 = List.insert_at(expected_result, 9, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end

  #####

  #Test 25 Week 4
  test "greater_Case1", state do
    code = """
    int main() {
      return 3>3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = state[:tokens_week4_greater]

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 26 Weak 4
  test "greater_Case2", state do
    code = """
    int main() {
      return 3>-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_greater], 8, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 27 Weak 4
  test "greater_Case3", state do
    code = """
    int main() {
      return -3>3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_greater], 6, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 28 Weak 4
  test "greater_Case4", state do
    code = """
    int main() {
      return -3>-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_greater], 6, :negative)
    expected_result2 = List.insert_at(expected_result, 9, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end

  #####

  #Test 29 Week 4
  test "greaterEqual_Case1", state do
    code = """
    int main() {
      return 3>=3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)

    #the expected result is defined: the semicolon is missing.
    expected_result = state[:tokens_week4_greaterEqual]

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 30 Weak 4
  test "greaterEqual_Case2", state do
    code = """
    int main() {
      return 3>=-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_greaterEqual], 8, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 31 Weak 4
  test "greaterEqual_Case3", state do
    code = """
    int main() {
      return -3>=3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_greaterEqual], 6, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result
  end

  #Test 32 Weak 4
  test "greaterEqual_Case4", state do
    code = """
    int main() {
      return -3>=-3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.insert_at(state[:tokens_week4_greaterEqual], 6, :negative)
    expected_result2 = List.insert_at(expected_result, 9, :negative)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result2
  end
  
  #Test 33-40 Weak 4 Error Global
  test "Error_Case_global", state do
    code = """
    int main() {
      return 3&3;
    }
    """

    #The code is passed through the sanitizer
    s_code = Sanitizer.sanitize_source(code)
    
    #the expected result is defined: the semicolon is missing.
    expected_result = List.update_at(state[:tokens_week4_and], 7, fn _ -> :error end)
    expected_result2 = List.delete_at(expected_result,8)
    expected_result3 = List.delete_at(expected_result2,8)

    #compare the output of the lexer with the expected result
    assert Lexer.scan_words(s_code) == expected_result3
  end

end
