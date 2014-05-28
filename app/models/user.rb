class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :tasks
  has_many :projects
  has_many :discussions


  validates :first_name, :last_name, presence: true

  def full_name
    if first_name || last_name
      "#{first_name.capitalize} #{last_name.capitalize}".squeeze(" ").strip
    else
      email
    end
  end


end
