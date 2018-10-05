module MyModule
  def my_function
    puts 'MyModule.my_function running!'
  end
end

original_host = Object.new
original_host.extend MyModule
original_host.my_function

module MyMonkeyPatch
  def my_function
    puts 'MyMonkeyPatch.my_function running!'
    puts 'lets call the parent implemenation'
    super
    puts 'ok, now Im done. Bye!'
  end
end

puts ''
puts 'Lets hack the definition of MyModule, by prepending MyMonkeyPatch'
MyModule.prepend MyMonkeyPatch
puts 'Now ill call my_function on a new host. Hope I get the modified implementation!'
puts ''

new_host = Object.new
new_host.extend MyModule
new_host.my_function

# note that original_host.my_function still gets the original implementation,
# i.e. the implementation of MyModule.my_function.
# I can't quite explain it, but there's obviously ancestry definition isn't subject
# to redefinition ...
