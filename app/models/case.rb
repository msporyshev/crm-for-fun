class Case < ActiveRecord::Base
  has_and_belongs_to_many :people
  has_many :tasks, :dependent => :destroy
  has_many :documents, :dependent => :destroy
  belongs_to :user

  validates :title, presence: true
end
