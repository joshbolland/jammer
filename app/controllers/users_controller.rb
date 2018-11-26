class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    @user_instrument = UserInstrument.new

    if @user == current_user
      @available_instruments = Instrument.all - current_user.instruments
    else
      @available_instruments = Instrument.all
    end

    @hosted_jams = @user.jams

    @hosted_slots = Slot.where(jam: @hosted_jams)
    @confirmed_slots = Slot.where(user: @user)

    @pending_requests = Request.where(slot: @hosted_slots, status: "pending")
    @personal_requests = Request.where(user: @user, status: "pending")
  end
end
