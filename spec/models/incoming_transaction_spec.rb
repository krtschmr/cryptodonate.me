require 'rails_helper'

RSpec.describe IncomingTransaction, type: :model do

  let!(:deposit_address) { "tb1q3vn3eqtcdqfdx397npfwgct7ktp472jqmlxpmg" }
  let!(:bitcoin) { FactoryBot.create :bitcoin }
  let!(:payment_address) { PaymentAddress.create coin: bitcoin, address: deposit_address}
  let!(:streamer) { FactoryBot.create :streamer }
  let!(:donation) { FactoryBot.create :donation, streamer: streamer}
  let!(:tx_id) { "ab00657ab9da484ff235add84f7db7820f32c3fe97d308b67da3df89165c529d" }

  let(:subject) {FactoryBot.build(:incoming_transaction, coin: bitcoin)}

  describe "creation" do
    it "calls to assign_payment_address" do
      expect(subject).to receive(:assign_payment_address).once
      subject.valid?
    end

    it "updates the payment_address" do
      subject.valid?
      expect(subject.payment_address).to eq(payment_address)
    end

    it "creates a donation payment" do
      expect{subject.save}.to change{ DonationPayment.count }.by(1)
    end
  end

  describe "confirmation" do
    before do
      subject.save
      subject.confirmations = 1
      subject.block = 1337
    end

    it "can confirm" do
      subject.confirm!
      expect(subject).to be_confirmed
    end

    it "can't confirm with 0 confirmations" do
      subject.confirmations = 0
      expect{ subject.confirm! }.to raise_error(StateMachines::InvalidTransition)
      expect(subject).to_not be_confirmed
      expect(subject).to be_pending
    end

    it "can't confirm without block" do
      subject.block = nil
      expect{ subject.confirm! }.to raise_error(StateMachines::InvalidTransition)
      expect(subject).to_not be_confirmed
      expect(subject).to be_pending
    end

    it "touches the donation_payment" do
      expect{ subject.confirm! }.to change{ LedgerEntry.count }.by(1)
      expect(subject.donation_payment).to be_confirmed
    end
  end

end
