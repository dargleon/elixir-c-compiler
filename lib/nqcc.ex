defmodule Nqcc do
  @moduledoc """
  Documentation for Nqcc.
  The Nqcc code is the entry point to the compiler of C programs,
  it has the main function that is responsible for receiving the
  file to be compiled as well as some of the flags defined by the
  @commands attribute, execute this code with the –help option to
  be able to view them. It allows to process a code for each one of
  the compilation steps until obtaining the objective code, and
  visualize the steps according to the available options.
  """
  @commands %{
    "help" => "Prints this help",
    "L" => "Compile and display scanner output",
    "P" => "Compile and display parser output",
    "S" => "Compile and display generator output",
    "A" => "Compile and display scanner, parser and code generator output"
  }

  @doc"""
  This is the main function, it receives as arguments the path of the file to compile and the available flags.
  It can receive the path of the file to compile and/or the flags indicated by the @commmands attribute,
  they can be displayed with --help.
  """
  def main(args) do
    args
    |> parse_args
    |> process_args
  end


  #Parse the arguments received by the main function, using parse\2 from OptionParser
  def parse_args(args) do
    OptionParser.parse(args, strict: [help: :boolean, L: :boolean, P: :boolean, S: :boolean, A: :boolean])
  end

  #Shows the content of the @commands attribute, needs switch --help
  defp process_args({[help: true], _, _}) do
    print_help_message()
  end

  #Compile and display scanner output, need switch --L
  defp process_args({[L: true], [file_name], _}) do
    compile_file_L(file_name)
  end

  #Compile and display parser output, needs switch -P
  defp process_args({[P: true], [file_name], _}) do
    compile_file_P(file_name)
  end


  #Compile and display generator output, needs switch --S
  defp process_args({[S: true], [file_name], _}) do
    compile_file_S(file_name)
  end

  #Compile and display scanner, parser and code generator output, needs switch A
  defp process_args({[A: true], [file_name], _}) do
    compile_file_A(file_name)
  end

  #Compile and don't show the outputs of internal processes
  defp process_args({[], [file_name], _}) do
   compile_file(file_name)
  end

  #Function that passes a c program through each of the compilation steps, while displaying the Scanner outputs.
  defp compile_file_L(file_path) do

    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    file =     File.read!(file_path)
    s_code =   Sanitizer.sanitize_source(file)
    l_tokens = Lexer.scan_words(s_code)
    IO.puts("\nLexer output:")
    IO.inspect(l_tokens)
    ast =      Parser.parse_program(l_tokens)

    case ast do
      {:error, error_message} -> IO.puts(error_message)

      _->
        a_code =   CodeGenerator.generate_code(ast,:noprint)
        Linker.generate_binary(a_code,assembly_path)
    end
  end

  #Function that passes a c program through each of the compilation steps, while displaying the Parser output.
  defp compile_file_P(file_path) do

    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    file =     File.read!(file_path)
    s_code =   Sanitizer.sanitize_source(file)
    l_tokens = Lexer.scan_words(s_code)
    ast =      Parser.parse_program(l_tokens)

    case ast do
      {:error, error_message} -> IO.puts(error_message)

      _->
        IO.puts("\nParser output:")
        IO.inspect(ast)
        a_code =   CodeGenerator.generate_code(ast,:noprint)
        Linker.generate_binary(a_code,assembly_path)
    end
  end


  #Function that passes a c program through each of the compilation steps, while displaying the generated assembly code.
  defp compile_file_S(file_path) do

    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    file =     File.read!(file_path)
    s_code =   Sanitizer.sanitize_source(file)
    l_tokens = Lexer.scan_words(s_code)
    ast =      Parser.parse_program(l_tokens)

    case ast do
      {:error, error_message} -> IO.puts(error_message)

      _->
        a_code =   CodeGenerator.generate_code(ast,:print)
        Linker.generate_binary(a_code,assembly_path)
    end
  end

  #Compile and display scanner, parser and code generator outputs.
  defp compile_file_A(file_path) do

    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    file =     File.read!(file_path)
    s_code =   Sanitizer.sanitize_source(file)
    IO.puts("\nSanitizer output:")
    IO.puts(s_code)
    l_tokens = Lexer.scan_words(s_code)
    IO.puts("\nLexer output:")
    IO.inspect(l_tokens)
    ast =      Parser.parse_program(l_tokens)

    case ast do
      {:error, error_message} -> IO.puts(error_message)

      _->
        IO.puts("\Parser output:")
        IO.inspect(ast)
        a_code =   CodeGenerator.generate_code(ast,:print)
        Linker.generate_binary(a_code,assembly_path)
    end

  end


  #Compile and don't show outputs
  defp compile_file(file_path) do
    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    file =     File.read!(file_path)
    s_code =   Sanitizer.sanitize_source(file)
    l_tokens = Lexer.scan_words(s_code)
    ast =      Parser.parse_program(l_tokens)

    case ast do
      {:error, error_message} -> IO.puts(error_message)

      _->
        a_code =   CodeGenerator.generate_code(ast,:noprint)
        Linker.generate_binary(a_code,assembly_path)
    end

  end


  #Shows the options supported by the compiler, contained in the @commands attribute.
  defp print_help_message do
    IO.puts("\nnqcc --help file_name \n")

    IO.puts("\nThe compiler supports following options:\n")

    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end

end
