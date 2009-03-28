class CreateModels < ActiveRecord::Migration
  def self.up

    create_table :clouds do |t|
      t.integer :mp_id
      t.timestamps
    end

    create_table :terms do |t|
      t.string  :text
      t.integer :value
      t.integer :cloud_id
      t.timestamps
    end

    create_table :mps do |t|
      t.string  :full_name
      t.integer :person_id
      t.string  :constituency
      t.string  :party
      t.text    :written_questions_text
      t.timestamps
    end
  end

  def self.down
    drop_table :mps
    drop_table :terms
    drop_table :clouds
  end
end
