class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.string :name
      t.timestamp :start
      t.timestamp :finish
      t.decimal :price
      t.string :description
      t.integer :partner_id
      t.timestamp :valid_from
      t.timestamp :valid_to
      t.boolean :featured

      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
