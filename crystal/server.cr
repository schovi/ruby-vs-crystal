# Load dependencies
require "kemal"
require "json"
require "redis"

# Disable logs
# Kemal.config.logging = false

# Initialize redisxx
redis = Redis.new

# Route GET /
get "/" do
  "Hello World!"
end

# Route POST /json_data
post "/json_data" do |env|
  data = env.params.json

  redis.del("data")

  data.each do |key, value|
    redis.hset("data", key, value)
  end

  "ok"
end

get "/data" do
  keys = redis.hkeys("data")

  template_title = "Data from hset"

  template_data = keys.map do |key|
    redis.hget("data", key)
  end

  render "./template.ecr"
end

# Websockets
ws "/socket" do |socket|
  socket.send "Hello from Kemal!"
end

# Start server
Kemal.run
