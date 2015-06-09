class ProductController < ApplicationController
  def view
    if Product.any?
      if params[:search]
        if params[:search].length > 0
          @products = Product.search(params[:search])
        else
          @products = Product.all
        end
      else
        @products = Product.all
      end
    else
      flash[:error] = 'No products available at this time, please add one'
    end
  end

  def download
    send_file Rails.root.join('public', 'CSV', 'products.csv')
  end

  def upload
    rejected_products = Product.from_csv(params[:upload])
    if rejected_products.any?
      flash[:error] = 'Processing of one or more products failed'
    else
      flash[:info] = 'Processing succeeded!'
    end
    redirect_to action: 'view'
  end

  def edit
    if params[:id]
      begin
        @product = Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = 'Product not found, did you input the ID yourself?'
        redirect_to :action => 'view'
      end
    else
      redirect_to :action => 'new'
    end
  end

  def delete
    begin
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'User not found'
      redirect_to :action => 'view'
    end
    @product.destroy!
    flash[:alert] = 'Product deleted successfully'
    redirect_to :action => 'view'
  end

  def new
    @product = Product.new()
  end

  def process_new
    @product = Product.new(product_params)
    if @product.save()
      flash[:alert] = 'Product added successfully!'
      redirect_to :action => 'view'
    else
      render :action => 'new'
    end
  end

  def process_edit
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:alert] = 'Product updated successfully'
      redirect_to :action => 'view'
    else
      flash[:error] = 'Edit was unsuccessful'
      render :action => 'edit'
    end
  end

  def product_params
    params.require(:product).permit(:name, :imdb_id, :product_type_id, :age_rating, :star_rating, :synopsis)
  end
end
