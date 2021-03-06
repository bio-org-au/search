# frozen_string_literal: true

# Rails model
class InstanceNotesForDetail < ActiveRecord::Base
  self.table_name = "instance_note"
  self.primary_key = "id"
  default_scope do
    where("instance_note_key_id in (select id from instance_note_key
          where not deprecated
          and name not like 'APC%'
          and name not like 'EPBC%') ")
  end

  scope :only_type_notes, (lambda do
    where("instance_note_key_id in (
          select id from instance_note_key
          where name in ('Lectotype', 'Neotype','Type') ) ")
  end)

  scope :without_type_notes, (lambda do
    where("instance_note_key_id not in
          (select id from instance_note_key
          where name in ('Lectotype', 'Neotype','Type') ) ")
  end)

  belongs_to :instance
  belongs_to :instance_note_key
  belongs_to :name_detail, foreign_key: "instance_id"

  def apc_distribution?
    instance_note_key.apc_distribution?
  end

  def apc_comment?
    instance_note_key.apc_comment?
  end

  def marked_up_value
    value.gsub(/<IT>/, "<em>").gsub(/<RO>/, "</em> ")
  end
end
