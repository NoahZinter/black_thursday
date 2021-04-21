require './data/item_mocks'
require './data/merchant_mocks'
require './data/invoice_mocks'
require './data/invoice_item_mocks'
require './data/transaction_mocks'
require './lib/sales_analyst'
require './lib/sales_engine'
require './spec/sales_analyst_mocks'

RSpec.describe SalesAnalyst do

  describe '#merchants_with_only_one_item' do
    it 'returns a list of merchants with only 1 item' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      merchant1 = sales_analyst.merchant_repo.find_by_id(4)
      merchant2 = sales_analyst.merchant_repo.find_by_id(5)

      expected = [merchant1, merchant2]

      actual = sales_analyst.merchants_with_only_one_item
      expect(actual).to eq expected
    end
  end

  describe '#top_days_by_invoice_count' do
    it 'fails because there are no tests for it' do
      fail
    end
  end

  describe '#merchants_registered_for_month' do
    it 'fails because there are no tests for it' do
      fail
    end
  end

  describe '#merchants_with_only_one_item' do
    it 'fails because there are no tests for it' do
      fail
    end
  end

  describe '#merchants_with_only_one_item_registered_in_month' do
    it 'returns a list of merchants with only 1 item registered in given month' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      merchant1 = sales_analyst.merchant_repo.find_by_id(4)
      merchant2 = sales_analyst.merchant_repo.find_by_id(5)

      expected = [merchant1, merchant2]

      actual = sales_analyst.merchants_with_only_one_item_registered_in_month('July')
      expect(actual).to eq expected
    end
  end

  describe '#num_of_items_per_merchant' do
    it 'returns a hash with each merchant as key and number of items as value' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)

      sales_engine = sales_analyst.sales_engine
      merchants_as_mocks = sales_engine.merchants.all

      expected_hash = {
        merchants_as_mocks[0] => 3,
        merchants_as_mocks[1] => 7,
        merchants_as_mocks[2] => 4,
        merchants_as_mocks[3] => 12,
        merchants_as_mocks[4] => 0,
        merchants_as_mocks[5] => 0,
        merchants_as_mocks[6] => 0,
        merchants_as_mocks[7] => 0,
        merchants_as_mocks[8] => 0,
        merchants_as_mocks[9] => 0
      }

      actual = sales_analyst.num_of_items_per_merchant


      expect(actual).to be_a Hash
      expect(actual).to eq expected_hash
    end
  end

  describe '#average_items_per_merchant' do
    it 'averages the items per merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      expected_average = 2.6
      actual_average = sales_analyst.average_items_per_merchant

      expect(actual_average).to eq expected_average
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'calculates standard deviation for average items per merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      expected_deviation = (Math.sqrt((((3 - 2.6)**2) + ((7 - 2.6)**2) + ((4 - 2.6)**2) + ((12 - 2.6)**2) + (40.56)) / 9.0)).round(2)
      actual_deviation = sales_analyst.average_items_per_merchant_standard_deviation

      expect(actual_deviation).to eq expected_deviation
    end
  end

  describe '#standard_deviations_of_mean' do
    it 'calculates the n standard deviation of the mean of items per merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      std_dev = (Math.sqrt((((3 - 2.6)**2) + ((7 - 2.6)**2) + ((4 - 2.6)**2) + ((12 - 2.6)**2) + (40.56)) / 9.0)).round(2)
      mean = 6.5
      expected_range = mean + std_dev
      actual_range = sales_analyst.standard_deviations_of_mean(mean, std_dev)

      expect(actual_range).to eq expected_range
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns the merchants with a high number of items that are more than 1 std dev above of the mean' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      merchant_ids = [1, 3]
      actual_merchants = sales_analyst.merchants_with_high_item_count

      actual_merchants.each do |merchant|
        expect(merchant_ids.include?(merchant.id)).to eq true
      end
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'gets the average price for the given merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      sum_for_test = SalesAnalystMocks.price_sums_for_each_merchant[3]
      actual_average = sales_analyst.average_item_price_for_merchant(3)
      expected_average = sum_for_test / 12.0

      expect(actual_average).to eq (expected_average).round(2)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'get the average of all the averages for each merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      allow(sales_analyst).to receive(:average_item_price_for_merchant) { 50.0 }
      sum_of_averages = 200.0

      actual_avg_of_averages = sales_analyst.average_average_price_per_merchant
      expected_avg_of_averages = sum_of_averages / 10.0

      expect(actual_avg_of_averages).to eq expected_avg_of_averages
    end
  end

  describe '#golden_items' do
    it 'returns all items 2+ std deviations above the mean price' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)

      actual_items = sales_analyst.golden_items

      expect(actual_items.length).to eq 3
    end
  end

  describe '#all_invoices' do
    it 'returns all invoices' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)

      expect(sales_analyst.all_invoices.length).to eq 36
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'returns the average number of invoices per merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)

      expect(sales_analyst.average_invoices_per_merchant). to eq 3.6
    end
  end

  describe 'num_of_invoices_per_merchant' do
    it 'returns a hash with merchants as keys and invoices as values' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)

      sales_engine = sales_analyst.sales_engine
      merchants_as_mocks = sales_engine.merchants.all

      expected_hash = {
        merchants_as_mocks[0] => 1,
        merchants_as_mocks[1] => 2,
        merchants_as_mocks[2] => 3,
        merchants_as_mocks[3] => 3,
        merchants_as_mocks[4] => 3,
        merchants_as_mocks[5] => 3,
        merchants_as_mocks[6] => 3,
        merchants_as_mocks[7] => 3,
        merchants_as_mocks[8] => 3,
        merchants_as_mocks[9] => 12
      }

      actual = sales_analyst.num_of_invoices_per_merchant

      expect(actual).to be_a Hash
      expect(actual).to eq expected_hash
    end
  end

  describe '#average_invoices_per_merchant_standard_deviation' do
    it 'returns the standard deviation of invoices per merchant' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      expected_deviation = (Math.sqrt((((1 - 3.6)**2) + ((2 - 3.6)**2) + ((3 - 3.6)**2)+ ((3 - 3.6)**2)+ ((3 - 3.6)**2)+
      ((3 - 3.6)**2)+ ((3 - 3.6)**2)+ ((3 - 3.6)**2)+ ((3 - 3.6)**2) + ((12 - 3.6)**2)) / 9.0)).round(2)
      actual_deviation = sales_analyst.average_invoices_per_merchant_standard_deviation

      expect(expected_deviation).to eq actual_deviation
    end
  end

  describe '#top_merchants_by_invoice_count' do
    it 'returns an array of merchants two StDevs above mean' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      merchant_ids = [9]
      actual_merchants = sales_analyst.top_merchants_by_invoice_count

      actual_merchants.each do |merchant|
        expect(merchant_ids.include?(merchant.id)).to eq true
      end
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'returns an array of merchants two StDevs above mean' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      merchant_ids = [0]
      actual_merchants = sales_analyst.bottom_merchants_by_invoice_count

      actual_merchants.each do |merchant|
        expect(merchant_ids.include?(merchant.id)).to eq true
      end
    end
  end

  describe '#invoice_paid_in_full?' do
    it 'returns true if the Invoice with specified id is PIF' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      t_repo = sales_analyst.sales_engine.transactions
      allow(t_repo).to receive(:any_success?).and_return(true)
      invoice = sales_analyst.all_invoices.first

      expect(sales_analyst.invoice_paid_in_full?(invoice.id)).to eq true
    end

    it 'returns false if the Invoice with specified id has no successful transaction' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      t_repo = sales_analyst.sales_engine.transactions
      allow(t_repo).to receive(:any_success?).and_return(false)
      invoice = sales_analyst.all_invoices.last

      expect(sales_analyst.invoice_paid_in_full?(invoice.id)).to eq false
    end
  end

  describe '#invoice_created_at_by_weekday' do
    it 'returns an array of weekdays corresponding to day created' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)

      expect(sales_analyst.invoice_created_at_by_weekday.first).to eq 'Saturday'
      expect(sales_analyst.invoice_created_at_by_weekday).is_a? Array
    end
  end

  describe '#invoice_total' do
    it 'returns the $ amount of the Invoice with specified id' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      allow(sales_analyst).to receive(:invoice_paid_in_full?) { true }
      ii_repo = sales_analyst.sales_engine.invoice_items
      allow(ii_repo).to receive(:total_for_invoice) { 80.00 }

      expect(sales_analyst.invoice_total(0)).to eq 80.00
    end
  end

  describe '#total_revenue_by_date' do
    it 'returns the total revenue for a given date' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      allow(sales_analyst).to receive(:invoice_paid_in_full?) { true }
      invoice = sales_analyst.all_invoices.first
      allow(invoice).to receive(:created_at) { Time.parse('2020-10-20') }
      invoice_items = sales_analyst.all_invoice_items
      invoice_items.each do |invoice_item|
        allow(invoice_item).to receive(:total) { 20.00 }
      end
      date = Time.parse('2020-10-20')

      expect(sales_analyst.total_revenue_by_date(date)).to eq 80.00
    end
  end

  describe '#invoices_by_merchant' do
    it 'returns a hash with merchants as values and invoice lists as keys' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      invoices = sales_analyst.all_invoices
      merchants = sales_analyst.all_merchants
      expected_hash = merchants.reduce({}) do|hash, merchant|
        hash[merchant] = invoices.find_all {|invoice| invoice.merchant_id == merchant.id}
        hash
      end
      allow(merchants).to receive(:reduce).and_return(expected_hash)

      expect(sales_analyst.invoices_by_merchant).to eq expected_hash
    end
  end

  describe '#revenue by merchant' do
    it 'returns a hash of merchants sorted by revenue with revenue as values' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      merchants = sales_analyst.all_merchants
      allow(sales_analyst).to receive(:invoices_by_merchant).and_return({})
      revenue_hash = {
        merchants[0] => 10.0,
        merchants[1] => 50.0,
        merchants[2] => 120.0
     }
      allow_any_instance_of(Hash).to receive(:transform_values).and_return(revenue_hash)

      expect(sales_analyst.revenue_by_merchant).to eq revenue_hash
    end
  end

  describe '#top_revenue_earners' do
    it 'returns top x merchants by revenue' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      invoices = sales_analyst.all_invoices
      merchants = sales_analyst.all_merchants
      expected_hash = merchants.reduce({}) do|hash, merchant|
        hash[merchant] = invoices.find_all {|invoice| invoice.merchant_id == merchant.id}
        hash
      end


      allow(merchants).to receive(:reduce).and_return(expected_hash)
      revenue_hash = {
        merchants[0] => 10.0,
        merchants[1]=> 20.0,
        merchants[2]=> 30.0,
        merchants[3]=> 30.0,
        merchants[4]=> 30.0,
        merchants[5]=> 30.0,
        merchants[6]=> 30.0,
        merchants[7]=> 30.0,
        merchants[8]=> 50.0,
        merchants[9]=> 120.0
     }
      allow_any_instance_of(Hash).to receive(:transform_values).and_return(revenue_hash)

      expect(sales_analyst.top_revenue_earners(2).length).to eq 2
    end
  end

  describe '#merchants_with_pending_invoices' do
    it 'returns a list of merchants with pending invoices' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      invoices = sales_analyst.all_invoices
      allow(sales_analyst).to receive(:invoice_paid_in_full?).and_return(false)

      expect(sales_analyst.merchants_with_pending_invoices.length).to eq 10
    end

    it 'returns a list of merchants with pending invoices' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      invoices = sales_analyst.all_invoices
      allow(sales_analyst).to receive(:invoice_paid_in_full?).and_return(true)


      expect(sales_analyst.merchants_with_pending_invoices.length).to eq 0
    end

    it 'returns a list of merchants with pending invoices' do
      sales_analyst = SalesAnalystMocks.sales_analyst_mock(self)
      allow(sales_analyst).to receive(:invoice_paid_in_full?).and_return(false, true)

      expect(sales_analyst.merchants_with_pending_invoices.length).to eq 1
    end
  end
end
