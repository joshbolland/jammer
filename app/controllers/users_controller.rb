class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @hosted_jams = @user.jams
    @hosted_slots = Slot.where(jam: @hosted_jams)
    @pending_requests = Request.where(slot: @hosted_slots, status: "pending")
  end
end
