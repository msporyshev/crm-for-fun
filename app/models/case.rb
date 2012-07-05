class Case < ActiveRecord::Base
  has_and_belongs_to_many :people
  has_many :tasks
  has_many :documents
  belongs_to :user

  validates :title, presence: true
end
