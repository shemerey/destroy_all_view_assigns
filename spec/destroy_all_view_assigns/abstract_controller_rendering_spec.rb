require 'spec_helper'

describe DestroyAllViewAssigns::AbstractControllerRendering do
  let(:assigns_hash) { {secret: true} }
  let(:klass) do
    Class.new do
      def controller_name
        'ctrl_name'
      end

      def action_name
        'act_name'
      end

      def view_assigns
        { secret: true }
      end
    end
  end

  it "should returns default view_assigns" do
    expect(klass.new.view_assigns).to eq(assigns_hash)
  end

  xit "should return empty hash if module included" do
    klass.send :include, described_class
    expect(klass.new.view_assigns).to eq(assigns_hash)
  end
end
