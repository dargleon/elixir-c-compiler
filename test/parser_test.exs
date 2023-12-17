defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  setup_all do
    {:ok,
    failed_UnaryOp: {:error, "Error: Unary operator in wrong position"},
    failed_Semicolon: {:error, "Error: semicolon missing after constant to finish return statement"},
    failed_ReturnKW: {:error, "Error: missing return keyword"},
    failed_return_value: {:error, "Error: constant value missed"},
      normal_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: nil,
              node_name: :constant,
              right_node: nil,
              value: 2
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      logic_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 0
              },
              node_name: :logic,
              right_node: nil,
              value: "!"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      negation_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 0
              },
              node_name: :negative,
              right_node: nil,
              value: "-"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      bitwise_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 0
              },
              node_name: :complement,
              right_node: nil,
              value: "~"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      mixed_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: %AST{
                    left_node: nil,
                    node_name: :constant,
                    right_node: nil,
                    value: 0
                  },
                  node_name: :logic,
                  right_node: nil,
                  value: "!"
                },
                node_name: :complement,
                right_node: nil,
                value: "~"
              },
              node_name: :negative,
              right_node: nil,
              value: "-"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      multi_mixed_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: %AST{
                    left_node: %AST{
                      left_node: %AST{
                        left_node: %AST{
                          left_node: %AST{
                            left_node: %AST{
                              left_node: %AST{
                                left_node: %AST{
                                  left_node: %AST{
                                    left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 0},
                                    node_name: :negative,
                                    right_node: nil,
                                    value: "-"
                                  },
                                  node_name: :negative,
                                  right_node: nil,
                                  value: "-"
                                },
                                node_name: :negative,
                                right_node: nil,
                                value: "-"
                              },
                              node_name: :complement,
                              right_node: nil,
                              value: "~"
                            },
                            node_name: :complement,
                            right_node: nil,
                            value: "~"
                          },
                          node_name: :complement,
                          right_node: nil,
                          value: "~"
                        },
                        node_name: :logic,
                        right_node: nil,
                        value: "!"
                      },
                      node_name: :logic,
                      right_node: nil,
                      value: "!"
                    },
                    node_name: :logic,
                    right_node: nil,
                    value: "!"
                  },
                  node_name: :negative,
                  right_node: nil,
                  value: "-"
                },
                node_name: :negative,
                right_node: nil,
                value: "-"
              },
              node_name: :negative,
              right_node: nil,
              value: "-"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      div_add_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constant,
                  right_node: nil,
                  value: 12
                },
                node_name: :division,
                right_node: %AST{
                  left_node: nil,
                  node_name: :constant,
                  right_node: nil,
                  value: 4
                },
                value: "/"
              },
              node_name: :addition,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 10
              },
              value: "+"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      div_add_paren_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 12
              },
              node_name: :division,
              right_node: %AST{
                left_node: %AST{
                  left_node: nil,
                  node_name: :constant,
                  right_node: nil,
                  value: 4
                },
                node_name: :addition,
                right_node: %AST{
                  left_node: nil,
                  node_name: :constant,
                  right_node: nil,
                  value: 10
                },
                value: "+"
              },
              value: "/"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      multi_opBin_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{
                  left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 2},
                  node_name: :addition,
                  right_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 4},
                  value: "+"
                },
                node_name: :multiplication,
                right_node: %AST{
                  left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 3},
                  node_name: :negative,
                  right_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 1},
                  value: "-"
                },
                value: "*"
              },
              node_name: :division,
              right_node: %AST{
                left_node: %AST{
                  left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 9},
                  node_name: :negative,
                  right_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 4},
                  value: "-"
                },
                node_name: :multiplication,
                right_node: %AST{
                  left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 6},
                  node_name: :addition,
                  right_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 7},
                  value: "+"
                },
                value: "*"
              },
              value: "/"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      multi_opBin_opUn_ast: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 3},
                node_name: :addition,
                right_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 1},
                value: "+"
              },
              node_name: :negative,
              right_node: %AST{
                left_node: %AST{
                  left_node: %AST{
                    left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 7},
                    node_name: :logic,
                    right_node: nil,
                    value: "!"
                  },
                  node_name: :negative,
                  right_node: %AST{
                    left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 5},
                    node_name: :negative,
                    right_node: nil,
                    value: "-"
                  },
                  value: "-"
                },
                node_name: :negative,
                right_node: %AST{
                  left_node: %AST{
                    left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 4},
                    node_name: :multiplication,
                    right_node: %AST{
                      left_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 6},
                      node_name: :complement,
                      right_node: nil,
                      value: "~"
                    },
                    value: "*"
                  },
                  node_name: :addition,
                  right_node: %AST{left_node: nil, node_name: :constant, right_node: nil, value: 0},
                  value: "+"
                },
                value: "-"
              },
              value: "-"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      normal_addition: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 2
              },
              node_name: :addition,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 2
              },
              value: "+"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      normal_subtraction: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 2
              },
              node_name: :negative,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 2
              },
              value: "-"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      normal_multiplication: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 2
              },
              node_name: :multiplication,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 2
              },
              value: "*"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      normal_division: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 2
              },
              node_name: :division,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 2
              },
              value: "/"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      And_operator: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              node_name: :and,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: "&&"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      Or_operator: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              node_name: :or,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: "||"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      Equal_operator: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              node_name: :equal,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: "=="
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      notEqual_operator: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              node_name: :not_equal,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: "!="
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      less_operator: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              node_name: :less_than,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: "<"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      lessEqual_operator: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              node_name: :less_eq_than,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: "<="
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      greater_operator: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              node_name: :greater_than,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: ">"
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      },
      greaterEqual_operator: %AST{
        left_node: %AST{
          left_node: %AST{
            left_node: %AST{
              left_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              node_name: :greater_eq_than,
              right_node: %AST{
                left_node: nil,
                node_name: :constant,
                right_node: nil,
                value: 3
              },
              value: ">="
            },
            node_name: :return,
            right_node: nil,
            value: :return
          },
          node_name: :function,
          right_node: nil,
          value: :main
        },
        node_name: :program,
        right_node: nil,
        value: :program
      }
    }
  end

  test "return_2",state do
    code = """
      int main() {
      return 2;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_ast]
  end

  test "logic_Zero",state do
    code = """
      int main() {
      return !0;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:logic_ast]
  end

  test "Negation_Zero",state do
    code = """
      int main() {
      return -0;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:negation_ast]
  end

  test "Bitwise_Zero",state do
   code = """
      int main() {
      return ~0;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:bitwise_ast]
  end

  test "Mixed_unary_op",state do
    code = """
      int main() {
      return -~!0;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)
    assert Parser.parse_program(l_tokens) == state[:mixed_ast]
  end

  test "Multi_Mixed_unary_op",state do
    code = """
      int main() {
      return ---!!!~~~---0;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:multi_mixed_ast]
  end


  #Tests to failed
  test "missing_Semicolon",state do
    code = """
      int main() {
      return 2
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_Semicolon]
  end

  test "missing_return_KW",state do
    code = """
      int main() {
       2;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_ReturnKW]
  end

  test "missing_return_value",state do
    code = """
      int main() {
       return ;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order",state do
    code = """
      int main() {
      return 0-;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order2",state do
    code = """
      int main() {
      return 2-;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order3",state do
    code = """
      int main() {
      return 0!;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_UnaryOp]
  end

  test "wrong_order4",state do
    code = """
      int main() {
      return 0~;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_UnaryOp]
  end

  test "wrong_order5",state do
    code = """
      int main() {
      return -12-;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order6",state do
    code = """
      int main() {
      return !-~2~-!;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_UnaryOp]
  end

  #Tests for week3

  test "wrong_order7",state do
    code = """
      int main() {
      return 2+;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order8",state do
    code = """
      int main() {
      return 2*;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order9",state do
    code = """
      int main() {
      return 2/;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order10",state do
    code = """
      int main() {
      return 2+5+;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order11",state do
    code = """
      int main() {
      return 2+5-;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order12",state do
    code = """
      int main() {
      return 2-5+;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order13",state do
    code = """
      int main() {
      return 2-5-;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order14",state do
    code = """
      int main() {
      return 2+5*;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order15",state do
    code = """
      int main() {
      return 2+5/;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order16",state do
    code = """
      int main() {
      return 2-5*;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order17",state do
    code = """
      int main() {
      return 2-5/;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order18",state do
    code = """
      int main() {
      return 2*5*;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order19",state do
    code = """
      int main() {
      return 2*5+;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order20",state do
    code = """
      int main() {
      return 2*5-;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order21",state do
    code = """
      int main() {
      return 2*5/;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order22",state do
    code = """
      int main() {
      return 2/5/;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order23",state do
    code = """
      int main() {
      return 2/5*;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order24",state do
    code = """
      int main() {
      return 2+5+7+;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "wrong_order25",state do
    code = """
      int main() {
      return 2+5-7-;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Bad_order_case1",state do
    code = """
    int main(){
      return /3*6+4;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Bad_order_case2",state do
    code = """
    int main(){
      return *3/6+4;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Bad_order_case3",state do
    code = """
    int main(){
      return +3+3+;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "simply_addition_case1",state do
    code = """
    int main(){
      return 2+2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_addition]
  end

  test "simply_addition_case2",state do
    code = """
    int main(){
      return (2+2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_addition]
  end

  test "simply_addition_case3",state do
    code = """
    int main(){
      return (2)+(2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_addition]
  end

  test "simply_addition_case4",state do
    code = """
    int main(){
      return (2)+2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_addition]
  end

  test "simply_addition_case5",state do
    code = """
    int main(){
      return 2+(2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_addition]
  end

  test "simply_subtraction_case1",state do
    code = """
    int main(){
      return 2-2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_subtraction]
  end

  test "simply_subtraction_case2",state do
    code = """
    int main(){
      return (2-2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_subtraction]
  end

  test "simply_subtraction_case3",state do
    code = """
    int main(){
      return (2)-(2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_subtraction]
  end

  test "simply_subtraction_case4",state do
    code = """
    int main(){
      return (2)-2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_subtraction]
  end

  test "simply_subtraction_case5",state do
    code = """
    int main(){
      return 2-(2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_subtraction]
  end

  test "simply_multiplication_case1",state do
    code = """
    int main(){
      return 2*2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_multiplication]
  end


  test "simply_multiplication_case2",state do
    code = """
    int main(){
      return (2*2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_multiplication]
  end


  test "simply_multiplication_case3",state do
    code = """
    int main(){
      return (2)*(2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_multiplication]
  end


  test "simply_multiplication_case4",state do
    code = """
    int main(){
      return (2)*2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_multiplication]
  end


  test "simply_multiplication_case5",state do
    code = """
    int main(){
      return 2*(2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_multiplication]
  end

  test "simply_division_case1",state do
    code = """
    int main(){
      return 2/2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_division]
  end

  test "simply_division_case2",state do
    code = """
    int main(){
      return (2/2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_division]
  end

  test "simply_division_case3",state do
    code = """
    int main(){
      return (2)/(2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_division]
  end

  test "simply_division_case4",state do
    code = """
    int main(){
      return (2)/2;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_division]
  end

  test "simply_division_case5",state do
    code = """
    int main(){
      return 2/(2);
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:normal_division]
  end

  test "Mixed_binary_op",state do
    code = """
      int main(){
        return ((2+4)*(3-1))/((9-4)*(6+7));
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:multi_opBin_ast]
  end

  test "divition_addition",state do
    code = """
      int main(){
        return 12/4 + 10;
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:div_add_ast]
  end

  test "divition_addition_paren",state do
    code = """
      int main(){
        return 12/(4 + 10);
      }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer.scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:div_add_paren_ast]
  end

  test "Mixed_binaryOp_unaryOP",state do
    code = """
    int main(){
      return 3+1-!7--5-4*~6+0;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:multi_opBin_opUn_ast]
  end

  #####

  test "Error_and_Case1",state do
    code = """
    int main(){
      return &&3&&3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Error_and_Case2",state do
    code = """
    int main(){
      return 3&&3&&;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  #####

  test "Error_or_Case1",state do
    code = """
    int main(){
      return ||3||3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Error_or_Case2",state do
    code = """
    int main(){
      return 3||3||;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  #####

  test "Error_equal_Case1",state do
    code = """
    int main(){
      return ==3==3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Error_equal_Case2",state do
    code = """
    int main(){
      return 3==3==;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  #####

  test "Error_notequal_Case1",state do
    code = """
    int main(){
      return !=3!=3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Error_notequal_Case2",state do
    code = """
    int main(){
      return 3!=3!=;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  #####

  test "Error_less_Case1",state do
    code = """
    int main(){
      return <3<3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Error_less_Case2",state do
    code = """
    int main(){
      return 3<3<;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  #####

  test "Error_lessEqual_Case1",state do
    code = """
    int main(){
      return <=3<=3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Error_lessEqual_Case2",state do
    code = """
    int main(){
      return 3<=3<=;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  #####

  test "Error_greater_Case1",state do
    code = """
    int main(){
      return >3>3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Error_greater_Case2",state do
    code = """
    int main(){
      return 3>3>;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  #####

  test "Error_greaterEqual_Case1",state do
    code = """
    int main(){
      return >=3>=3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  test "Error_greaterEqual_Case2",state do
    code = """
    int main(){
      return 3>=3>=;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:failed_return_value]
  end

  ##### NORMAL-TEST #####

  test "Normal_and",state do
    code = """
    int main(){
      return 3&&3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:And_operator]
  end

  test "Normal_or",state do
    code = """
    int main(){
      return 3||3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:Or_operator]
  end

  test "Normal_Equal",state do
    code = """
    int main(){
      return 3==3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:Equal_operator]
  end

  test "Normal_notEqual",state do
    code = """
    int main(){
      return 3!=3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:notEqual_operator]
  end

  test "Normal_less",state do
    code = """
    int main(){
      return 3<3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:less_operator]
  end

  test "Normal_lessEqual",state do
    code = """
    int main(){
      return 3<=3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:lessEqual_operator]
  end

  test "Normal_greater",state do
    code = """
    int main(){
      return 3>3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:greater_operator]
  end

  test "Normal_greaterEqual",state do
    code = """
    int main(){
      return 3>=3;
    }
    """
    s_code = Sanitizer.sanitize_source(code)
    l_tokens = Lexer. scan_words(s_code)

    assert Parser.parse_program(l_tokens) == state[:greaterEqual_operator]
  end

end
