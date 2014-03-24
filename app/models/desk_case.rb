require_relative './concerns/desk_api_v2'
class DeskCase < ActiveRecord::Base
  has_many :case_label_relations
  has_many :desk_labels, through: :case_label_relations

  include DeskApiV2

  def self.fetch_and_return
    sync_with_desk_api
    all
  end

  def self.sync_with_desk_api
    #TODO this method should be trigger by resque scheduler
    DeskLabel.sync_with_desk_api
    fetch_case_list.each do |desk_case|
      current_case = find_or_create_by_external_id desk_case[:external_id].to_s
      if current_case.present?
        current_case.update_attributes ({
          headline: desk_case[:headline],
          status: desk_case[:status],
          desk_type: desk_case[:desk_type]
        })

        #while labels = [nil] means new labels in desk api
        #and need to sync labels first
        labels = desk_case[:desk_labels].map do |desk_label|
          DeskLabel.find_by_name desk_label
        end.compact if (!desk_case[:desk_labels].nil? and desk_case[:desk_labels].respond_to?(:[]) )

        #updated case and label relation according to updated desk api
        #TODO sync will not delete label which has been deleted at local
        current_case.update_attributes(desk_labels:  labels)
      end
    end
  end


end
