class Opportunity < ActiveRecord::Base
  belongs_to :responsible_user, class_name: "User", foreign_key: "responsible_id"
  belongs_to :owner, class_name: "User"
  has_many :tasks
  has_and_belongs_to_many :people
  has_many :documents

  validates :title, presence: true
end
