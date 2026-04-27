require 'rails_helper'


RSpec.describe Qr, type: :service do

  let(:asset) { create(:asset) }

  describe '.call' do
    it 'vygeneruje platný SVG řetězec' do
      result = Qr.call(asset)
      expect(result).to include('<svg')
      expect(result).to include('xmlns="http://www.w3.org/2000/svg"')
    end

    it 'nevrací prázdný výsledek' do
      result = Qr.call(asset)
      expect(result).not_to be_nil
    end
  end
end