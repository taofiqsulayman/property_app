# config/swagger_helper.rb
require 'swagger/blocks'

Swagger::Blocks.configure do |config|
  config.json_editor = false
end

# Load all Swagger files in the API directory
Dir[Rails.root.join('app', 'controllers', '**', '*_controller.rb')].each do |file|
  require file
end

Swagger::Blocks.build_root_json do
  swagger '2.0'
  info do
    title 'Lekki Properties API Documentation'
    version '2.0.0'
    description 'This document defines user requirements for the API Service for the Property Onboarding / Offboarding process of the Lekki project.'
  end

  # Include paths from all controllers
  Dir[Rails.root.join('app', 'controllers', '**', '*_controller.rb')].each do |file|
    controller_name = File.basename(file, '_controller.rb')
    instance_eval(File.read(file), file)
  end
end
