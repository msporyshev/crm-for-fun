class Case < ActiveRecord::Base
  has_and_belongs_to_many :people
  has_many :tasks, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  has_and_belongs_to_many :users
  belongs_to :user

  validates :title, presence: true

  def self.by_subdomain(subdomain)
    joins(:user).where(users: {subdomain: subdomain})
  end
end
