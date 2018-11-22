class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @search = {}
    @instruments = Instrument.all
  end
end
