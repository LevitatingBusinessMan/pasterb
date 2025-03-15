namespace :db do
  task :shell do
    exec "irb -r ./src/data.rb"
  end
  task :up do
    require './src/data.rb'
    PasteMigration.migrate :up
    RevisionMigration.migrate :up
  end
  task :down do
    require './src/data.rb'
    PasteMigration.migrate :down
    RevisionMigration.migrate :down
  end
end

