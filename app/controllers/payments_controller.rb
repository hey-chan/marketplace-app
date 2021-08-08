class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  
  def success
    @title = params[:title]
  end

  def create_payment_intent
    listing = Listing.find(params[:id])
    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      customer_email: current_user&.email,
      line_items: [{
        name: listing.title, 
        description: listing.description,
        amount: listing.price, 
        currency: 'aud',
        quantity: 1
      }], 
      payment_intent_data: {
        metadata: {
          user_id: current_user&.id,
          listing_id: listing.id
        }
      },
      success_url: "#{root_url}/success?title=#{listing.title}",
      cancel_url: "#{root_url}/listings"
    )

    @session_id = session.id
 
  end

  def webhook
   payment_id = params[:data][:object][:payment_intent]
   payment = Stripe::PaymentIntent.retrieve(payment_id)
   pp payment
   listing_id = payment.metadata.listing_id
   buyer_id = payment.metadata.user_id
   Listing.find(listing_id).update(sold: :true)
  end
end
