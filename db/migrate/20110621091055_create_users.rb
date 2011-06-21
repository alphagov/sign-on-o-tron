class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :name, :null => false

      # service IDs
      t.string  :twitter
      t.string  :github
      t.boolean :beard

      # devise
      t.database_authenticatable
      t.recoverable
      t.rememberable
      t.trackable

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end