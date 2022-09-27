class SiteController < ApplicationController
    def index 
        @currencies_all = all_currencies(Money::Currency.table)
        @currencies_major = major_currencies(Money::Currency.table)
        # @currency = Money.from_cents(1000, "aed").currency.name
        # @find_currency = Money::Currency.find_by_iso_numeric(978)


        # @eu_bank = EuCentralBank.new
        # Money.default_bank = @eu_bank
        # # call this before calculating exchange rates
        # # this will download the rates from ECB
        # @eu_bank.update_rates

    end
    
    def exchange

    end
# Returns an array of currency id where
# priority < 10

private
    def major_currencies(hash)
        hash.inject([]) do |array, (id, attributes)|
        priority = attributes[:priority]
        if priority && priority < 10
            array[priority] ||= []
            array[priority] << id #attributes[:name]
        end
        array
        end.compact.flatten
    end
# Returns an array of all currency id
    def all_currencies(hash)
        # hash.map {|keys, values| "#{values[:name]} (#{keys})"}
        hash.keys
    end
end