class Discussion < ActiveRecord::Base
	validates :title, :description, presence: true
  belongs_to :project
  has_many :comments, dependent: :destroy
  belongs_to :user
end
