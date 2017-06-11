class GenreParser < Decanter::Parser::ValueParser
  parser do |value, options|
    Genre.find(value.to_i)
  end
end
