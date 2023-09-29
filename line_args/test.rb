require 'lineargs'

name = ARGL.parse("--name","John Do")
isGirl = ARGL.parse("-girl",false)

puts "Hi #{name}, you are #{isGirl ? "girl" : "boy"}"
