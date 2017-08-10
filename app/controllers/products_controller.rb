class ProductsController < ApplicationController
  #before_filter :authorize
  before_action :set_product, only: [:show, :edit, :update, :destroy, :buy]


  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @review = Review.new
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def buy
    @purchase = current_user.purchased_products.build(product: @product)
    if @purchase.save
      redirect_to @product, notice: 'Product was successfully purchased.'
    else
      redirect_back(fallback_location: root_path)
    end
  end


  def cart
    @products = []
    @total = 0;
    @purchases = current_user.purchased_products
    @purchases.each do |purchase|
      @products << Product.find(purchase.product_id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name,:image,:description, :price_in_cents)
    end
end
