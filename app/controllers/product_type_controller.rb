class ProductTypeController < ApplicationController
  def view
    if ProductType.any?
      if params[:search]
        if params[:search].length > 0
          @product_types = ProductType.search(params[:search])
        else
          @product_types = ProductType.all
        end
      else
        @product_types = ProductType.all
      end
    else
      flash[:error] = 'No product_types available at this time, please add one'
    end
  end

  def download
    send_file Rails.root.join('public', 'CSV', 'product_types.csv')
  end

  def upload
    rejected_product_types = ProductType.from_csv(params[:upload])
    if rejected_product_types.any?
      flash[:error] = 'Processing of one or more product_types failed'
    else
      flash[:info] = 'Processing succeeded!'
    end
    redirect_to action: 'view'
  end

  def edit
    if params[:id]
      begin
        @product_type = ProductType.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = 'Product Type not found, did you input the ID yourself?'
        redirect_to :action => 'view'
      end
    else
      redirect_to :action => 'new'
    end
  end

  def delete
    begin
      @product_type = ProductType.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'User not found'
      redirect_to :action => 'view'
    end
    @product_type.destroy!
    flash[:alert] = 'Product Type deleted successfully'
    redirect_to :action => 'view'
  end

  def new
    @product_type = ProductType.new()
  end

  def process_new
    @product_type = ProductType.new(product_type_params)
    if @product_type.save()
      flash[:alert] = 'Product Type added successfully!'
      redirect_to :action => 'view'
    else
      render :action => 'new'
    end
  end

  def process_edit
    @product_type = ProductType.find(params[:id])
    if @product_type.update_attributes(product_type_params)
      flash[:alert] = 'Product Type updated successfully'
      redirect_to :action => 'view'
    else
      flash[:error] = 'Edit was unsuccessful'
      render :action => 'edit'
    end
  end

  def product_type_params
    params.require(:product_type).permit(:easy_name, :price)
  end
end
