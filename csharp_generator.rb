
def csGenerateComment content
  <<-END
    // #{comment}
  END
end

def csGenerateVariable type, name, value
  <<-END
    #{type} #{name} = #{value};
  END
end

def csGenerateIf condition
  <<-END
    if (#{condition}) {
  END
end

def csGenerateElseIf condition
  <<-END
  } else if (#{condition}) {
  END
end

def csGenerateElse
  <<-END
  } else {
  END
end

def csGenerateEnd
  <<-END
  }
  END
end

def csGenerateInferredVariable name, value
  <<-END
  var #{name} = #{value};
  END
end

def csGenerateFunctionCall name, arguments
  <<-END
  name(#{arguments});
  END
end

def csGenerateFunctionDeclaration name, arguments
  <<-END
  
  END
end

def csGenerateWhileLoop condition
  <<-END
  
  END
end

def csGenerateForLoop initialization, condition, update
  <<-END
  
  END
end

def csGenerateForeachLoop iterator, array
  <<-END
  
  END
end

def csGenerateImport package
  <<-END
  
  END
end

def csGenerateImportFrom package, thing
  <<-END
  
  END
end

def csGenerateMethod variable, method
  <<-END
    
  END
end

def csGenerateAttempt
  <<-END
    
  END
end

def csGenerateCatchException exception
  <<-END
  
  END
end

def csGenerateNamedException exception, name
  <<-END
  
  END
end

