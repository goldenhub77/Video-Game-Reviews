class StringToDateParser < Decanter::Parser::ValueParser
  parser do |value, options|
    Date.parse(value)
  end
end
