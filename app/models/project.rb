class Project < ActiveRecord::Base

  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :comments, through: :discussions, dependent: :destroy
  belongs_to :user


	validates :title, presence: true, uniqueness: true

	default_scope order("created_at DESC")

end
