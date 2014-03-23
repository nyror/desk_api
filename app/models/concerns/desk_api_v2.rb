module DeskApiV2
  extend ActiveSupport::Concern


  included do
    class_attribute :access_token
  end

  module ClassMethods
    def fetch_case_list
      rs = parse desk_access_token.get("#{desk_url}cases")
      rs['_embedded']['entries'].map do |desk_case|
        local_case = HashWithIndifferentAccess.new
        local_case[:external_id] = desk_case['id']
        local_case[:headline] = desk_case['subject']
        local_case[:status] = desk_case['status']
        local_case[:desk_type] = desk_case['type']
        local_case[:desk_labels] = desk_case['labels']
        local_case
      end
    end

    def fetch_label_list
      rs = parse desk_access_token.get("#{desk_url}labels")
      rs['_embedded']['entries'].map do |desk_label|
        local_label = HashWithIndifferentAccess.new
        local_label[:external_id] = desk_label['_links']['self']['href'][/\d+$/]
        local_label[:name] = desk_label['name']
        local_label[:enabled] = desk_label['enabled']
        local_label[:desk_types] = desk_label['types']
        local_label[:color] = desk_label['color']
        local_label
      end
    end

    def create_new_label options
      desk_access_token.post("#{desk_url}labels", options.to_json)
    end

    def delete_label desk_label
      desk_access_token.delete("#{desk_url}labels/#{desk_label.external_id}")
    end

    def replace_case_label desk_case, desk_labels
      desk_access_token.put("#{desk_url}cases/#{desk_case.external_id}", {
        label_action: 'replace',
        labels: desk_labels.pluck(:name)
      }.to_json)
    end

    private
    def desk_access_token
      #@access_token ||= DeskApi::Application.config.access_token
      DeskApi::Application.config.access_token
    end

    #TODO should be read from yaml config file
    def desk_url
      "https://lion.desk.com/api/v2/"
    end

    def parse response
      JSON.parse response.body
    end
  end
end
