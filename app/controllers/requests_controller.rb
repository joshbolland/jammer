class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end

  def new
    @request = Request.new
    @slot = Slot.find(params[:slot_id])
  end

  def create
    @request = Request.new(request_params)
    @slot = Slot.find(params[:slot_id])
    @request.user = current_user
    @request.slot = @slot
    if @request.save
      redirect_to jam_path(@slot.jam)
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:user_id, :slot_id, :status, :message)
  end
end
