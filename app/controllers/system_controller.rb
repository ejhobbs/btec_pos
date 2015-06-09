class SystemController < ApplicationController
  def view
    if System.any?
      if params[:search]
        if params[:search].length > 0
          @systems = System.search(params[:search])
        else
          @systems = System.all
        end
      else
        @systems = System.all
      end
    else
      flash[:error] = 'No systems available at this time, please add one'
    end
  end

  def download
    send_file Rails.root.join('public', 'CSV', 'system.csv')
  end

  def upload
    rejected_systems = System.from_csv(params[:upload])
    if rejected_systems.any?
      flash[:error] = 'Processing of one or more systems failed'
    else
      flash[:info] = 'Processing succeeded!'
    end
    redirect_to action: 'view'
  end

  def edit
    if params[:id]
      begin
        @system = System.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = 'System not found, did you input the ID yourself?'
        redirect_to :action => 'view'
      end
    else
      redirect_to :action => 'new'
    end
  end

  def delete
    begin
      @system = System.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'User not found'
      redirect_to :action => 'view'
    end
    @system.destroy!
    flash[:alert] = 'System deleted successfully'
    redirect_to :action => 'view'
  end

  def new
    @system = System.new()
  end

  def process_new
    @system = System.new(system_params)
    if @system.save()
      flash[:alert] = 'System added successfully!'
      redirect_to :action => 'view'
    else
      render :action => 'new'
    end
  end

  def process_edit
    @system = System.find(params[:id])
    if @system.update_attributes(system_params)
      flash[:alert] = 'System updated successfully'
      redirect_to :action => 'view'
    else
      flash[:error] = 'Edit was unsuccessful'
      render :action => 'edit'
    end
  end


  def system_params
    params.require(:system).permit(:description, :audio_setup, :hd, :three_d, :base_price)
  end

end
