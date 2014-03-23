require_relative './concerns/desk_api_v2'
class DeskLabel < ActiveRecord::Base
  serialize :desk_types
  has_many :case_label_relations
  has_many :desk_cases, through: :case_label_relations

  include DeskApiV2

  def self.fetch_and_return
    sync_with_desk_api
    all
  end

  def self.sync_with_desk_api
    fetch_label_list.each do |desk_label|
      local_label = find_or_create_by_external_id desk_label[:external_id]
      local_label.update_attributes({
        name: desk_label[:name],
        enabled: desk_label[:enabled],
        desk_types: desk_label[:desk_types],
        color: desk_label[:color]
      }) if local_label.present?
    end
  end
end
