class HomeController < ApplicationController
  def index
    @desk_cases = DeskCase.all
    @desk_labels = DeskLabel.all
  end

  def fetch_desk_case
    #@desk_cases = DeskCase.fetch_and_return
    @desk_cases = DeskCase.all
    respond_to do |format|
      format.js
    end
  end
end
