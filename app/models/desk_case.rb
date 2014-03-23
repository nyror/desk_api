require_relative './concerns/desk_api_v2'
class DeskCase < ActiveRecord::Base
  has_many :case_label_relations
  has_many :desk_labels, through: :case_label_relations

  include DeskApiV2


end
