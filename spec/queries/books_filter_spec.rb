require 'rails_helper'

RSpec.describe BooksFilter do
  subject { BooksFilter.new(params: {}) }

  context 'filter matched' do
    %w[newest popular low_to_high_price high_to_low_price title_a_z title_z_a].each do |method|
      it "calls #{method} when receive params is '#{method}'" do
        subject.instance_variable_set(:@params, filter: method)
        expect(subject).to receive(method)
        subject.call
      end
    end
  end

  context 'no matches' do
    it 'calls #newest' do
      subject.instance_variable_set(:@params, filter: 'invalid')
      expect(subject).to receive(:newest)
      subject.call
    end
  end
end
