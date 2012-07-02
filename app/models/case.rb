class Case < ActiveRecord::Base
  has_and_belongs_to_many :people
  belongs_to :user
end
