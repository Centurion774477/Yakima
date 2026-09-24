
def phpGenerateComment comment
  <<~END
    # #{comment}
  END
end

def phpGenerateVariable type, name, value
  # type isn't used but it's needed in the C# version and the parser doesn't know which one is going to be called
  <<~END
  $#{name} = #{value};
  END
end

def phpGenerateIf condition
  <<~END
  if (#{condition}) {
  END
end

def phpGenerateElseIf condition
  <<~END
  } elseif (#{condition}) {
  END
end

def phpGenerateElse
  <<~END
} else {
  END
end

def phpGenerateEnd
  <<~END
}
  END
end

def phpGenerateInferredVariable name, value
  <<~END
  $#{name} = #{value};
  END
end

def phpGenerateFunctionCall name, arguments
  # check if its a Yakima function like write_output() or read_stdin()
  return "echo #{arguments}"   if name == "write_output"
  return "readline()"          if name == "read_stdin"

  <<~END
  #{name}(#{arguments})
  END
end

def phpGenerateFunctionDeclaration name, arguments, return_type
  <<~END
  function #{name} (#{arguments}): #{return_type} {
  END
end

def phpGenerateWhileLoop condition
  # if the user is checking for a boolean value or a variable
  if condition =~ /^\w+$/
    return <<~END
    while ($#{condition}) {
    END
  end
  <<~END
  while (#{condition}) {
  END
end

def phpGenerateForLoop amount
  <<~END
  for ($i = 0; $i < #{amount}; $i++) {
  END
end

def phpGenerateForeachLoop iterator, array
  <<~END
  foreach ($#{array} as $#{iterator}) {
  END
end

def phpGenerateImport package
  return "// PHP doesn't have imports! -- Yakima" # doesn't exist in PHP
end

def phpGenerateImportFrom package, thing
  return "// PHP doesn't have imports! -- Yakima" # doesn't exist in PHP either
end

def transpileMethodIntoPhp method
  return case method
  when "length"   then "count"
  when "pushTAIL" then "array_push"
  when "pushHEAD" then "array_unshift"
  when "find"     then "array_search"
  when "head"     then "array_last"
  when "tail"     then "array_first"
  else method # assume that the method is some other PHP method instead of throwing an error
  end
end

def phpGenerateMethod variable, method, arguments
  # array[i] will not reach this function, so I need to figure that out.
  method = transpileMethodIntoPhp method
  if arguments == "" || arguments == " " # this check may not work; it's checking if this method is called with arguments
    return "#{method}(#{variable});"
  else
    return "#{method}(#{variable}, #{arguments});"
  end
end

def phpGenerateAttempt
  <<~END
  try {
  END
end

def phpGenerateCatchException exception
  <<~END
} catch (#{exception}) {
  END
end

def phpGenerateNamedException exception, name
  <<~END
} catch (#{exception} #{name}) {
  END
end

def phpGenerateEcho message
  <<~END
    echo #{message};
  END
end

def phpGenerateFileWrite data, file
  <<~END
    file_put_contents(#{file}, #{data});
  END
end

def phpGenerateFileRead variable_name, file
  <<~END
    $#{variable_name} = file_get_contents(#{file});
  END
end

def phpGenerateClassInstance variable, class_name
  class_name = class_name.gsub(/\w+/) { |word| word.capitalize }
  <<~END
    $#{variable} = new #{class_name}();
  END
end
