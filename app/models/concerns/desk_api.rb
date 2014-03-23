module DeskApi
  extend ActiveSupport::Concern


  included do
    class_attribute :access_token
  end

  module ClassMethods
    def fetch_case_list
      parse access_token.get("#{desk_url}cases")
    end

    def fetch_label_list
      parse access_token.get("#{desk_url}labels")
    end

    def create_new_label options
      access_token.post("#{desk_url}labels", options.to_json)
    end

    def delete_label desk_label
      access_token.delete("#{desk_url}labels/#{desk_label.external_id}")
    end

    def replace_case_label desk_case, desk_labels
      access_token.put("#{desk_url}cases/#{desk_case.external_id}", {
        label_action: 'replace',
        labels: desk_labels.pluck(:name)
      }.to_json)
    end

    private
    def access_token
      @access_token ||= DeskApi::Application.config.access_token
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
