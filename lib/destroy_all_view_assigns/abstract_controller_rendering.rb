module DestroyAllViewAssigns
  module AbstractControllerRendering
    def self.included(klass)
      klass.class_eval do
        alias_method :_old_view_assigns, :view_assigns

        # replace
        define_method :view_assigns do
          hash = _old_view_assigns

          DataCollector.new(self).tap do |obj|
            hash.each do |variable_name, _|
              obj.add(variable_name)
            end
          end.collect!

          hash
        end

      end
    end
  end
end
