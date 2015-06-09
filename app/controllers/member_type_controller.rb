class MemberTypeController < ApplicationController
  def view
    if MemberType.any?
      if params[:search]
        if params[:search].length > 0
          @member_types = MemberType.search(params[:search])
        else
          @member_types = MemberType.all
        end
      else
        @member_types = MemberType.all
      end
    else
      flash[:error] = 'No member_types available at this time, please add one'
    end
  end

  def download
    send_file Rails.root.join('public', 'CSV', 'member_types.csv')
  end

  def upload
    rejected_member_types = MemberType.from_csv(params[:upload])
    if rejected_member_types.any?
      flash[:error] = 'Processing of one or more member_types failed'
    else
      flash[:info] = 'Processing succeeded!'
    end
    redirect_to action: 'view'
  end

  def edit
    if params[:id]
      begin
        @member_type = MemberType.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = 'Member Type not found, did you input the ID yourself?'
        redirect_to :action => 'view'
      end
    else
      redirect_to :action => 'new'
    end
  end

  def delete
    begin
      @member_type = MemberType.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'User not found'
      redirect_to :action => 'view'
    end
    @member_type.destroy!
    flash[:alert] = 'Member Type deleted successfully'
    redirect_to :action => 'view'
  end

  def new
    @member_type = MemberType.new()
  end

  def process_new
    @member_type = MemberType.new(member_type_params)
    if @member_type.save()
      flash[:alert] = 'Member Type added successfully!'
      redirect_to :action => 'view'
    else
      render :action => 'new'
    end
  end

  def process_edit
    @member_type = MemberType.find(params[:id])
    if @member_type.update_attributes(member_type_params)
      flash[:alert] = 'Member Type updated successfully'
      redirect_to :action => 'view'
    else
      flash[:error] = 'Edit was unsuccessful'
      render :action => 'edit'
    end
  end

  def member_type_params
    params.require(:member_type).permit(:easy_name, :price, :requires_previous)
  end

end
