require 'sqlite3'
$db = SQLite3::Database.new ENV["DB"]
