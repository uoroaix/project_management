class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

	validates :title, presence: true, uniqueness: true
  scope :ordered_by_creation, -> { order("status DESC, created_at DESC")}

end
