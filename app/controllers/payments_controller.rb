class PaymentsController < ApplicationController
  layout 'publisher'
  def index
    @sites = Publishersite.where(created_by: session[:user_id])
  end
end
