class Project < ActiveRecord::Base
  has_many :tasks, dependent: :nullify

  validates :title, presence: true, uniqueness: true
  validates :due_date, date:{ after: Proc.new { Time.now } }
end
