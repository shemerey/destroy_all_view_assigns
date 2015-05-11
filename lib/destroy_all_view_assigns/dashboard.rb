require 'sinatra/base'
require_relative "abstract_controller_rendering"

module DestroyAllViewAssigns
  class Dashboard < Sinatra::Base

    helpers do
      def active_tab?(url)
        url == request.path_info
      end
    end

    set :public_folder, File.dirname(__FILE__) + '/static'

    get "/" do
      erb :index
    end

    get "/controllers" do
      erb :controllers
    end

    run! if __FILE__ == $PROGRAM_NAME
  end
end
