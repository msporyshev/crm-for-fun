class Opportunity < ActiveRecord::Base
  belongs_to :responsible_user, class_name: "User", foreign_key: "responsible_id"
  belongs_to :user
  has_many :tasks
  has_and_belongs_to_many :people
  has_and_belongs_to_many :users
  has_many :documents

  validates :title, presence: true

  def self.by_subdomain(subdomain)
    joins(:user).where(users: {subdomain: subdomain})
  end
end
