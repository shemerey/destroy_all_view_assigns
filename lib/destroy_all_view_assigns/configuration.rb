module DestroyAllViewAssigns
  module Configuration
    # Start a DestroyAllViewAssigns configuration block in an initializer.
    #
    # example: Provide a default currency for the application
    #   DestroyAllViewAssigns.configure do |config|
    #     config.default_currency = :eur
    #   end
    def configure
      yield self
    end

    def whitelisted=(list_of_controllers)

    end

    def blacklisted=(list_of_controllers)

    end
  end
end

