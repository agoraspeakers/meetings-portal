# frozen_string_literal: true

# Application helper
module ApplicationHelper
  # renders component from 'frontend/components' directory
  def component(component_name, locals = {}, &block)
    name = component_name.split('_').first
    render("components/#{name}/#{component_name}", locals, &block)
  end
end
