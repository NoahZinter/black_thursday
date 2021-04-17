class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(details)
    @id = details[:id]
    @invoice_id = details[:invoice_id]
    @credit_card_number = details[:credit_card_number]
    @credit_card_expiration_date = details[:credit_card_expiration_date]
    @result = details[:result].to_sym
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end

  def update_id(id)
    @id = id
  end

  def update_credit_card_number(credit_card_number)
    @credit_card_number = credit_card_number unless credit_card_number.nil?
  end

  def update_credit_card_exp_date(credit_card_expiration_date)
    @credit_card_expiration_date = credit_card_expiration_date unless credit_card_expiration_date.nil?
  end

  def update_result(result)
    @result = result unless result.nil?
  end

  def update_time
    @updated_at = Time.now
  end
end
