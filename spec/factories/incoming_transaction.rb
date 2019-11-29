FactoryBot.define do

  factory :incoming_transaction, class: "IncomingTransaction" do
    coin { FactoryBot.create :bitcoin }
    tx_id { "ab00657ab9da484ff235add84f7db7820f32c3fe97d308b67da3df89165c529d" }
    address { "tb1q3vn3eqtcdqfdx397npfwgct7ktp472jqmlxpmg" }
    amount { 0.01 }
    received_at { Time.now.to_i }
  end
end
