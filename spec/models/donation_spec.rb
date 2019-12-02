require 'rails_helper'

RSpec.describe Donation, type: :model do


  describe "confirmation" do


    let!(:deposit_address) { "tb1q3vn3eqtcdqfdx397npfwgct7ktp472jqmlxpmg" }
    let!(:bitcoin) { FactoryBot.create :bitcoin }
    let!(:payment_address) { PaymentAddress.create coin: bitcoin, address: deposit_address}
    let!(:streamer) { FactoryBot.create :streamer }
    let!(:donation) { FactoryBot.create :donation, streamer: streamer}
    let!(:tx_id) { "ab00657ab9da484ff235add84f7db7820f32c3fe97d308b67da3df89165c529d" }
    let!(:incoming_transaction) {FactoryBot.create(:incoming_transaction, coin: bitcoin)}
    let(:donation_payment) { incoming_transaction.donation_payment}

    it "recalculates the usd_value" do
      expect_any_instance_of(Donation).to receive(:recalculate_usd_value!).once
      donation_payment.update(block: 1337, confirmed_at: Time.now)
      donation_payment.confirm!
    end

    describe "notification" do
      it "will call to trigger_notification" do
        expect_any_instance_of(Donation).to receive(:trigger_notification).once
        donation_payment.update(block: 1337, confirmed_at: Time.now)
        donation_payment.confirm!
      end

      it "won't trigger because the value is below minimum" do
        allow_any_instance_of(DonationSetting).to receive(:minimum_amount_for_notification).and_return(10)
        allow_any_instance_of(Donation).to receive(:usd_value).and_return(9.99)
        expect_any_instance_of(Donation).to_not receive(:trigger_notification!)
        donation_payment.update(block: 1337, confirmed_at: Time.now)
        donation_payment.confirm!
      end
    end

    it "will mark alert_created" do
      donation_payment.update(block: 1337, confirmed_at: Time.now)
      donation_payment.confirm!
      expect(donation.reload).to be_alert_created
    end

  end



end
