class Discussion < ActiveRecord::Base

  validates :title, presence: true
end
