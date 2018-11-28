class UserInstrumentsController < ApplicationController

  def new
    @available_instruments = Instrument.all - current_user.instruments
    @user_instrument = UserInstrument.new
  end

  def create
    params[:user_instrument][:instrument_ids].each do |instrument_id|
      next if instrument_id == ""
      @user_instrument = UserInstrument.new
      @user_instrument.user = current_user
      @user_instrument.instrument = Instrument.find(instrument_id)
      @user_instrument.save
    end
    redirect_to user_path(current_user)
  end
end
