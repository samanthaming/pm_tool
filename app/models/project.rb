class Project < ActiveRecord::Base
  has_many :tasks, dependent: :nullify
  has_many :discussions, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true
  validates :due_date, date:{ after: Proc.new { Time.now } }

  paginates_per 5
end
