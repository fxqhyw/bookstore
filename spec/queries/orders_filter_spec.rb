require 'rails_helper'

RSpec.describe OrdersFilter do
  subject { OrdersFilter.new(params: {}, orders: nil) }

  context 'filter matched' do
    %w[in_queue in_delivery delivered].each do |method|
      it "calls #{method} when receive params is '#{method}'" do
        subject.instance_variable_set(:@params, filter: method)
        expect(subject).to receive(method)
        subject.call
      end
    end
  end

  context 'no matches' do
    it 'returns orders' do
      subject.instance_variable_set(:@params, filter: 'invalid')
      orders = double('Order')
      subject.instance_variable_set(:@orders, orders)
      expect(subject.call).to eq(orders)
    end
  end
end
