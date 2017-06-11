class PlatformArrayParser < Decanter::Parser::ValueParser
  parser do |value, options|
    value.map { |platform| Platform.find(platform.to_i) }
  end
end
