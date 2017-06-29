class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :direction, { null: false }
      t.integer :user_id, { null: false }
      t.integer :votable_id
      t.string :votable_type

      t.timestamps
    end
  end
end
