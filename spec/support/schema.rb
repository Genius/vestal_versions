DATABASE_CONFIG = {
  :adapter => 'postgresql',
  :host => ENV.fetch('PGHOST', 'localhost'),
  :port => ENV.fetch('PGPORT', 5432),
  :username => ENV.fetch('PGUSER', 'postgres'),
  :password => ENV.fetch('PGPASSWORD', 'postgres'),
  :database => ENV.fetch('PGDATABASE', 'vestal_versions_test')
}

begin
  ActiveRecord::Base.establish_connection(DATABASE_CONFIG)
  ActiveRecord::Base.connection
rescue ActiveRecord::NoDatabaseError
  ActiveRecord::Base.establish_connection(DATABASE_CONFIG.merge(:database => 'postgres'))
  ActiveRecord::Base.connection.create_database(DATABASE_CONFIG[:database])
  ActiveRecord::Base.establish_connection(DATABASE_CONFIG)
end

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string :first_name
      t.string :last_name
      t.timestamps
    end

    create_table :versions, :force => true do |t|
      t.belongs_to :versioned, :polymorphic => true
      t.belongs_to :user, :polymorphic => true
      t.string :user_name
      t.text :modifications
      t.integer :number
      t.integer :reverted_from
      t.string :tag
      t.timestamps
    end
  end
end
