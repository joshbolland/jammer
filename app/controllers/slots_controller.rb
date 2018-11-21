class SlotsController < ApplicationController
  def new
    @slot = Slot.new
    @instruments = Instrument.all
    @jam = Jam.find(params[:jam_id])
  end

  def create
    @slot = Slot.new(slot_params)
    @jam = Jam.find(params[:jam_id])
    @slot.jam = @jam
    @slot.save
    redirect_to jam_path(@jam)
  end

  private

  def slot_params
    params.require(:slot).permit(:instrument_id)
  end
end
