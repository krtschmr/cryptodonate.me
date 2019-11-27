module QrHelper

  # def small_btc_qr_code(payment_address)
  #   qr = RQRCode::QRCode.new(payment_address, level: :l)
  #   url = asset_path("cryptoicons/color/btc.png")
  #   qr.as_css(size: 200, logo: url, logo_size: 32).html_safe
  # end

  def btc_qr_code(donation)
    string = "bitcoin:#{donation.payment_address}?amount=#{donation.payment_amount}"
    make_qr_code(string, :btc)
  end

  def ltc_qr_code(donation)
    string = "litecoin:#{donation.payment_address}?amount=#{donation.payment_amount}"
    make_qr_code(string, :ltc)
  end

  # def xmr_qr_code(donation)
  #   string = "monero:#{donation.payment_address}?tx_amount=#{donation.payment_amount}&tx_description=cryptodonate.me #{donation.streamer.name}"
  #   make_qr_code(string, :xmr)
  # end

  private

  def make_qr_code(string, coin)
    qr = RQRCode::QRCode.new(string, level: :l)
    url = asset_path("cryptoicons/color/#{coin}.png")
    qr.as_css(size: 250, logo: url, logo_size: 48).html_safe
  end

end
