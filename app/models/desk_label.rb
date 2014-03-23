class DeskLabel < ActiveRecord::Base
  has_many :case_label_relations
  has_many :desk_cases, through: :case_label_relations
end
