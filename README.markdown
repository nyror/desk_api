## Desk Api Demo

demo: http://desk-api.herokuapp.com

### spec

ruby: 2.1.1

rails: 4.0.4

### Main Function

### outh for desk api

```ruby
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
#....
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
```

#### drive by github issue

![screen shot 2014-03-24 at 12 07 42 am](https://f.cloud.github.com/assets/83296/2495911/13882f6a-b30a-11e3-867c-f9b24d8273d2.png)

![screen shot 2014-03-24 at 12 10 37 am](https://f.cloud.github.com/assets/83296/2495921/517535d4-b30a-11e3-866e-b33c8d91032f.png)
#### RJS

using rjs to fetch and replace

```ruby
#app/views/shared/_desk_case.html.haml
.label
  = link_to 'fetch case', fetch_desk_cases_path, remote: true
- size ||= 16
= select_tag :desk_case, desk_case_option(desk_cases), {multiple: 'multiple', size: size}

#fetch_desk_case.js.erb
$('.desk_case').empty();
$('.desk_case').append('<%=j render "shared/desk_case", desk_cases: @desk_cases%>')
```

#### coffeescript with ajax call

```coffeescript
$(document).ready ->

  $('#desk_labels').change ->
    $('.delete_label').fadeIn('slow')

  $('#desk_case').change ->
    desk_case_id = $('#desk_case').val()[0]
    $.ajax
      url: '/desk_labels/' + desk_case_id + '/find.json',
      type: 'get',
      success: (data, textStatus, jqXHR) ->
        $('#desk_labels').val(data['id'])
        $('.delete_label').fadeIn('slow')
        $('.save_label').fadeIn('slow')
```

#### rspec test 
with factory girl and heavy mock

```ruby
    let!(:label2) { create(:desk_label, name: 'label 2', external_id: '345') }
    let!(:case2) { create(:desk_case, headline: 'case 2', external_id: '9', desk_labels: [label1])}

    it 'should also change desk label while desk api have updated label' do
      expect(DeskCase).to receive(:fetch_case_list).and_return(
        [
          {external_id: '9', headline: 'new headline', status: 'open', desk_type: 'case', desk_labels: ['label 2']}
        ]
      )
      expect{subject}.to change{DeskCase.count}.by(0)
      expect(DeskCase.find_by_external_id('9').desk_labels).to eq [label2]

    end
```

#### heroku with uniron 

deploy heroku with uniorn

```ruby

#Procfile
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb

```
