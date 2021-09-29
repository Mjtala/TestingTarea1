# frozen_string_literal: true

require "rubocop/rake_task"

task default: %w[test]
task :test do
<<<<<<< HEAD
  # ruby 'test/clock_display_test.rb'
=======
  ruby "test/mine_unit_test.rb"
>>>>>>> 0ce3635 (setup inicial para tests)
  # Acá ponemos todos los tests que tengamos
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ["lib/**/*.rb", "test/**/*.rb"]
  task.fail_on_error = false
end
