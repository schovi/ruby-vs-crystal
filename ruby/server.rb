require "sinatra/base"
require 'json'

def fib(n)
  if n == 0 || n == 1
    return n
  end

  fib(n-1) + fib(n-2)
end

class App < Sinatra::Base
  set :logging, false
  set :bind, '0.0.0.0'

  get '/' do
    "Hello World!"
  end

  get "/fibonacci" do
    content_type :json

    params[:count].to_i.times.map do |num|
      fib(num)
    end.to_json
  end
end

if __FILE__ == $0
  App.run!
end
