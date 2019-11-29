require 'rails_helper'

RSpec.describe DonationPayment, type: :model do


  let!(:deposit_address) { "tb1q3vn3eqtcdqfdx397npfwgct7ktp472jqmlxpmg" }
  let!(:bitcoin) { FactoryBot.create :bitcoin }
  let!(:payment_address) { PaymentAddress.create coin: bitcoin, address: deposit_address}
  let!(:streamer) { FactoryBot.create :streamer }
  let!(:donation) { FactoryBot.create :donation, streamer: streamer}
  let!(:tx_id) { "ab00657ab9da484ff235add84f7db7820f32c3fe97d308b67da3df89165c529d" }
  let!(:incoming_transaction) {FactoryBot.create(:incoming_transaction, coin: bitcoin)}

  let(:subject) { incoming_transaction.donation_payment}


  describe "confirmation" do
    it "is detected by default" do
      expect(subject).to be_detected
    end

    it "can be cofirmed" do
      subject.block = 1337
      subject.confirmed_at = Time.now
      subject.confirm!
    end

    it "can't confirm without confirmed_at" do
      subject.block = 1337
      expect{ subject.confirm! }.to raise_error(StateMachines::InvalidTransition)
      expect(subject).to_not be_confirmed
      expect(subject).to be_detected
    end

    it "can't confirm without block" do
      subject.confirmed_at = Time.now
      expect{ subject.confirm! }.to raise_error(StateMachines::InvalidTransition)
      expect(subject).to_not be_confirmed
      expect(subject).to be_detected
    end

    describe "callbacks" do
      before do
        subject.block = 1337
        subject.confirmed_at = Time.now
      end

      it "calls for confirmation_callback" do
        expect(subject).to receive(:confirmation_callback).once
        subject.confirm!
      end

      it "calls for confirmation_callback" do
        expect(subject).to receive(:create_ledger_entry!).once
        subject.confirm!
      end

      it "calls for confirmation_callback" do
        expect(subject).to receive(:mark_donation_as_paid!).once
        subject.confirm!
      end

      it "sets the donation to :paid" do
        subject.confirm!
        expect(donation.reload).to be_paid
      end
    end
  end
end
