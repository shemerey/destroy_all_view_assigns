require "destroy_all_view_assigns/version"

module DestroyAllViewAssigns
  # Your code goes here...
end

if defined? Rails
  require "destroy_all_view_assigns/abstract_controller_rendering"
  require "destroy_all_view_assigns/railtie"
end
