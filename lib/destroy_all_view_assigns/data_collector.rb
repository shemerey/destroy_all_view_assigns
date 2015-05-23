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

