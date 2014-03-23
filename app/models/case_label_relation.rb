class CaseLabelRelation < ActiveRecord::Base
  belongs_to :desk_case
  belongs_to :desk_label
end
