module DestroyAllViewAssigns
  module Configuration
    extend self

    Error = Class.new(StandardError)

    # Start a DestroyAllViewAssigns configuration block in an initializer.
    #
    # example: Provide a default currency for the application
    #   DestroyAllViewAssigns.configure do |config|
    #     config.default_currency = :eur
    #   end
    def configure
      yield self
      prevent_black_and_white_list_at_the_same_time!
    end

    # apply default configuration
    def self.extended(base)
      base.configure do |config|
        config.black_list = []
        config.white_list = []
      end
    end

    def white_list=(list_of_controllers)
      @_white_list = list_of_controllers.to_set
    end

    def black_list=(list_of_controllers)
      @_black_list = list_of_controllers.to_set
    end

    def white_list
      @_white_list
    end

    def black_list
      @_black_list
    end

    private

    def prevent_black_and_white_list_at_the_same_time!
      raise Error if [black_list, white_list].all? { |list| not list.empty? }
    end
  end
end

