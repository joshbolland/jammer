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

  def destroy
    @slot = Slot.find(params[:id])
    @slot.destroy
    respond_to do |format|
      format.html { redirect_to jam_path(@slot.jam), notice: "Deleted Jam Slot!" }
      format.json { head :no_content }
    end
  end

  private

  def slot_params
    params.require(:slot).permit(:instrument_id)
  end
end
