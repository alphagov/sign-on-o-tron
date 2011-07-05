class AddUidAndVersionToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string   :uid, :null => false
      t.integer  :version, :null => false, :default => 1
    end
  end

  def self.down
    raise IrreversibleMigration
  end
end
