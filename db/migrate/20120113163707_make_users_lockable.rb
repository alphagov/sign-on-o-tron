class MakeUsersLockable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :time
    end
  end
end
