class SiteController < ApplicationController
    def index 
        # @currencies_all = all_currencies(Money::Currency.table)
        @currencies_major = major_currencies(Money::Currency.table)
        @result = 0
    end

    def exchange
        @eu_bank = EuCentralBank.new
        Money.default_bank = @eu_bank
        # # call this before calculating exchange rates
        # # this will download the rates from ECB
        @eu_bank.update_rates
        @result = @eu_bank.exchange(params[:enter_value], params[:convert_from], params[:convert_to]).cents
        # require "pry" ; binding.pry
        respond_to do |format| 
            format.html {}
            format.turbo_stream { render 'site/result', locals: {result: @result} }
        end
    end

# Returns an array of currency id where
# priority < 10

    private
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

    # def money_params
    #     params.permit(:enter_value, :convert_from, :convert_to)
    # end
end