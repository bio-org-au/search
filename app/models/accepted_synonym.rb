class AcceptedSynonym < ActiveRecord::Base
  self.table_name = "accepted_synonym_vw"
  self.primary_key = "id"
  belongs_to :synonym_type, class_name: "InstanceType", foreign_key: :synonym_type_id
  belongs_to :synonym_ref, class_name: "Reference", foreign_key: :synonym_ref_id
  belongs_to :synonym_name, class_name: "Name", foreign_key: :id
  belongs_to :synonym_cites, class_name: "Instance", foreign_key: :cites_instance_id
  scope :simple_name_like, ->(string) { where("lower((simple_name)) like lower((?)) ", string.gsub(/\*/, "%").downcase) }
  scope :full_name_like, ->(string) { where("lower((full_name)) like lower((?)) ", string.gsub(/\*/, "%").downcase) }
  scope :default_ordered, -> { order("lower(simple_name)") }

  def accepted_accepted?
    type_code == "ApcConcept"
  end

  def accepted_excluded?
    type_code == "ApcExcluded"
  end

  def synonym?
    type_code == "synonym"
  end
end
