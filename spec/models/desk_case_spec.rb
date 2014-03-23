require 'spec_helper'

describe DeskCase do

  context 'many to many relation with desk_labels' do
    let(:label1) {create(:desk_label, name: 'label 1')}
    let(:case1) {create(:desk_case, desk_labels: [label1])}

    it 'should have proper relation' do
      expect(case1.desk_labels).to eq [label1]
      expect(label1.desk_cases).to eq [case1]
    end
  end

  context 'able to sync with desk api' do
    let(:label1) {create(:desk_label, name: 'label 1')}
    subject{ DeskCase.sync_with_desk_api }

    it 'able to run with any cases back from desk api' do
      expect(DeskCase).to receive(:fetch_case_list).and_return([])
      expect{subject}.to_not raise_error
    end

    it 'should add new case while desk api have new data' do
      expect(DeskCase).to receive(:fetch_case_list).and_return(
        [
          {external_id: '19', headline: 'new headline', status: 'open', desk_type: 'case', desk_labels: []}
        ]
      )
      expect{subject}.to change{DeskCase.count}.by(1)
    end

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

  end
end
