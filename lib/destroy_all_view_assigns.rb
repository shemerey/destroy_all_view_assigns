require "destroy_all_view_assigns/version"
require "destroy_all_view_assigns/configuration"
require "destroy_all_view_assigns/abstract_controller_rendering"
require "destroy_all_view_assigns/controller_object"

module DestroyAllViewAssigns
  extend Configuration
end

if defined? Rails
  require "destroy_all_view_assigns/railtie"
  require "destroy_all_view_assigns/dashboard"
end
