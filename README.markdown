## Desk Api Demo

demo: http://desk-api.herokuapp.com

### spec

ruby: 2.1.1

rails: 4.0.4

### Main Function

### outh for desk api

as mention in requirement

#### drive by github issue




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
