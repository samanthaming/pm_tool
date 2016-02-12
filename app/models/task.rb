class Task < ActiveRecord::Base
  belongs_to :project

  after_initialize :set_defaults

  validates :title, presence: true, uniqueness: { scope: :project_id}
  validates :due_date, date: { after: Proc.new { Time.now } }
  validates :body, presence: true
  validates :status, numericality: {only_integer: true}

  # scope :done, -> {where(done: true)}
  # scope :undone, -> {where(done: false)}

  scope :done, -> (done) { where(done: done )  }


  private

  def set_defaults
    self.done ||= false
  end
end
