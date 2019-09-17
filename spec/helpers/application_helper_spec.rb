# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#component' do
    let(:component_name) { 'component_name' }
    let(:name) { component_name.split('_').first }
    let(:locals) { { test: 'test' } }
    let(:block_of_code) { def method; end }

    it 'renders a component from frontend directory' do
      allow(helper).to receive(:render)
      helper.component(component_name, locals, &block_of_code)
      expect(helper).to have_received(:render).with("components/#{name}/#{component_name}",
                                                    locals,
                                                    &block_of_code)
    end
  end
end
