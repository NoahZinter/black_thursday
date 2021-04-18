require 'rspec'
require 'csv'
require './lib/file_io'
require './lib/customer_repository'

describe CustomerRepository do
  details = {
    id: 1,
    first_name: 'Julia',
    last_name: 'Child',
    created_at: Time.now,
    updated_at: Time.now
  }
  customer_hashes = []
  10.times { customer_hashes << details }

  describe '#initialize' do
    it 'exists' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      expect(c_repo).is_a? CustomerRepository
    end

    it 'has a customers array' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      expect(c_repo.customers).is_a? Array
    end
  end

  describe '#all' do
    it 'returns an array of all customers' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      expect(c_repo.all.length).to eq 10
    end
  end

  describe '#find_by_id' do
    it 'returns a Customer with matching id' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      expected = c_repo.customers.first
      expect(c_repo.find_by_id(1)).to eq expected
    end
  end

  describe '#find_all_by_first_name' do
    it 'returns all customers with matching first name' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      expect(c_repo.find_all_by_first_name('Julia').length).to eq 10
      expect(c_repo.find_all_by_first_name('Tim')).to eq []
    end
  end

  describe '#find_all_by_last_name' do
    it 'returns all customers with matching last name' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      expect(c_repo.find_all_by_last_name('Child').length).to eq 10
      expect(c_repo.find_all_by_last_name('Lewis')).to eq []
    end
  end

  describe '#create' do
    it 'creates a new Customer instance with provided attributes' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      new_customer_attributes = {
        id: nil,
        first_name: 'Yan',
        last_name: 'Cancook',
        created_at: Time.now,
        updated_at: Time.now
      }

      c_repo.create(new_customer_attributes)

      expected = c_repo.customers.last
      expect(expected).is_a? Customer
      expect(c_repo.all.length).to eq 11
      expect(expected.first_name).to eq 'Yan'
    end
  

    it 'new customer has an id equal to max_id plus 1' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      new_customer_attributes = {
        id: nil,
        first_name: 'Yan',
        last_name: 'Cancook',
        created_at: Time.now,
        updated_at: Time.now
      }

      c_repo.create(new_customer_attributes)

      expected = c_repo.find_by_id(2)
      expect(expected.first_name).to eq 'Yan'
    end
  end

  describe '#update' do
    it 'updates the customer with corresponding id' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      new_customer_attributes = {
        id: nil,
        first_name: 'Yan',
        last_name: 'Cancook',
        created_at: Time.now,
        updated_at: Time.now
      }

      c_repo.create(new_customer_attributes)
      originial_time = c_repo.find_by_id(2).updated_at

      changed_customer_attributes = {
        first_name: 'Johnny',
        last_name: 'Greenwood',
      }

      c_repo.update(2, changed_customer_attributes)

      expected = c_repo.find_by_id(2)
      expect(expected.first_name).to eq 'Johnny'
      expect(expected.last_name).to eq 'Greenwood'
      expect(expected.updated_at).to be > originial_time
    end

    it 'does not update unknown customer' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      new_customer_attributes = {
        id: nil,
        first_name: 'Yan',
        last_name: 'Cancook',
        created_at: Time.now,
        updated_at: Time.now
      }

      c_repo.create(new_customer_attributes)

      changed_customer_attributes = {
        first_name: 'Johnny',
        last_name: 'Greenwood',
      }

      c_repo.update(1000, changed_customer_attributes)
      expected = c_repo.customers.map {|customer| customer.first_name }
      expect(expected.include?('Johnny')).to eq false
    end
  end

  describe '#delete' do
    it 'deletes customer with provided id' do
      mock_data = MockData.mock_generator(self, 'Customer', customer_hashes)
      allow_any_instance_of(CustomerRepository).to receive(:create_customers).and_return(mock_data)
      c_repo = CustomerRepository.new('fake.csv')

      new_customer_attributes = {
        id: nil,
        first_name: 'Yan',
        last_name: 'Cancook',
        created_at: Time.now,
        updated_at: Time.now
      }

      c_repo.create(new_customer_attributes)

      expect(c_repo.all.length).to eq 11

      c_repo.delete(2)

      expect(c_repo.all.length).to eq 10
    end
  end
end
