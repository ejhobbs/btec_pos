class SystemBookingController < ApplicationController
  def view
    if SystemBooking.any?
      if params[:search]
        if params[:search].length > 0
          @system_bookings = SystemBooking.search(params[:search])
        else
          @system_bookings = SystemBooking.all
        end
      else
        @system_bookings = SystemBooking.all
      end
    else
      flash[:error] = 'No system_bookings available at this time, please add one'
    end
  end

  def view_receipt
    if params[:id]
      @system_booking = SystemBooking.find(params[:id])
    else
      redirect_to :action => 'view'
    end
    render pdf: 'booking_'+@system_booking.id.to_s
  end

  def due_today
    @system_bookings = SystemBooking.due_today
    render pdf: 'Installations Due:'+Date.today().to_s
  end

  def edit
    if params[:id]
      begin
        @system_booking = SystemBooking.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = 'SystemBooking not found, did you input the ID yourself?'
        redirect_to :action => 'view'
      end
    else
      redirect_to :action => 'new'
    end
  end

  def delete
    begin
      @system_booking = SystemBooking.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'User not found'
      redirect_to :action => 'view'
    end
    @system_booking.destroy!
    flash[:alert] = 'SystemBooking deleted successfully'
    redirect_to :action => 'view'
  end

  def new
    @system_booking = SystemBooking.new()
    if params[:system_id]
      @system_booking.system_id = params[:system_id]
    end
  end

  def process_new
    @system_booking = SystemBooking.new(system_booking_params)
    if @system_booking.save()
      flash[:alert] = 'SystemBooking added successfully!'
      redirect_to :action => 'view'
    else
      render :action => 'new'
    end
  end

  def process_edit
    @system_booking = SystemBooking.find(params[:id])
    if @system_booking.update_attributes(system_booking_params)
      flash[:alert] = 'SystemBooking updated successfully'
      redirect_to :action => 'view'
    else
      flash[:error] = 'Edit was unsuccessful'
      render :action => 'edit'
    end
  end

  def system_booking_params
    params.require(:system_booking).permit(:member_id, :install_date, :collection_date, :deposit_paid, :system_id)
  end
end
