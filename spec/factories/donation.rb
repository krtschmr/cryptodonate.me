FactoryBot.define do

  factory :donation, class: "Donation" do
    streamer { FactoryBot.create :streamer}
    name {"TestFan"}
    message {"Thanks"}
  end
end
