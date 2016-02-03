class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false, unique: true
      t.text :description
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
