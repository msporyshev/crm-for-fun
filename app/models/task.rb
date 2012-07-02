class Task < ActiveRecord::Base
  belongs_to :responsible_user, class_name: "User", foreign_key: "responsible_id"
  belongs_to :owner, class_name: "User"
  belongs_to :person
  belongs_to :case

  validates :title, presence: true
  validates :responsible_id, presence: true
  validates :user_id, presence: true
end
