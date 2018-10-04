require 'rails_helper'

RSpec.describe OrderDecorator do
  let(:order_in_queue) { create(:order, :in_queue).decorate }
  let(:order_in_delivery) { create(:order, :in_delivery).decorate }
  let(:order_delivered) { create(:order, :delivered).decorate }

  describe '#status_string' do
    context 'status is in_queue' do
      it do
        expect(order_in_queue.status_string).to eq(I18n.t('orders.in_queue'))
      end
    end

    context 'status is in_delivery' do
      it do
        expect(order_in_delivery.status_string).to eq(I18n.t('orders.in_delivery'))
      end
    end

    context 'status is delivered' do
      it do
        expect(order_delivered.status_string).to eq(I18n.t('orders.delivered'))
      end
    end
  end
end
