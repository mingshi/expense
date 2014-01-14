class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :uid
      t.string :realname
      t.string :department
      t.string :project
      t.string :p_type
      t.string :money
      t.text :des
      t.integer :eid

      t.timestamps
    end
  end
end
