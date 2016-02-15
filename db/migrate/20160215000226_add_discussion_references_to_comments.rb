class AddDiscussionReferencesToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :discussion, index: true, foreign_key: true
  end
end
