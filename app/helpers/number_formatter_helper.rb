module NumberFormatterHelper

  # <balance title="1234.56 EUR" amount="1234.56", currency="EUR">
  #   1234.56
  #   <currency>EUR</currency>
  # </balance>
  #
  # <balance amount="0.05789", currency="BTC">
  #   0.05789
  #   <zeros>000</zeros>
  #   <currency>BTC</currency>
  # </balance>
  # # Javascript is coming and convert to localstring

  def formatted_zeros(z)
    if z > 0
      content_tag(:zeros) do
        Array.new(z){0}.join
      end
    end
  end

  def calculate_zeros(str)
    decimals = str.split(".").last
    8 - decimals.length
  end

  def formatted(amount, coin, options={})
    amount = 0 unless amount
    coin = Coin.find_by(symbol: coin) unless coin.is_a?(Coin)

    if coin.symbol == "EUR" && !options[:fill_euro] && !options[:strip_to_zero]
      # truncate after 2 decimals, force 2 decimals
      formatted_amount = number_with_precision(amount.truncate(2), precision: 2)
      zeros = 0
    else
      formatted_amount = amount.to_d.to_s
      zeros = calculate_zeros(formatted_amount)
    end

    if options[:strip_to_zero]
      zeros = 0
    end

    content_tag(:balance, class: "#{coin.symbol.downcase}", title: "#{amount} #{coin.symbol}", amount: formatted_amount, currency: coin.symbol) do
      concat(content_tag(:value, formatted_amount))
      concat(formatted_zeros(zeros))
      concat(content_tag(:currency, coin.symbol))
    end
  end


end
