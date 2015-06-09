class ProductRentalController < ApplicationController
  def view
    if ProductRental.any?
      if params[:search]
        if params[:search].length > 0
          @product_rentals = ProductRental.search(params[:search])
        else
          @product_rentals = ProductRental.all
        end
      else
        @product_rentals = ProductRental.all
      end
    else
      flash[:error] = 'No product_rentals available at this time, please add one'
    end
  end

  def view_receipt
    if params[:id]
      @product_rental = ProductRental.find(params[:id])
    else
      redirect_to :action => 'view'
    end
    render pdf: 'booking_'+@product_rental.id.to_s
  end

  def view_overdue
    @product_rentals = ProductRental.where('returned = 0 AND due_date > :today',today: Date.today)
    render pdf: 'Overdue Rentals '+Date.today.to_s
  end

  def return
    @product_rental = ProductRental.find(params[:id])
    @product_rental.returned = true
    if @product_rental.overdue
      @product_rental.late_fees = 2*(Date.today()-@product_rental.due_date)
      @product_rental.save
      redirect_to :action => 'view_receipt', :id => @product_rental.id
    else
      flash[:alert] = 'Product Returned successfully'
      redirect_to :action => 'view'
    end
  end

  def delete
    begin
      @product_rental = ProductRental.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'User not found'
      redirect_to :action => 'view'
    end
    @product_rental.destroy!
    flash[:alert] = 'ProductRental deleted successfully'
    redirect_to :action => 'view'
  end

  def new
    @product_rental = ProductRental.new()
    if params[:system_id]
      @product_rental.system_id = params[:system_id]
    end
  end

  def process_new
    @product_rental = ProductRental.new(product_rental_params)
    @product_rental.total_price = 0
    @product_rental.late_fees = 0
    @product_rental.returned = false
    if @product_rental.save()
      flash[:alert] = 'ProductRental added successfully!'
      redirect_to :action => 'add_items', :id => @product_rental.id
    else
      render :action => 'new'
    end
  end

  def add_items
    @product_rental = ProductRental.find(params[:id])
    if @product_rental.product_rental_items
      puts 'Im heeere'
      @rental_items = @product_rental.product_rental_items
    else
      @rental_items = nil
    end
    if params[:product_rental_item]
      @rental_item = ProductRentalItem.new(product_rental_item_params)
      @rental_item.product_rental_id = @product_rental.id
      if @rental_item.valid? and params[:commit] == 'Add More'
        @product_rental.total_price += @rental_item.product.product_type.price * @product_rental.duration
        @rental_item.save
        @product_rental.save
        redirect_to :action => 'add_items', :id => @product_rental.id
      elsif @rental_item.valid? and params[:commit] == 'Done'
        @product_rental.total_price += @rental_item.product.product_type.price * @product_rental.duration
        @rental_item.save
        @product_rental.save
        redirect_to :action => 'view'
      else
        render :action => 'add_items'
      end
    end
  end

  def process_edit
    @product_rental = ProductRental.find(params[:id])
    if @product_rental.update_attributes(product_rental_params)
      flash[:alert] = 'ProductRental updated successfully'
      redirect_to :action => 'view'
    else
      flash[:error] = 'Edit was unsuccessful'
      render :action => 'edit'
    end
  end

  def product_rental_params
    params.require(:product_rental).permit(:member_id, :start_date, :due_date, :returned)
  end

  def product_rental_item_params
    params.require(:product_rental_item).permit(:product_id)
  end
end
