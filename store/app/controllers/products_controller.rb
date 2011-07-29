class ProductsController < ApplicationController
  def index
    @products = Product.order("released_at desc")
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to products_url, :notice => "Successfully created product. #{undo_link}"
    else
      render :action => 'new'
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to products_url, :notice => "Successfully updated product. #{undo_link}"
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url, :notice => "Successfully destroyed product. #{undo_link}"
  end
  
  private
  
  def undo_link
    view_context.link_to("undo", revert_version_path(@product.versions.scoped.last), :method => :post)
  end
end
