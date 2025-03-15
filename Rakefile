namespace :db do
  task :up do
    require './src/data.rb'
    PasteMigration.migrate :up
  end
  task :down do
    require './src/data.rb'
    PasteMigration.migrate :down
  end
end

