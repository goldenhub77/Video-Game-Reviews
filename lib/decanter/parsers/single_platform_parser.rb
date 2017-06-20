class SinglePlatformParser < Decanter::Parser::ValueParser
  parser do |value, options|
    [Platform.find(value.to_i)]
  end
end
