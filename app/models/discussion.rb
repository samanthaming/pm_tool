class Discussion < ActiveRecord::Base
  belongs_to :project
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {maximum: 255}, uniqueness: {scope: :project_id}
end
