module DestroyAllViewAssigns
  module AbstractControllerRendering
    def self.included(klass)
      klass.class_eval do
        #clean up
        remove_method :view_assigns
        # replace
        define_method :view_assigns do
          {}
        end
      end
    end
  end
end
