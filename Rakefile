# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[test]
task :test do
  # ruby 'test/clock_display_test.rb'
  # Acá ponemos todos los tests que tengamos
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end
