require 'spec_helper'

describe DestroyAllViewAssigns::AbstractControllerRendering do
  let(:klass) do
    Class.new do
      def view_assigns
        { secret: true }
      end
    end
  end

  it "should returns default view_assigns" do
    expect(klass.new.view_assigns).to eq( {secret: true} )
  end

  it "should return empty hash if module included" do
    klass.send :include, described_class
    expect(klass.new.view_assigns).to eq({})
  end
end
