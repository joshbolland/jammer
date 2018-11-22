class JamsController < ApplicationController
  def index
    @jams = Jam.where.not(latitude: nil, longitude: nil)

    @markers = @jams.map do |jam|
      {
        lng: jam.longitude,
        lat: jam.latitude
      }
    end
  end

  def show
    @jam = Jam.find(params[:id])
    # @jam.user = current_user
  end

  def new
    @jam = Jam.new
  end

  def create
    @jam = Jam.new(jam_params)
    @jam.user = current_user
    if @jam.save
      redirect_to jam_path(@jam)
    else
      render :new
    end
  end

  def edit
    @jam = Jam.find(params[:id])
  end

  def update
    @jam = Jam.find(params[:id])
    if @jam.update(jam_params)
      redirect_to jam_path(@jam)
    else
      render :edit
    end
  end

  def destroy
    @jam = Jam.find(params[:id])
    @jam.destroy
    respond_to do |format|
      format.html { redirect_to jams_url, notice: "Jam was successfully destroyed."}
      format.json { head :no_content }
    end
  end

  private

  def jam_params
    params.require(:jam).permit(:title, :date, :time, :location, :description, :photo)
  end
end
