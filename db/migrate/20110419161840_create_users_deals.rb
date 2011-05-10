class CreateUsersDeals < ActiveRecord::Migration
  def self.up
    create_table :users_deals do |t|
      t.integer :user_id
      t.integer :deal_id
      t.string :promocode
      t.timestamp :used_at

      t.timestamps
    end
  end

  def self.down
    drop_table :users_deals
  end
end
