class CreateClouds < ActiveRecord::Migration
  def self.up
    create_table :clouds do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :clouds
  end
end
