
## Známe!
def print_with_type(value)
  puts "#{value} is #{typeof(value)}"
end

print_with_type("Hello World")
print_with_type(1)
print_with_type([1, "Hello", :world])
print_with_type({1 => "Hello", "World" => 2})

# Bloky, Iterátory
[1,2,3].map do |value|
  value + 1
end

# Třídy, moduly

module My
  class Worker
    property job_id

    def initialize
      job_id = rand(10000..1000000)
    end
  end
end

worker = My::Worker.new
# Nové!

# 'hello world' # ERR

print_with_type ["hello", "world"].map(&.capitalize)
print_with_type ["hello", "world"].map(&.capitalize.split('l'))

## Nové!
# Typy
print_with_type({1, "Hello", :word}) # Tuple
print_with_type({hello: "Word", word: "Hello"}) # NamedTuple

# Typecheck
def print_only_string(value : String)
  puts value
end

print_only_string("Hello Word")
print_only_string(:hello) # ERR

def print_only_correct_hash(value : Hash(String, String))
  puts value
end

print_only_correct_hash({"a" => "b"})

def splat_array(key, *values)
  puts values
end

# splat_array('key', *[1,2,3]) # ERR cant splat Array
splat_array("key", *{1,2,3})


# Multi funkce
def neco(value : String)
  puts "text je #{value}"
end

def neco(value : Number)
  puts "cislo je #{value}"
end

neco("hello world")
neco(1)

# Generování kódu pomocí maker
macro def_my_method(name, content)
  def {{name}}
    puts {{content}}
  end
end

def_my_method foo, "foo"
def_my_method bar, "bar"

foo
bar

# class inherited, module included
# http://crystal-lang.org/docs/syntax_and_semantics/macros/hooks.html

class Anything
  macro method_missing(name, args, block)
    print "Got ", {{name.id.stringify}}, " with ", {{args.size}}, " arguments", '\n'
  end
end

anything = Anything.new

anything.should_boom? "a", "b"
