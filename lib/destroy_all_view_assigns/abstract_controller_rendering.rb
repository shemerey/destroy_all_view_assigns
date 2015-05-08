require 'pstore'

module DestroyAllViewAssigns
  CollectedData = PStore.new("assigns.pstore")
end

module DestroyAllViewAssigns
  class DataPresenter
    attr_reader :data

    def initialize(data = CollectedData)
      @data = data
    end

    def controllers
      data.transaction do
        data.roots.map do |controller|
          data[controller]
        end.sort_by { |c| -c[:vars].count }
      end
    end
  end
end

module DestroyAllViewAssigns
  class DataCollector
    attr_reader :controller

    def initialize(controller)
      @controller = controller
    end

    def add(variable_name)
      action_data[:vars] << variable_name
      controller_data[:vars] << variable_name
    end

    def collect!
      controller_data[:actions][action_name] = action_data

      CollectedData.transaction  do
        CollectedData[klass] = controller_data
      end
    end

    private

    def get_controller_data
      CollectedData.transaction  do
        CollectedData[klass]
      end
    end

    def default_controller_data
      {
        controller_name: controller_name,
        klass: klass,
        vars: Set.new,
        actions: {}
      }
    end

    def controller_data
      @controller_data ||= (get_controller_data || default_controller_data)
    end

    def get_action_data
      controller_data[:actions][action_name]
    end

    def default_action_data
      {
        name: action_name,
        vars: Set.new
      }
    end

    def action_data
      @action_data ||= (get_action_data || default_action_data)
    end

    def klass
      controller.class.to_s
    end

    def controller_name
      controller.controller_name
    end

    def action_name
      controller.action_name
    end
  end
end


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
