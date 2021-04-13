class Merchant
  attr_reader :id,
              :name

  def initialize(details)
    @id = details[:id]
    @name = details[:name]
  end

  def update_name(name)
    @name = name
  end
end