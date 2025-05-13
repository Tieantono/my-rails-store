class ProductsController < ApplicationController
  # %i is a shorthand for creating an array of symbols.
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    # Error handling when trying to save the product into the database.
    if @product.save
      # This will generate a path to the newly created product's show page.
      redirect_to @product
    else
      # This will render the new product form again with error messages.
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private
    def set_product
      # params is a hash-like object that contains the request parameters.
      @product = Product.find(params[:id])
    end

    # Validate the product params from the request.
    def product_params
      params.expect(product: [ :name, :description, :featured_image ])
    end
end
