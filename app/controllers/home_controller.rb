class HomeController < ApplicationController
  def index
    @desk_cases = DeskCase.all
    @desk_labels = DeskLabel.all
  end
end
