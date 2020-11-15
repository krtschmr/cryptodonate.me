require 'money/bank/open_exchange_rates_bank'
$oxr = Money::Bank::OpenExchangeRatesBank.new
$oxr.cache = 'rates.json'
$oxr.app_id = ENV["OPENEXCHANGERATES_API_KEY"]
$oxr.ttl_in_seconds = 86400
# $oxr.refresh_rates
$oxr.update_rates
Money.default_bank = $oxr
Money.locale_backend = :i18n