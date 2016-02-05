class Project < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  validates :due_date, date:{ after: Proc.new { Time.now } }
end
