
def csGenerateComment content
  <<~END
    // #{comment}
  END
end

def csGenerateVariable type, name, value
  <<~END
    #{type} #{name} = #{value};
  END
end

def csGenerateIf condition
  <<~END
    if (#{condition}) {
  END
end

def csGenerateElseIf condition
  <<~END
  } else if (#{condition}) {
  END
end

def csGenerateElse
  <<~END
  } else {
  END
end

def csGenerateEnd
  <<~END
  }
  END
end

def csGenerateInferredVariable name, value
  <<~END
  var #{name} = #{value};
  END
end

def csGenerateFunctionCall name, arguments
  return "Console.WriteLine(#{arguments});" if name == "write_output"
  return "Console.ReadLine();" if name == "read_stdin"

  <<~END
  name(#{arguments});
  END
end

def csGenerateFunctionDeclaration name, arguments, return_type
  <<~END
  public #{return_type} #{name}(#{arguments}) {
  END
end

def csGenerateWhileLoop condition
  <<~END
  while (#{condition}) {
  END
end

def csGenerateForLoop amount

  <<~END
  for (var i = 0; i < #{amount}; i++) {
  END
end

def csGenerateForeachLoop iterator, array
  <<~END
  foreach (var #{iterator} in #{array}) {
  END
end

def csGenerateImport package
  <<~END
  using #{package};
  END
end

def csGenerateImportFrom package, thing
  # I don't think C# has an import x from y feature
  <<~END
  using #{package};
  END
end

def transpileMethodIntoCsharp method

  # handle all the methods that aren't supported in the C# version

  if method in %w|pushTAIL pushHEAD|
    puts "Sorry, but when transpiling Yakima into C#, the method #{method} is not supported."
    exit
  end

  return case method
  when "length" then "Length"
  when "find"   then "Find"
  else method
  end
end

def csGenerateMethod variable, method
  if method == "head" then return "#{variable}[0]" end
  if method == "tail" then return "#{variable}[#{variable}.Length - 1]" end

  transpiledMethod = transpileMethodIntoCsharp method

  return <<~END
    #{variable}.#{transpiledMethod};
  END
end

def csGenerateAttempt
  <<~END
    try {
  END
end

def csGenerateCatchException exception
  # this might throw a warning if you pull down throwawayException but don't use it.
  # I'm not sure if C# lets you capture specific exceptions while not pulling down a variable though.
  <<~END
  } (#{exception} throwawayException) {
  END
end

def csGenerateNamedException exception, name
  <<~END
  } (#{exception} #{name}) {
  END
end

def csGenerateEcho message
  <<~END
    Console.WriteLine();
  END
end