class PeopleUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :person

  def self.by_subdomain(subdomain)
    joins(:user).where(users: {subdomain: subdomain})
  end
end
