class ApplicationController < ActionController::Base
    before_action :set_conversion_rates

    def set_conversion_rates
        cache = "/tmp/exchange_rates.xml"
        @eu_bank = EuCentralBank.new
        Money.default_bank = @eu_bank

        if !@eu_bank.rates_updated_at || @eu_bank.rates_updated_at < Time.now - 1.days
            @eu_bank.save_rates(cache)
            @eu_bank.update_rates(cache)
            flash[:notice] = "Money has been saved to cache"
        end
    # require "pry" ; binding.pry
    end   
    
end