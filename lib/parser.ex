defmodule Parser do
  def parse_program(token_list) do
    function = parse_function(token_list)

    case function do
      {{:error, error_message}, _rest} ->
        {:error, error_message}

      {function_node, rest} ->
        if rest == [] do
          %AST{node_name: :program, left_node: function_node, value: :program}
        else
          {:error, "Error: there are more elements after function end"}
        end
    end
  end

  def parse_function([next_token | rest]) do
    if next_token == :int_keyword do
      [next_token | rest] = rest

      if next_token == :main_keyword do
        [next_token | rest] = rest

        if next_token == :open_paren do
          [next_token | rest] = rest

          if next_token == :close_paren do
            [next_token | rest] = rest

            if next_token == :open_brace do
              statement = parse_statement(rest)

              case statement do
                {{:error, error_message}, rest} ->
                  {{:error, error_message}, rest}

                {statement_node, [next_token | rest]} ->
                  if next_token == :close_brace do
                    {%AST{node_name: :function, value: :main, left_node: statement_node}, rest}
                  else
                    {{:error, "Error, close brace missed"}, rest}
                  end
              end
            else
              {{:error, "Error: open brace missed"},rest}
            end
          else
            {{:error, "Error: close parentesis missed"},rest}
          end
        else
          {{:error, "Error: open parentesis missed"},rest}
        end
      else
        {{:error, "Error: main function missed"},rest}
      end
    else
      {{:error, "Error: return type value missed"},rest}
    end
  end

  def parse_statement([next_token | rest]) do
    if next_token == :return_keyword do
      expression = parse_expression(rest,nil)

      case expression do
        {{:error, error_message}, rest} ->
          {{:error, error_message}, rest}

        {exp_node, [next_token | rest]} ->
          case next_token do
            :semicolon ->
              {%AST{node_name: :return, left_node: exp_node, value: :return}, rest}

            :negative ->
              {{:error, "Error: Unary operator in wrong position"}, rest}

            :complement ->
              {{:error, "Error: Unary operator in wrong position"}, rest}

            :logic ->
              {{:error, "Error: Unary operator in wrong position"}, rest}

            _ ->
              {{:error, "Error: semicolon missing after constant to finish return statement"}, rest}
          end
      end
    else
      {{:error, "Error: missing return keyword"}, rest}
    end
  end


  def parse_expression([next_token | rest],tree) do
    logic_and = parse_logic_and_exp([next_token | rest],tree)

    left=elem(logic_and, 0)
    rest=elem(logic_and, 1)

    [next_token|rest] = rest

    case next_token do
      :or ->

        next_logic_and = parse_logic_and_exp(rest,tree)

        right = elem(next_logic_and,0)
        rest = elem(next_logic_and,1)

        case right do
          {:error, error_message} ->
            {{:error, error_message},rest}

          _->
            new_tree=%AST{node_name: :or, left_node: left, right_node: right, value: "||"}

            [next_token|rest] = rest

            case next_token do
              :or ->

                rest_tree = parse_expression(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :or, left_node: new_tree, right_node: tree, value: "||"}, rest}
                end

              _->{new_tree, [next_token|rest]}
            end
        end
      _->{left,[next_token|rest]}
    end
  end

  def parse_logic_and_exp([next_token | rest],tree) do
    equal_exp = parse_equal_exp([next_token | rest],tree)

    left=elem(equal_exp, 0)
    rest=elem(equal_exp, 1)

    [next_token|rest] = rest

    case next_token do
      :and->

        next_equal_exp = parse_equal_exp(rest,tree)

        right = elem(next_equal_exp,0)
        rest = elem(next_equal_exp,1)

        case right do
          {:error, error_message} ->
            {{:error, error_message},rest}

          _->
            new_tree=%AST{node_name: :and, left_node: left, right_node: right, value: "&&"}

            [next_token|rest] = rest

            case next_token do
              :and ->

                rest_tree = parse_logic_and_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :and, left_node: new_tree, right_node: tree, value: "&&"}, rest}
                end

              _->{new_tree, [next_token|rest]}
            end
        end
      _->{left,[next_token|rest]}
    end
  end

  def parse_equal_exp([next_token | rest],tree) do
    relat_exp = parse_relational_exp([next_token | rest],tree)

    left=elem(relat_exp, 0)
    rest=elem(relat_exp, 1)

    [next_token|rest] = rest

    case next_token do
      :not_equal ->
        next_add_exp = parse_add_expression(rest,tree)

        right = elem(next_add_exp,0)
        rest = elem(next_add_exp,1)

        case right do
          {:error, error_message} ->
            {{:error, error_message},rest}

          _->
            new_tree=%AST{node_name: :not_equal, left_node: left, right_node: right, value: "!="}

            [next_token|rest] = rest

            case next_token do
              :not_equal ->
                rest_tree = parse_relational_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :not_equal, left_node: new_tree, right_node: tree, value: "!="}, rest}
                end

              :equal ->
                rest_tree = parse_relational_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :equal, left_node: new_tree, right_node: tree, value: "=="}, rest}
                end
              _->{new_tree, [next_token|rest]}
            end
        end

      :equal ->
        next_add_exp = parse_add_expression(rest,tree)

        right = elem(next_add_exp,0)
        rest = elem(next_add_exp,1)

        case right do
          {:error, error_message} ->
            {{:error, error_message},rest}

          _->
            new_tree=%AST{node_name: :equal, left_node: left, right_node: right, value: "=="}

            [next_token|rest] =rest

            case next_token do
              :not_equal ->
                rest_tree = parse_relational_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :not_equal, left_node: new_tree, right_node: tree, value: "!="}, rest}
                end

              :equal ->
                rest_tree = parse_relational_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :equal, left_node: new_tree, right_node: tree, value: "=="}, rest}
                end
              _->{new_tree, [next_token|rest]}
            end
        end
      _->{left,[next_token|rest]}
    end

  end

  def parse_relational_exp([next_token | rest],tree) do
    add_exp = parse_add_expression([next_token | rest],tree)

    left=elem(add_exp, 0)
    rest=elem(add_exp, 1)

    [next_token|rest] = rest

    case next_token do
      :less_eq_than ->
        next_add_exp = parse_relational_exp(rest,tree)

        right = elem(next_add_exp,0)
        rest = elem(next_add_exp,1)

        case right do
          {:error, error_message} ->
            {{:error, error_message},rest}

          _->
            new_tree=%AST{node_name: :less_eq_than, left_node: left, right_node: right, value: "<="}

            [next_token|rest] = rest

            case next_token do
              :less_eq_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :less_eq_than, left_node: new_tree, right_node: tree, value: "<="}, rest}
                end

              :greater_eq_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :greater_eq_than, left_node: new_tree, right_node: tree, value: ">="}, rest}
                end

              :less_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :less_than, left_node: new_tree, right_node: tree, value: "<"}, rest}
                end

              :greater_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :greater_than, left_node: new_tree, right_node: tree, value: ">"}, rest}
                end

              _->{new_tree, [next_token|rest]}
            end
        end

      :greater_eq_than ->
        next_add_exp = parse_relational_exp(rest,tree)

        right = elem(next_add_exp,0)
        rest = elem(next_add_exp,1)

        case right do
          {:error, error_message} ->
            {{:error, error_message},rest}

          _->
            new_tree=%AST{node_name: :greater_eq_than, left_node: left, right_node: right, value: ">="}

            [next_token|rest] = rest

            case next_token do
              :less_eq_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :less_eq_than, left_node: new_tree, right_node: tree, value: "<="}, rest}
                end

              :greater_eq_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :greater_eq_than, left_node: new_tree, right_node: tree, value: ">="}, rest}
                end

              :less_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :less_than, left_node: new_tree, right_node: tree, value: "<"}, rest}
                end

              :greater_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :greater_than, left_node: new_tree, right_node: tree, value: ">"}, rest}
                end

              _->{new_tree, [next_token|rest]}
            end
        end

      :less_than ->
        next_add_exp = parse_relational_exp(rest,tree)

        right = elem(next_add_exp,0)
        rest = elem(next_add_exp,1)

        case right do
          {:error, error_message} ->
            {{:error, error_message},rest}

          _->
            new_tree=%AST{node_name: :less_than, left_node: left, right_node: right, value: "<"}

            [next_token|rest] = rest

            case next_token do
              :less_eq_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :less_eq_than, left_node: new_tree, right_node: tree, value: "<="}, rest}
                end

              :greater_eq_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :greater_eq_than, left_node: new_tree, right_node: tree, value: ">="}, rest}
                end

              :less_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :less_than, left_node: new_tree, right_node: tree, value: "<"}, rest}
                end

              :greater_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :greater_than, left_node: new_tree, right_node: tree, value: ">"}, rest}
                end

              _->{new_tree, [next_token|rest]}
            end
        end

      :greater_than ->
        next_add_exp = parse_relational_exp(rest,tree)

        right = elem(next_add_exp,0)
        rest = elem(next_add_exp,1)

        case right do
          {:error, error_message} ->
            {{:error, error_message},rest}

          _->
            new_tree=%AST{node_name: :greater_than, left_node: left, right_node: right, value: ">"}

            [next_token|rest] = rest

            case next_token do
              :less_eq_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :less_eq_than, left_node: new_tree, right_node: tree, value: "<="}, rest}
                end

              :greater_eq_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :greater_eq_than, left_node: new_tree, right_node: tree, value: ">="}, rest}
                end

              :less_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :less_than, left_node: new_tree, right_node: tree, value: "<"}, rest}
                end

              :greater_than ->
                rest_tree = parse_equal_exp(rest,new_tree)
                tree=elem(rest_tree, 0)
                rest=elem(rest_tree, 1)

                case tree do
                  {:error, error_message} ->
                    {{:error, error_message},rest}

                  _->
                    {%AST{node_name: :greater_than, left_node: new_tree, right_node: tree, value: ">"}, rest}
                end

              _->{new_tree, [next_token|rest]}
            end
        end

      _->{left,[next_token|rest]}
    end
  end

  def parse_add_expression([next_token | rest],tree) do
    term = parse_term([next_token | rest],tree)

    left=elem(term, 0)
    rest=elem(term, 1)

    #next =  List.first(rest)
    [next_token|rest] = rest

    case next_token do
      :addition->
        #IO.puts("\nHe llegado aqui (+)")
        #[next_token | rest] = rest
        next_term = parse_term(rest,tree)

        case next_term do
          {:error, error_message} ->
            {{:error, error_message},rest}

          _->
            right = elem(next_term,0)
            rest = elem(next_term,1)

            #Arreglo de bug return -2-; right = {:error, "falta constante de retorno"}
            case right do
              {:error, error_message} ->
                {{:error, error_message},rest}

              _->
                new_tree=%AST{node_name: :addition, left_node: left, right_node: right, value: "+"}

                #next2 =  List.first(rest)
                [next_token | rest] = rest

                case next_token do
                  :addition ->
                    #IO.puts("\nHe llegado aqui (+C+)")
                    #[next_token | rest] = rest
                    rest_tree = parse_expression(rest,new_tree)
                    tree=elem(rest_tree, 0)
                    rest=elem(rest_tree, 1)

                    case tree do
                      {:error, error_message} ->
                        {{:error, error_message},rest}

                      _->
                        {%AST{node_name: :addition, left_node: new_tree, right_node: tree, value: "+"}, rest}
                    end

                  :negative ->
                    #IO.puts("\nHe llegado aqui (+C-)")
                    #[next_token | rest] = rest
                    rest_tree = parse_expression(rest,new_tree)
                    tree=elem(rest_tree, 0)
                    rest=elem(rest_tree, 1)

                    case tree do
                      {:error, error_message} ->
                        {{:error, error_message},rest}

                      _->
                        {%AST{node_name: :negative, left_node: new_tree, right_node: tree, value: "-"}, rest}
                    end
                  _->{new_tree, [next_token | rest]}
                end
            end
        end


      :negative ->
        #IO.puts("\nHe llegado aqui (-)")
        #[next_token | rest] = rest
        next_term = parse_term(rest,tree)

        case next_term do
          {:error, error_message} ->
            {{:error, error_message},rest}
          _->
            right = elem(next_term,0)
            rest = elem(next_term,1)

            case right do
              {:error, error_message} ->
                {{:error, error_message},rest}

              _->
                new_tree=%AST{node_name: :negative, left_node: left, right_node: right, value: "-"}

                [next_token | rest] = rest

                case next_token do
                  :addition ->
                    #IO.puts("\nHe llegado aqui (+C+)")
                    #[next_token | rest] = rest
                    rest_tree = parse_expression(rest,new_tree)
                    tree=elem(rest_tree, 0)
                    rest=elem(rest_tree, 1)

                    case tree do
                      {:error, error_message} ->
                        {{:error, error_message},rest}

                      _->
                        {%AST{node_name: :addition, left_node: new_tree, right_node: tree, value: "+"}, rest}
                    end

                  :negative ->
                    #IO.puts("\nHe llegado aqui (-C-)")
                    #[next_token | rest] = rest
                    rest_tree = parse_expression(rest,new_tree)
                    tree=elem(rest_tree, 0)
                    rest=elem(rest_tree, 1)

                    case tree do
                      {:error, error_message} ->
                        {{:error, error_message},rest}

                      _->
                        {%AST{node_name: :negative, left_node: new_tree, right_node: tree, value: "-"}, rest}
                    end
                  _->{new_tree, [next_token | rest]}
                end
            end
        end
      _->{left,[next_token | rest]}
    end
  end

  def parse_term([next_token | rest],_tree) do
    factor = parse_factor([next_token | rest])

    left=elem(factor, 0)
    rest=elem(factor, 1)

    #nuevo error detectado
    case rest do
      [] ->
        left
      _->
        [next_token|rest] = rest
        case next_token do
          :multiplication ->
            #IO.puts("\nHe llegado aqui (*)")
            #[next_token | rest] = rest
            next_term = parse_factor(rest)

            right = elem(next_term,0)
            rest = elem(next_term,1)

            case right do
              {:error, error_message} ->
                {{:error, error_message},rest}

              _->
                new_tree=%AST{node_name: :multiplication, left_node: left, right_node: right, value: "*"}

                #next2 =  List.first(rest)
                [next_token|rest] = rest

                case next_token do
                  :multiplication ->
                    #IO.puts("\nHe llegado aqui (C)")
                    #[next_token | rest] = rest
                    rest_tree = parse_expression(rest,new_tree)
                    tree=elem(rest_tree, 0)
                    rest=elem(rest_tree, 1)

                    case tree do
                      {:error, error_message} ->
                        {{:error, error_message},rest}

                      _->
                        {%AST{node_name: :multiplication, left_node: new_tree, right_node: tree, value: "*"}, rest}
                    end

                  :division ->
                    #IO.puts("\nHe llegado aqui (*C/)")
                    #[next_token | rest] = rest
                    rest_tree = parse_expression(rest,new_tree)
                    tree=elem(rest_tree, 0)
                    rest=elem(rest_tree, 1)

                    case tree do
                      {:error, error_message} ->
                        {{:error, error_message},rest}

                      _->
                        {%AST{node_name: :division, left_node: new_tree, right_node: tree, value: "/"}, rest}
                    end
                  _->{new_tree, [next_token|rest]}
                end
            end

          :division ->
            #IO.puts("\nHe llegado aqui (/)")
            #[next_token | rest] = rest
            next_term = parse_factor(rest)

            right = elem(next_term,0)
            rest = elem(next_term,1)

            case right do
              {:error, error_message} ->
                {{:error, error_message},rest}

              _->
                new_tree=%AST{node_name: :division, left_node: left, right_node: right, value: "/"}

                #next2 =  List.first(rest)
                [next_token|rest] =rest

                case next_token do
                  :multiplication ->
                    #IO.puts("\nHe llegado aqui (/C*)")
                    #[next_token | rest] = rest
                    rest_tree = parse_term(rest,new_tree)
                    tree=elem(rest_tree, 0)
                    rest=elem(rest_tree, 1)

                    case tree do
                      {:error, error_message} ->
                        {{:error, error_message},rest}

                      _->
                        {%AST{node_name: :multiplication, left_node: new_tree, right_node: tree, value: "*"}, rest}
                    end

                  :division ->
                    #IO.puts("\nHe llegado aqui (/C/)")
                    #[next_token | rest] = rest
                    rest_tree = parse_term(rest,new_tree)
                    tree=elem(rest_tree, 0)
                    rest=elem(rest_tree, 1)

                    case tree do
                      {:error, error_message} ->
                        {{:error, error_message},rest}

                      _->
                        {%AST{node_name: :division, left_node: new_tree, right_node: tree, value: "/"}, rest}
                    end
                  _->{new_tree, [next_token|rest]}
                end
            end
          _->{left,[next_token|rest]}
        end
    end
  end

  def parse_factor([next_token | rest]) do
    case next_token do
      :open_paren ->
        expression = parse_expression(rest,nil)
        tree=elem(expression,0)
        rest=elem(expression,1)
        [next_token | rest]=rest

        case next_token do
          :close_paren -> {tree, rest}
          _ -> {{:error, "Error: close parenthesis missing in expression"}, rest}
        end

        :negative -> expression = parse_factor(rest)
        case expression do
          {{:error, error_message}, rest} ->
            {{:error, error_message}, rest}

          {exp_node, rest} ->
            {%AST{node_name: :negative, left_node: exp_node, value: "-"}, rest}
        end

      :complement -> expression = parse_factor(rest)
        case expression do
          {{:error, error_message}, rest} ->
            {{:error, error_message}, rest}

          {exp_node, rest} ->
            {%AST{node_name: :complement, left_node: exp_node, value: "~"}, rest}
        end

      :logic -> expression = parse_factor(rest)
        case expression do
          {{:error, error_message}, rest} ->
            {{:error, error_message}, rest}
          {exp_node, rest} ->
            {%AST{node_name: :logic, left_node: exp_node, value: "!"}, rest}
        end



      {:constant, value} -> {%AST{node_name: :constant, value: value}, rest}

      _ -> {{:error, "Error: constant value missed"}, rest}
    end
  end
end
