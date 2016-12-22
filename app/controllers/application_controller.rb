class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :rescue404
   rescue_from ActionController::RoutingError, :with => :rescue404

     def rescue404
         redirect_to('/404.html') 
     end
end
