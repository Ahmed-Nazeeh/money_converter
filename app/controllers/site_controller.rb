class SiteController < ApplicationController
    def index 
        # @currencies_all = all_currencies(Money::Currency.table)
        @currencies_major = major_currencies(Money::Currency.table)
        @bnk_vld_crr = xml_to_hash
        # require 'pry' ; binding.pry
        @result = 0
    end

    def exchange
        # @eu_bank = EuCentralBank.new
        # Money.default_bank = @eu_bank
        # # # call this before calculating exchange rates
        # # # this will download the rates from ECB
        # @eu_bank.update_rates
        @result = @eu_bank.exchange_with(Money.new(params[:enter_value], params[:convert_from]), params[:convert_to]).cents
        # require "pry" ; binding.pry
        
        # @result = Money.from_cents(params[:enter_value], params[:convert_from]).exchange_to(params[:convert_to])
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

    def xml_to_hash
        data = File.open('/tmp/exchange_rates.xml')
        hash = Hash.from_xml(data)
        filtered_hash = hash.dig("Envelope","Cube","Cube","Cube")
        res = []
        filtered_hash.each do |item|
                res << item.values
        end
        hashed_res = res.to_h
        hashed_res.keys
    end
end