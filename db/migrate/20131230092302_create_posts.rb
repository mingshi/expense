class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :uid
      t.string :realname
      t.string :department
      t.string :project
      t.string :type
      t.string :money
      t.string :captital
      t.string :advance
      t.string :ac_expend
      t.string :difference
      t.integer :status
      t.integer :step_uid
      t.string :step_user
      t.text :des

      t.timestamps
    end
  end
end
