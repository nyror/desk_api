FactoryGirl.define do
  factory :desk_label do
    name 'First Label'
    desk_types ['case']
    external_id '33'
    enabled 't'
    color 'red'
  end
end
