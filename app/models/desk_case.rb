require_relative './concerns/desk_api_v2'
class DeskCase < ActiveRecord::Base
  has_many :case_label_relations
  has_many :desk_labels, through: :case_label_relations

  include DeskApiV2

  def self.sync_with_desk_api
    #TODO this method should be trigger by resque scheduler
    #DeskLabel.sync_with_desk_api
    fetch_case_list.each do |desk_case|
      current_case = find_or_create_by_external_id desk_case[:external_id]
      if current_case.present?
        current_case.update_attributes ({
          headline: desk_case[:headline],
          status: desk_case[:status],
          desk_type: desk_case[:desk_type]
        })

        labels = desk_case[:desk_labels].map do |desk_label|
          DeskLabel.find_by_name desk_label
        end if desk_case[:desk_labels].present?

        #updated case and label relation according to updated desk api
        #TODO sync will not delete label which has been deleted at local
        current_case.update_attributes(desk_labels:  labels)
      end
    end
  end


end
