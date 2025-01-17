require 'csv'
require_relative './customer'
require_relative './customer_repository'
require_relative './file_io'
require_relative './invoice'
require_relative './invoice_repository'
require_relative './invoice_item'
require_relative './invoice_item_repository'
require_relative './item'
require_relative './item_repository'
require_relative './merchant'
require_relative './merchant_repository'
require_relative './sales_analyst'
require_relative './transaction'
require_relative './transaction_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :invoice_items,
              :customers,
              :analyst

  def initialize(files)
    @invoices = InvoiceRepository.new(files[:invoices])
    @items = ItemRepository.new(files[:items])
    @merchants = MerchantRepository.new(files[:merchants])
    @transactions = TransactionRepository.new(files[:transactions])
    @invoice_items = InvoiceItemRepository.new(files[:invoice_items])
    @customers = CustomerRepository.new(files[:customers])
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(files)
    instance = SalesEngine.new(files)
  end

  def all_items
    @items.all
  end

  def all_merchants
    @merchants.all
  end

  def all_invoices
    @invoices.all
  end

  def all_transactions
    @transactions.all
  end

  def all_invoice_items
    @invoice_items.all
  end

  def all_customers
    @customers.all
  end
end
