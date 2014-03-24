class HomeController < ApplicationController
  respond_to :js, except: [:index]
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

  private

  def label_params
    params.require(:desk_label).permit(:name)
  end

end
