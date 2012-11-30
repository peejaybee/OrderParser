class Item < ActiveRecord::Base

belongs_to :order

  def self.parse(orderBreakdown)
    pattItem = /^([\w\d]+)\s+\$([\.\d]+)\s+([\d]+).*$/
    retVal = []
    lineItems = orderBreakdown.scan(pattItem)
    lineItems.each do |lineItem|
      item = Item.new
      item.itemnumber = lineItem[0]
      item.price = lineItem[1].to_f * 100
      item.quantity = lineItem[2]
      retVal<< item
    end
    return retVal
  end

end
