class HomeController < ApplicationController
  respond_to :js, except: [:index, :save_relation]

  def index
    @desk_cases = DeskCase.all
    @desk_labels = DeskLabel.all
  end

  def fetch_desk_case
    #@desk_cases = DeskCase.fetch_and_return
    @desk_cases = DeskCase.all
  end


  def fetch_desk_label
    #@desk_labels = DeskCase.fetch_and_return
    @desk_labels = DeskLabel.all
  end

  def create_label
    DeskLabel.create(label_params)
    @desk_labels = DeskLabel.all
  end

  def find_labels
    #binding.pry 
    desk_label_ids = DeskCase.find(params[:id]).desk_labels.pluck(:id)
    respond_to do |format|
      format.json { render json: {id: desk_label_ids} }
    end
  end

  def save_relation
    desk_case = DeskCase.find params['desk_case_id']
    label_ids = params['desk_label_ids']
    desk_case.desk_labels = DeskLabel.where(id: label_ids)
    desk_case.save
    #render text: 'updated successfull'
    respond_to do |format|
      format.json {render json: {text: 'updated successfull'}}
    end
  end

  private

  def label_params
    params.require(:desk_label).permit(:name)
  end

end
