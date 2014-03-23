require 'spec_helper'

describe DeskLabel do

  context 'many to many relation with desk_labels' do
    let(:label1) {create(:desk_label, name: 'label 1')}
    let(:case1) {create(:desk_case, desk_labels: [label1])}

    it 'should have proper relation' do
      case1.desk_labels = []
      case1.save
      expect(DeskLabel.find_by_id(label1.id).desk_cases).to be_empty
    end
  end

  context 'able to sync with desk api' do
    let(:label1) {create(:desk_label, name: 'label 1', external_id: '3')}
    subject{ DeskLabel.sync_with_desk_api }

    it 'able to run with any cases back from desk api' do
      expect(DeskLabel).to receive(:fetch_label_list).and_return([])
      expect{subject}.to_not raise_error
    end

    it 'should add new case while desk api have new data' do
      expect(DeskLabel).to receive(:fetch_label_list).and_return(
        [
          {external_id: '19', name: 'new label', enabled: 'open', desk_types: ['case'], color: 'red'}
        ]
        
      )
      expect{subject}.to change{DeskLabel.count}.by(1)
    end
  end
end
