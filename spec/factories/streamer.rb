FactoryBot.define do

  factory :streamer, class: "Streamer" do
    provider { :twitch }
    uid {1337}
    donation_url {"timvanmonero"}
    name {"timvanmonero"}
    email {"tim@vanmone.ro"}
    url {"timvanmonero"}
    token {"1234"}
    refresh_token {"1234"}
  end
end
