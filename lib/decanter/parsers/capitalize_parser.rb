class CapitalizeParser < Decanter::Parser::ValueParser
  parser do |value, options|
    stringArr = value.split(" ")
    stringArr.map { |word| word.humanize }.join(" ")
  end
end
