class SiteController < ApplicationController
    before_action :set_user
    before_action :set_conversion_rates, only: [:exchange]
        
    def index 
        # @currencies_all = all_currencies(Money::Currency.table)
        # @currencies_major = major_currencies(Money::Currency.table)
        xml_to_hash
        
    end

    def exchange
            unless params[:enter_value].empty? || params[:convert_to].empty? || params[:convert_from].empty?
                @result = @eu_bank.exchange_with(Money.from_amount(params[:enter_value].to_i, params[:convert_from]), params[:convert_to])
                respond_to do |format| 
                    format.html {}
                    format.turbo_stream { render 'site/result', locals: {result: @result} }     
                end
            else
                xml_to_hash
                flash.now[:alert] = "Something went wrong. Please fill and try again."
                render 'site/index', status: :unprocessable_entity
            end

    end

    private
    
# Returns an array of currency id where
# priority < 10
    def major_currencies(hash)
        hash.inject([]) do |array, (id, attributes)|
        priority = attributes[:priority]
        if priority && priority < 10
            array[priority] ||= []
            array[priority] << id.upcase #attributes[:name]
        end
        array
        end.compact.flatten
    end

# Returns an array of all currency id
    def all_currencies(hash)
        # hash.map {|keys, values| "#{values[:name]} (#{keys})"}
        hash.keys.upecase
    end

    def set_conversion_rates
        begin
            cache = File.new("/tmp/exchange_rates.xml", "w")  
            @eu_bank = EuCentralBank.new
            Money.default_bank = @eu_bank

        if !@eu_bank.rates_updated_at || @eu_bank.rates_updated_at < Time.now - 1.days
            @eu_bank.save_rates(cache)
            @eu_bank.update_rates(cache)
            #require 'pry' ; binding.pry
        end
        rescue => exception
            flash.now[:alert] = exception
            render "welcome/index"
        end
    end 
    
    # gem install "net-ping"
    # require "net/ping"
    # def internet_connection?
    #   Net::Ping::External.new("8.8.8.8").ping?
    # end

    def xml_to_hash
        data = File.open("/tmp/exchange_rates.xml")
        hash = Hash.from_xml(data)
        filtered_hash = hash.dig("Envelope","Cube","Cube","Cube")
        res = []
        filtered_hash.each do |item|
                res << item.values
                res << ["EUR", "1"]
        end
        hashed_res = res.to_h
        @bnk_vld_crr = hashed_res.keys
    end

    def set_user 
        unless signed_in?
            redirect_to root_path, alert: "You must login first." 
        end
    end
end