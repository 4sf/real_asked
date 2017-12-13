def hello
  puts "hello"
  yield
  puts "welcome"
end

hello { puts "john" }
