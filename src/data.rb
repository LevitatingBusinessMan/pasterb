require 'active_record'
require 'securerandom'
require './src/log.rb'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ENV['DB'] || "pasterb.sqlite3")

ActiveRecord::Base.logger = $log

class Paste < ActiveRecord::Base
  has_many :revisions
  attribute :title, default: "New Paste"
  attribute :read_key, default: -> { SecureRandom.hex 16 }
  attribute :write_key, default: -> { SecureRandom.hex 16 }
  validates :read_key, uniqueness: true
  validates :write_key, uniqueness: true

  def view_link 
    "/view?=#{self.read_key}"
  end

  def edit_link 
    "/edit?=#{self.write_key}"
  end

  def content rev=nil
    if rev
      self.revisions.find_by!(revision_id: rev).content
    else
      self.revisions.order(revision_id: :desc).first&.content || ""
    end
  end

end

class PasteMigration < ActiveRecord::Migration[8.0]
  def change
    create_table(:pastes) do |t|
      t.column :title, :text
      t.column :read_key, :text, limit: 32
      t.column :write_key, :text, limit: 32
      t.column :syntax, :text

      t.timestamps
    end
  end
end

class Revision < ActiveRecord::Base
  belongs_to :paste
  after_initialize :init
  validates :content, presence: true
  validates :revision_id, presence: true
  validates :revision_id, uniqueness: { scope: :paste_id }

  def edit_link
    self.paste.edit_link + "&rev=#{self.revision_id}"
  end

  def view_link
    self.paste.view_link + "&rev=#{self.revision_id}"
  end

  private
  def init
    self.revision_id ||= self.paste.revisions.length + 1
    self.name ||= "Revision #{self.revision_id}"
  end

end

class RevisionMigration < ActiveRecord::Migration[8.0]
  def change
    create_table(:revisions) do |t|
      t.belongs_to :paste
      t.column :name, :text
      t.column :content, :text
      t.column :revision_id, :integer
      t.column :user_agent, :text
      t.column :ip, :text

      t.timestamps
    end
  end
end
