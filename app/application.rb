# require 'pry'
# class Application
#
#   @@items = []
#
#   def call(env)
#     resp = Rack::Response.new
#     req = Rack::Request.new(env)
#     # binding.pry
#     if req.path.match("/items/")
#       item_name = req.path.split("/items/").last
#       matching_items = @@items.delete_if{|item| item.name != item_name}
#       if matching_items != []
#         resp.write "#{matching_items[0].price}"
#         resp.status = 200
#       else
#         resp.write "Item not found"
#         resp.status = 400
#       end
#
#     else
#       resp.write "Route not found"
#       resp.status = 404
#     end
#     resp.finish
#   end
#
# end

class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match("/items/")
      item_name = req.path.split("/items/").last

      if !!@@items.find{|item| item.name == item_name}
        @@items.each do |item|
          if item.name == item_name
          resp.write item.price
          resp.status = 200
          end
        end
      else
        resp.write "Item not found"
        resp.status = 400
      end

    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end
