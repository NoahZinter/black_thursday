require 'rspec'
require './data/mock_data'

describe MockData do

  describe '#invoice_items_as_hashes' do
    it 'returns mock data of invoice_items' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes

      expect(invoice_items_as_hashes).to be_an Array
      expect(invoice_items_as_hashes.length).to eq 10
      expect(invoice_items_as_hashes.first).to be_a Hash
    end
    it 'has expected attributes' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes
      invoice_item_hash = invoice_items_as_hashes.first
      expect(invoice_item_hash[:id]).to be_an Integer
      expect(invoice_item_hash[:item_id]).to be_an Integer
      expect(invoice_item_hash[:invoice_id]).to be_an Integer
      expect(invoice_item_hash[:quantity]).to be_an Integer
      expect(invoice_item_hash[:unit_price]).to be_an Float
      expect(invoice_item_hash[:created_at]).to match MockData.date_format
      expect(invoice_item_hash[:updated_at]).to match MockData.date_format
    end
    it 'allows different number of hashes' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(number_of_hashes:2)

      expect(invoice_items_as_hashes).to be_an Array
      expect(invoice_items_as_hashes.length).to eq 2
      expect(invoice_items_as_hashes.first).to be_a Hash
    end
    it 'allows non-random dates' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(random_dates:false)

      invoice_items_as_hashes.each do |hash|
        expect(hash[:created_at]).to eq '2019-12-01'
      end
    end
    it 'allows custom quantities' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(quantity:5)

      invoice_items_as_hashes.each do |hash|
        expect(hash[:quantity]).to eq 5
      end
    end
    it 'allows ranges for item ids' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(item_id_range: (1..1))
      first_invoice_item = invoice_items_as_hashes.first
      second_invoice_item = invoice_items_as_hashes.last

      invoice_items_as_hashes.each do |hash|
        expect(hash[:item_id]).to eq 1
      end
    end
    it 'allows ranges for invoice ids' do
      invoice_items_as_hashes = MockData.invoice_items_as_hashes(invoice_id_range: (1..1))

      invoice_items_as_hashes.each do |hash|
        expect(hash[:invoice_id]).to eq 1
      end
    end
  end

  describe '#invoices_as_mocks' do
    it 'returns mocks of invoices' do
      invoice_items_as_mocks = MockData.invoice_items_as_mocks(self)
      invoice_item_mock = invoice_items_as_mocks.first
      expect(invoice_item_mock.id).to be_an Integer
      expect(invoice_item_mock.item_id).to be_an Integer
      expect(invoice_item_mock.invoice_id).to be_an Integer
      expect(invoice_item_mock.quantity).to be_an Integer
      expect(invoice_item_mock.unit_price).to be_an Float
      expect(invoice_item_mock.created_at).to match MockData.date_format
      expect(invoice_item_mock.updated_at).to match MockData.date_format
    end
  end

  describe '#invoices_as_hashes' do
    it 'returns mock data of invoices' do
      invoices_as_hashes = MockData.invoices_as_hashes

      expect(invoices_as_hashes).to be_an Array
      expect(invoices_as_hashes.length).to eq 10
      expect(invoices_as_hashes.first).to be_a Hash
    end

    it 'returns mock custom number of data of invoices' do
      invoices_as_hashes = MockData.invoices_as_hashes(number_of_hashes: 2)
      expect(invoices_as_hashes.length).to eq 2
    end

    it 'returns mocks with custom status' do
      invoices_as_hashes = MockData.invoices_as_hashes(status: 'pending')

      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:status]).to eq 'pending'
      end
    end

    it 'returns mocks with non-random ids' do
      invoices_as_hashes = MockData.invoices_as_hashes(customer_id_range: (1..1),
                                                       merchant_id_range: (5..5))

      invoices_as_hashes.each do |invoice_hash|
        expect(invoice_hash[:customer_id]).to eq 1
        expect(invoice_hash[:merchant_id]).to eq 5
      end
    end

    it 'generates expected attributes' do
      invoices_as_hashes = MockData.invoices_as_hashes
      invoice_hash = invoices_as_hashes.first
      expect(invoice_hash[:id]).to eq 0
      expect(invoice_hash[:customer_id]).to be_an Integer
      expect(invoice_hash[:merchant_id]).to be_an Integer
      expect(invoice_hash[:created_at]).to match MockData.date_format
      expect(invoice_hash[:updated_at]).to match MockData.date_format
    end
  end

  describe '#invoices_as_mocks' do
    it 'returns mock data of invoices' do
      invoices_as_mocks = MockData.invoices_as_mocks(self)
      mocked_invoice = invoices_as_mocks.first

      expect(invoices_as_mocks.length).to eq 10
      expect(mocked_invoice.id).to eq 0
      expect(mocked_invoice.merchant_id).to be_an Integer
      expect(mocked_invoice.customer_id).to be_an Integer
      expect(mocked_invoice.created_at).to match MockData.date_format
      expect(mocked_invoice.updated_at).to match MockData.date_format
    end
    it 'accepts custom hashes' do
      invoices_as_hashes = MockData.invoices_as_hashes(number_of_hashes:2)
      invoices_as_mocks = MockData.invoices_as_mocks(self, invoices_as_hashes)
      expect(invoices_as_mocks.length).to eq 2
    end
  end

  describe '#merchants_as_mocks' do
    it 'returns mocks of merchants' do
      merchants_as_mocks = MockData.merchants_as_mocks(self)
      mocked_merchant = merchants_as_mocks.first

      expect(merchants_as_mocks).to be_instance_of Array
      expect(merchants_as_mocks.length).to eq 10
      expect(mocked_merchant.name).to eq 'Merchant 0'
      expect(mocked_merchant.id).to eq 0
      expect(mocked_merchant.created_at).to match MockData.date_format
      expect(mocked_merchant.updated_at).to match MockData.date_format
    end
    it 'accepts custom hashes' do
      merchants_as_hashes = MockData.merchants_as_hashes(number_of_hashes:2)
      merchants_as_mocks = MockData.merchants_as_mocks(self, merchants_as_hashes)
      expect(merchants_as_mocks.length).to eq 2
    end
  end

  describe '#mechants_as_hashes' do
    it 'returns mock data as an array of hashes' do
      merchants_as_hashes = MockData.merchants_as_hashes

      expect(merchants_as_hashes).to be_an Array
      expect(merchants_as_hashes.length).to eq 10
      expect(merchants_as_hashes.first).to be_a Hash
    end

    it 'returns mocks of Merchant' do
      mocked_hash_data = MockData.merchants_as_hashes(number_of_hashes: 2)
      mocked_merchant = mocked_hash_data.first

      expect(mocked_hash_data.length).to eq 2
      expect(mocked_merchant[:name]).to eq 'Merchant 0'
      expect(mocked_merchant[:id]).to eq 0
      expect(mocked_merchant[:created_at]).to match MockData.date_format
      expect(mocked_merchant[:updated_at]).to match MockData.date_format
    end
  end

  describe '#items_as_mocks' do
    it 'returns mocks items with expected attributes' do
      mocks = MockData.items_as_mocks(self)
      mocked_item = mocks.first

      expect(mocks).to be_instance_of Array
      expect(mocks.length).to eq 10
      expect(mocked_item.name).to eq 'Item 0'
      expect(mocked_item.id).to eq 0
      expect(mocked_item.merchant_id).to be_an Integer
      expect(mocked_item.unit_price).to be_a Float
      expect(mocked_item.description).to eq 'Item Description'
      expect(mocked_item.created_at).to match MockData.date_format
      expect(mocked_item.updated_at).to match MockData.date_format
    end

    it 'accepts custom hashes' do
      items_as_hashes = MockData.items_as_hashes(number_of_hashes:2)
      items_as_mocks = MockData.items_as_mocks(self, items_as_hashes)
      expect(items_as_mocks.length).to eq 2
    end
  end

  describe '#items_as_hashes' do
    it 'returns mock data as an array of hashes' do
      items_as_hashes = MockData.items_as_hashes

      expect(items_as_hashes).to be_an Array
      expect(items_as_hashes.length).to eq 10
      expect(items_as_hashes.first).to be_a Hash
    end

    it 'returns mock data of items with expected attributes' do
      items_as_hashes = MockData.items_as_hashes(number_of_hashes: 2)
      first_item_hash = items_as_hashes.first
      expect(items_as_hashes.length).to eq 2
      expect(first_item_hash[:name]).to eq 'Item 0'
      expect(first_item_hash[:id]).to eq 0
      expect(first_item_hash[:merchant_id]).to be_an Integer
      expect(first_item_hash[:unit_price]).to be_a Float
      expect(first_item_hash[:description]).to eq 'Item Description'
      expect(first_item_hash[:created_at]).to match MockData.date_format
      expect(first_item_hash[:updated_at]).to match MockData.date_format
    end
    it 'returns mock data of items with given number_of_merchants' do
      items_as_hashes = MockData.items_as_hashes(number_of_hashes: 2, number_of_merchants: 1)

      expect(items_as_hashes.first[:merchant_id]).to eq 0
      expect(items_as_hashes.last[:merchant_id]).to eq 0
    end
  end

  describe '#get_a_random_price' do
    it 'generates a random price' do
      random_price = MockData.get_a_random_price
      expect(random_price).to be_a Float
    end
  end

  describe '#get_a_random_date' do
    it 'gets a random date with expected format' do
      date = MockData.get_a_random_date
      expect(date.to_s).to match MockData.date_format
    end
    it 'gets a non-random date' do
      first_date = MockData.get_a_random_date false
      second_date = MockData.get_a_random_date false
      expect(first_date.to_s).to eq second_date.to_s
    end
  end

  describe '#sum_item_prices_from_hash' do
    it 'sums prices' do
      allow(MockData).to receive(:get_a_random_price).and_return(1)
      mock_items = MockData.items_as_hashes
      expected_sum = 10
      actual_sum = MockData.sum_item_prices_from_hash(mock_items)
      expect(actual_sum).to eq expected_sum
    end
  end

  describe '#mean_of_item_prices_from_hash' do
    it 'gets the mean value of item prices' do
      allow(MockData).to receive(:get_a_random_price).and_return(5)
      allow(MockData).to receive(:sum_item_prices_from_hash).and_return(50)
      mock_items = MockData.items_as_hashes
      expected_mean = 5
      actual_mean = MockData.mean_of_item_prices_from_hash(mock_items)
      expect(actual_mean).to eq expected_mean
    end
  end

  describe '#get_a_random_status' do
    it 'returns a random status' do
      actual_status = MockData.get_a_random_status
      possible_statuses = ['pending', 'shipped', 'returned']
      expect(possible_statuses.include?(actual_status)).to be true
    end
  end

  describe '#get_a_random_quantity' do
    it 'returns a random status' do
      actual_quantity = MockData.get_a_random_quantity
      expect(actual_quantity).to be_an Integer
    end
  end
end
