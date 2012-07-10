class Task < ActiveRecord::Base
  belongs_to :responsible_user, class_name: "User", foreign_key: "responsible_id"
  belongs_to :user
  belongs_to :person
  belongs_to :case
  belongs_to :opportunity

  validates :title, presence: true
  validates :responsible_id, presence: true
  validates :user_id, presence: true

  def self.by_subdomain(subdomain)
    joins(:user).where(users: {subdomain: subdomain})
  end
end
