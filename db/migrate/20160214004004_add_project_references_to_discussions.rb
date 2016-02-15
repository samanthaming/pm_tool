class AddProjectReferencesToDiscussions < ActiveRecord::Migration
  def change
    add_reference :discussions, :project, index: true, foreign_key: true
  end
end
