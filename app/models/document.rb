class CaseOrPersonPresenceValidator < ActiveModel::Validator
  def validate(record)
    unless record.case or record.document
      record.errors[:base] << "should have associated contact or case"
    end
  end
end

class Document < ActiveRecord::Base
  belongs_to :case
  belongs_to :person

  mount_uploader :document, DocumentUploader

  validates :document, presence: true
  validates_with CaseOrPersonPresenceValidator, :fields => [:case_id, :person_id]
end

