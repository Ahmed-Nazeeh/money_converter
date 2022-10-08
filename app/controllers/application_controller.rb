class ApplicationController < ActionController::Base

    # before_action :internet_connection?

    # require "net/ping"
    # def internet_connection?
    #   if Net::Ping::External.new("8.8.8.8").ping?
    #     flash[:notice] = "Internet connection available"
    #   else
    #     flash[:alert] = "Please, Log on iternet first."
    
    #   end
    # end
end