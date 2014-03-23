class DeskCase < ActiveRecord::Base
  has_many :case_label_relations
  has_many :desk_labels, through: :case_label_relations
end
