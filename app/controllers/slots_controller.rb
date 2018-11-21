class SlotsController < ApplicationController
  def new
    @slot = Slot.new
    @instruments = Instrument.all
  end

  def create
  end
end
