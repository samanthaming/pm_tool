class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :nullify
  has_many :discussions, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  validates :title, presence: true, uniqueness: true
  validates :due_date, date:{ after: Proc.new { Time.now } }

  paginates_per 5

  def favorite_for(user)
    favorites.find_by_user_id user
  end
end
