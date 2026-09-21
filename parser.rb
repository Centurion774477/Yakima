
require_relative "csharp_generator"
require_relative "php_generator"
require_relative "lexer"

class Parser
  def initialize
    @recognized_types  = %w|uint int boolean float string char obj any|
  end
  
  # this will need to be refactored to support nesting

  def parse token, output_language, line_number
    # remember to turn =/= into !=
    # PHP should also be !== instead for strict comparison

    # puts "DEBUG:"
    # pp token
    # puts token[:type]

    snippet = case token[:type]
    when :comment
      return send("#{output_language}GenerateComment", token[:comment])
    when :variable_creation
      unless @recognized_types.include?(token[:var_type])
        puts "Invalid type assigned to #{token[:name]}: #{token[:var_type]} on line ~#{line_number}" 
        exit
      end

      return send("#{output_language}GenerateVariable", token[:var_type], token[:name], token[:value])

    when :if_condition
      return send("#{output_language}GenerateIf", token[:condition])

    when :alternative_condition
      return send("#{output_language}GenerateElseIf", token[:condition])

    when :otherwise_condition
      return send("#{output_language}GenerateElse")

    when :end
      return send("#{output_language}GenerateEnd")

    when :inferred_variable_creation
      return send("#{output_language}GenerateInferredVariable", token[:name], token[:value])

    when :function_call
      return send("#{output_language}GenerateFunctionCall", token[:function_name], token[:arguments])

    when :function_declaration
      return send("#{output_language}GenerateFunctionDeclaration", token [:function_name], token[:arguments], token[:return_type])

    when :while_loop
      return send("#{output_language}GenerateWhileLoop", token[:condition])

    when :for_loop
      return send("#{output_language}GenerateForLoop", token[:initialization], token[:condition], token[:update])

    when :foreach_loop
      return send("#{output_language}GenerateForeachLoop", token[:iterator], token[:array])

    when :import
      return send("#{output_language}GenerateImport", token[:package])

    when :import_as
      return send("#{output_language}GenerateImportFrom", token[:package], token[:thing])

    when :method
      return send("#{output_language}GenerateMethod", token[:variable], token[:method], token[:arguments])

    when :open_attempt_block      
      return send("#{output_language}GenerateAttempt")

    when :unnamed_when_arm
      return send("#{output_language}GenerateCatchException", token[:exception])

    when :named_when_arm
      return send("#{output_language}GenerateNamedException", token[:exception], token[:name])

    when :blank_line
      return "\n"
    else
      puts "Unrecognized token on line #{line_number}: #{token}"
      exit
    end
    
    return snippet
  end
end