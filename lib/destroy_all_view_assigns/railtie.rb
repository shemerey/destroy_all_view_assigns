module DestroyAllViewAssigns
  class Railtie < ::Rails::Railtie
    initializer 'destroy_all_view_assigns.initialize' do
      ActiveSupport.on_load(:action_controller) do
        ::AbstractController::Rendering.send :include, DestroyAllViewAssigns::AbstractControllerRendering
      end
    end
  end
end
