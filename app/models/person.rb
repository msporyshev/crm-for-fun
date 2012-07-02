class Person < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true, :length => { :maximum => 40 }
  validates :surname, :presence => true, :length => { :maximum => 40 }
  validates :email,
    :format => { :with => email_regex }

  belongs_to :user
  has_many :tasks
  has_and_belongs_to_many :cases
end
