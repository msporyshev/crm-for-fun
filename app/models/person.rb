class Person < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true, :length => { :maximum => 40 }
  validates :surname, :presence => true, :length => { :maximum => 40 }
  validates :email,
    :format => { :with => email_regex },
    allow_blank: true,
    allow_nil: true

  belongs_to :user
  has_and_belongs_to_many :opportunities
  has_many :tasks
  has_many :documents
  has_and_belongs_to_many :cases
  has_and_belongs_to_many :users

  def self.by_subdomain(subdomain)
    joins(:user).where(users: {subdomain: subdomain})
  end
end
