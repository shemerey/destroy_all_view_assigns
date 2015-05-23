module DestroyAllViewAssigns
  class DataPresenter
    attr_reader :data

    def initialize(data = CollectedData)
      @data = data
    end

    def find_controller_by_name(name)
      data.transaction do
        data.fetch(name) { raise Sinatra::NotFound }
      end
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
