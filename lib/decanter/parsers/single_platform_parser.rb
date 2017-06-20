class SinglePlatformParser < Decanter::Parser::ValueParser
  parser do |value, options|
    Platform.where('id = ?', value)
  end
end
