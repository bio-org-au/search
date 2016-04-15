class NameTreePath < ActiveRecord::Base
  self.table_name = "name_tree_path"
  self.primary_key = "id"

  belongs_to :name
  belongs_to :apni_name_tree_path, class_name: "Name"
  belongs_to :apni_tree_arrangement, -> { where label: 'APNI' },
             class_name: "TreeArrangement",
             foreign_key: "tree_id"
end
