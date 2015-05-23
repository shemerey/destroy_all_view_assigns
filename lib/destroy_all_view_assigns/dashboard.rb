require 'sinatra/base'
require_relative "abstract_controller_rendering"

module DestroyAllViewAssigns
  class Dashboard < Sinatra::Base

    helpers do
      def active_tab?(url)
        url == request.path_info
      end

      def controller_url(controller)
        # "<a href=''>#{controller[:name]}</a>"
        "<a href='#{url("/controller/" + underscore(controller[:klass]))}'>#{controller[:klass]}</a>"
      end

      def underscore(word)
        word = word.dup
        word.gsub!(/::/, '@')
        word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        word.tr!("-", "_")
        word.downcase!
        word
      end

      def camelize(term)
        string = term.to_s
        string.split('@').map do |str|
          str = str.sub(/^[a-z\d]*/) {  $&.capitalize }
          str.gsub!(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{$2.capitalize}" }
          str.gsub!(/@/, '::')
          str
        end.join('::')
      end
    end

    set :public_folder, File.dirname(__FILE__) + '/static'

    get "/" do
      erb :index
    end

    get "/controller/:name" do
      controller = DestroyAllViewAssigns::DataPresenter.new.find_controller_by_name(camelize(params[:name]))
      erb :controller, locals: {controller: controller}
    end

    get "/controllers" do
      erb :controllers
    end

    run! if __FILE__ == $PROGRAM_NAME
  end
end
