class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, null: false, unique: true
      t.datetime :due_date
      t.timestamps null: false
    end
  end
end
