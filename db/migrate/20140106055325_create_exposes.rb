class CreateExposes < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :money
      t.string :borrow
      t.string :realoffs
      t.string :spread
      t.integer :status
      t.string :step
      t.string :capital
      t.integer :step_uid
      t.string :step_realname

      t.timestamps
    end
  end
end
