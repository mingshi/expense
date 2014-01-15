class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.integer :uid
      t.text :info
      t.integer :eid
      t.string :realname

      t.timestamps
    end
  end
end
