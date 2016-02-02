require 'spec_helper'

describe Order, :type => :model do
  describe 'associations' do
    it { is_expected.to have_many(:order_line_items) }
    it { is_expected.to belong_to(:customer) }
  end

  describe 'attributes' do
    it { is_expected.to allow_mass_assignment_of :order_number }
    it { is_expected.to allow_mass_assignment_of :date }
    it { is_expected.to allow_mass_assignment_of :discount }
    it { is_expected.to allow_mass_assignment_of :deliver_date }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :customer_id }
    it { is_expected.to validate_presence_of :order_number }
    it { is_expected.to validate_presence_of :date }
    it { is_expected.to validate_numericality_of(:discount).is_less_than(100).only_integer}
  end
end
