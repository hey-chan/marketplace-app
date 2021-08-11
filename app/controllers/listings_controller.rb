class ListingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :authorise_user, only: [:edit, :update, :destroy]
  before_action :set_form_vars, only: [:new, :edit]
  before_action :set_platforms, only: [:new, :edit]

  # GET /listings or /listings.json
  def index
    @q = Listing.ransack(params[:q])
    @listings = @q.result


    # Sort feature: will focus on another time
    # if params[:order]== "Price(high-low)"
    #   @listings = Listing.order(price: :desc) if params[:order]== "Price(high-low)"
    # elsif params[:order] == "Price(low-high)"
    #   @listings = Listing.order(price: :asc) 
    # else
    #   @listings = Listing.all
    # end
   

  end

  # GET /listings/1 or /listings/1.json
  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      customer_email: current_user&.email,
      line_items: [{
        name: @listing.title, 
        description: @listing.description,
        amount: @listing.price, 
        currency: 'aud',
        quantity: 1
      }], 
      payment_intent_data: {
        metadata: {
          user_id: current_user&.id,
          listing_id: @listing.id
        }
      },
      success_url: "#{root_url}/success?title=#{@listing.title}",
      cancel_url: "#{root_url}/listings"
    )

    @session_id = session.id
    puts "**********"
    pp @session_id
    puts "**********"
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = current_user.listings.new(listing_params)
    @listing.user_id = current_user.id

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        set_form_vars
        set_platforms
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        set_form_vars
        set_platforms
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Redundant: replaced by Cancancan gem
    # def set_user_listing
    #   @listing = current_user.listings.find_by_id(params[:id])
    #   if @listing == nil
    #     flash[:error] = "You are not authorised to do that"
    #     redirect_to listings_path
    #   end
    # end
    # def admin_require
    #   @user = "admin"
    # end

    # def authorise_user
    #   if current_user.id != @listing.user_id
    #     flash[:error] = "You are not authorised to do that"
    #     redirect_to listings_path
    #   end
    # end

    
    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:user_id, :category_id, :platform_id, :title, :condition, :price, :description, :sold, :picture)
    end

    def set_form_vars
      @categories = Category.all
      @conditions = Listing.conditions.keys
    end
    
    def set_platforms
      @platforms = Platform.all
    end


end
