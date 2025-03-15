require 'active_record'
require 'logger'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ENV['DB'])

ActiveRecord::Base.logger = Logger.new(STDERR)

class Paste < ActiveRecord::Base
  has_many :revisions
end

class PasteMigration < ActiveRecord::Migration[8.0]
  def change
    create_table(:pastes, if_not_exists: true) do |t|
      t.column :title, :text
      t.column :read_key, :text
      t.column :write_key, :text
    end
  end
end
