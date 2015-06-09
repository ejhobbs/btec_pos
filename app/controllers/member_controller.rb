class MemberController < ApplicationController
  def view
    if Member.any?
      if params[:search]
        if params[:search].length > 0
          @members = Member.search(params[:search])
        else
          @members = Member.all
        end
      else
        @members = Member.all
      end
    else
      flash[:error] = 'No members available at this time, please add one'
      redirect_to root_url
    end
  end

  def download
    send_file Rails.root.join('public', 'CSV', 'members.csv')
  end

  def upload
    rejected_members = Member.from_csv(params[:upload])
    if rejected_members.any?
      flash[:error] = 'Processing of one or more members failed'
    else
      flash[:info] = 'Processing succeeded!'
    end
    redirect_to action: 'view'
  end

  def edit
    if params[:id]
      begin
        @member = Member.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = 'User not found, did you input the ID yourself?'
        redirect_to :action => 'view'
      end
    else
      redirect_to :action => 'new'
    end
  end

  def delete
    begin
      @member = Member.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'User not found'
      redirect_to :action => 'view'
    end
    @member.destroy!
    flash[:alert] = 'User deleted successfully'
    redirect_to :action => 'view'
  end

  def new
    @member = Member.new()
  end

  def process_new
    @member = Member.new(member_params)
    @member.member_type_id=0
    if @member.save()
      flash[:alert] = 'Member added successfully!'
      redirect_to :action => 'view'
    else
      render :action => 'new'
    end
  end

  def process_edit
    @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      flash[:alert] = 'User updated successfully'
      redirect_to :action => 'view'
    else
      flash[:error] = 'Edit was unsuccessful'
      render :action => 'edit'
    end
  end

  def member_params
    params.require(:member).permit(:title, :first_name, :surname, :house_no, :street_name, :postcode, :date_of_birth, :contact_no)
  end

end
