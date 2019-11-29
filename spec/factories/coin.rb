FactoryBot.define do

  factory :bitcoin, class: "Coin" do
    name {"Bitcoin"}
    symbol {"BTC"}
    price {10_000}
  end
end
