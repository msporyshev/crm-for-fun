class OpportunitiesUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :opportunity

  def self.by_subdomain(subdomain)
    joins(:user).where(users: {subdomain: subdomain})
  end
end
