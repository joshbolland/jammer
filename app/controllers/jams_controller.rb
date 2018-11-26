class JamsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @location = params[:location]
    if params[:location].present?
      @instrument = Instrument.find(params[:instrument])
      @jams = Jam.where.not(latitude: nil, longitude: nil).near(params[:location], 10).select { |jam| jam.slots.any? { |slot| slot.instrument == @instrument } }
      if params[:date].present?
        @instrument = Instrument.find(params[:instrument])
        @jams = Jam.where.not(latitude: nil, longitude: nil).near(params[:location], 10).where(date: params[:date]).select { |jam| jam.slots.any? { |slot| slot.instrument == @instrument } }
      end
    elsif params[:instrument].present?
      @instrument = Instrument.find(params[:instrument])
      @jams = Jam.where.not(latitude: nil, longitude: nil).select { |jam| jam.slots.any? { |slot| slot.instrument == @instrument } }
      if params[:date].present?
        @instrument = Instrument.find(params[:instrument])
        @jams = Jam.where.not(latitude: nil, longitude: nil).where(date: params[:date]).select { |jam| jam.slots.any? { |slot| slot.instrument == @instrument } }
      end
    else
      @jams = Jam.where.not(latitude: nil, longitude: nil)
    end

    @markers = @jams.map do |jam|
      {
        lng: jam.longitude,
        lat: jam.latitude,
        infoWindow: { content: render_to_string(partial: "/jams/map_window", locals: { jam: jam }) }
      }
    end

    @instruments = Instrument.all
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
