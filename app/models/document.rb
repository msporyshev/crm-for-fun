class CaseOppPersonPresenceValidator < ActiveModel::Validator
  def validate(record)
    if record.case_id.blank? and record.person_id.blank? and record.opportunity_id.blank?
      record.errors[:base] << "should have associated contact, case or opportunity"
    end
  end
end

class Document < ActiveRecord::Base
  belongs_to :case
  belongs_to :person
  belongs_to :opportunity

  mount_uploader :document, DocumentUploader

  validates :document, presence: true
  validates_with CaseOppPersonPresenceValidator, :fields => [:case_id, :person_id]
end

