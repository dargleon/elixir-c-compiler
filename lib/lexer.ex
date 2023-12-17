defmodule Lexer do
  @moduledoc """
  Documentation for the Lexer
  The Lexer receive a linked list of words provided by the sanitizer
  to return a list of tokens according to the words it identifies
  """

  #Identify and flatten the list of words according to the list of defined tokens
  def scan_words(words) do
    Enum.flat_map(words, &lex_raw_tokens/1)
  end

  #It is responsible for determining the value of the constant that the program returnsby assigning token :constant and the numerical value.
  #For the regular expression /^\d+/ Matches the beginning of the entry one or more digits. Replace the string constant with its numeric representation.
  def get_constant(program) do
    #Provides regular expressions ~r/  /.
    case Regex.run(~r/^\d+/, program) do
      #trim_leading returns a string with all value characters removed
      [value] ->
        {{:constant, String.to_integer(value)}, String.trim_leading(program,value)}
      program ->
        {:error, "Token not valid: #{program}"}
    end
  end



  #Compare the symbols found with the tokens for each found token add its atom to the output list
  def lex_raw_tokens(program) when program != "" do
    {token, rest} =
      case program do
        "{" <> rest ->
          {:open_brace, rest}

        "}" <> rest ->
          {:close_brace, rest}

        "(" <> rest ->
          {:open_paren, rest}

        ")" <> rest ->
          {:close_paren, rest}

        ";" <> rest ->
          {:semicolon, rest}

        "-" <> rest ->
          {:negative, rest}

        "~" <> rest ->
          {:complement, rest}

        "!=" <> rest ->
          {:not_equal, rest}

        "!" <> rest ->
          {:logic, rest}

        "+" <> rest ->
          {:addition, rest}

        "*" <> rest ->
          {:multiplication, rest}

        "/" <> rest ->
          {:division, rest}

        "&&" <> rest ->
          {:and, rest}

        "||" <> rest ->
          {:or, rest}

        "==" <> rest ->
          {:equal, rest}

        "<=" <> rest ->
          {:less_eq_than, rest}

        ">=" <> rest ->
          {:greater_eq_than, rest}

        "<" <> rest ->
          {:less_than, rest}

        ">" <> rest ->
          {:greater_than, rest}

        "int" <> rest ->
          {:int_keyword, rest}

        "return" <> rest ->
          {:return_keyword, rest}

        "main" <> rest ->
          {:main_keyword, rest}

        rest ->
          get_constant(rest)
      end

    if token != :error do
      remaining_tokens = lex_raw_tokens(rest)
      #Add token to the collection
      [token | remaining_tokens]
    else
      [:error]
    end
  end

  #Output list that will have all the tokens in the order they were found.
  def lex_raw_tokens(_program) do
    []
  end
end
