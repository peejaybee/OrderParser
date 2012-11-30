require 'item.rb'

class Order < ActiveRecord::Base

  has_many :items
  
  validates_uniqueness_of :ordernumber, :message => "ERRORDEREXISTS - order exists in database"

  
  def self.parse(orderMessage)
  
pattDate = /Date:\s+(\d+\s\w{3}\s\d{4})/
pattAuthorizeNet = /\*Authorizenet Order # (\d\d\d\d-\d\d\d\d-\d\d\d\d) Received by Americart\*\s*Always verify price accuracy\. Order from IP# (?:(?:\d{1,3}\.){3}\d{1,3})\s*(.*?)-------------------Payment Information---------------------(.*?)------------Cardholder Billing Information-----------------(.*?)----------------Shipping Information-----------------------(.*?)---------------------Order Summary-------------------------(.*?)--------------------Special Instructions-------------------(.*?)-----------------Individual Item Breakdown-----------------\s*Item Ref\.   Price ea\.   Qty\.  Description\s*___________________________________________________________\s*(.*?)------------------------End of Order------------------/m
pattPaypal = /\*PayPal Order # (\d\d\d\d-\d\d\d\d-\d\d\d\d) Received by Americart\*\s*Always verify price accuracy\. Order from IP# (?:(?:\d{1,3}\.){3}\d{1,3})\s*(.*?)-------------------Payment Information---------------------(.*?)----------------Shipping Information-----------------------(.*?)---------------------Order Summary-------------------------(.*?)--------------------Special Instructions-------------------(.*?)-----------------Individual Item Breakdown-----------------\s*Item Ref\.   Price ea\.   Qty\.  Description\s*___________________________________________________________\s*(.*?)------------------------End of Order------------------/m

        if orderMessage =~ pattAuthorizeNet
            ord = Order.new
            ord.ordernumber = $1
            ord.warning = $2
            ord.parseBilling($4)
            ord.parseShipping($5)
            ord.parseSummary($6)
            ord.specialinstructions = $7
            ord.items = Item.parse($8)
            return ord
        elsif orderMessage =~ pattPaypal
            ord = Order.new
            ord.ordernumber = $1
            ord.warning = $2
            ord.parseShipping($4)
            ord.parseSummary($5)
            ord.specialinstructions = $6
            ord.items = Item.parse($7)
            return ord
	else
            return nil
        end
    end

  def parseBilling(billingInfo)
    pairs = billingInfo.scan(/^([\w\s]+):(.*)$/)
    pairs.each do |pair|
      case pair[0].strip
      when "First Name"
        self.billingfirstname= pair[1].strip
      when "Last Name"
        self.billinglastname= pair[1].strip
      when "Company"
        self.billingcompany= pair[1].strip
      when "Street"
        self.billingstreet= pair[1].strip
      when "City"
        self.billingcity= pair[1].strip
      when "State"
        self.billingstate= pair[1].strip
      when "Zipcode"
        self.billingzip= pair[1].strip
      when "Country"
        self.billingcountry= pair[1].strip
      when "Email"
        self.billingemail= pair[1].strip
      when "Phone"
        self.billingphone= pair[1].strip
      end
    end
  end
  
  def parseShipping(shippingInfo)
    pairs = shippingInfo.scan(/^([\w\s]+):(.*)$/)
    pairs.each do |pair|
      case pair[0].strip
      when "First Name"
        self.shippingfirstname= pair[1].strip
      when "Last Name"
        self.shippinglastname= pair[1].strip
      when "Company"
        self.shippingcompany= pair[1].strip
      when "Street"
        self.shippingstreet= pair[1].strip
      when "City"
        self.shippingcity= pair[1].strip
      when "State"
        self.shippingstate= pair[1].strip
      when "Zipcode"
        self.shippingzip= pair[1].strip
      when "Country"
        self.shippingcountry= pair[1].strip
      end
    end
  end
  
  def parseSummary(summaryInfo)
    pattTax = /^Includes (\d+\.\d\d) sales tax \(if applicable\)\s*$/m
    self.discountcode = "N"
    self.ordersalestax = 0
    pairs = summaryInfo.scan(/^([\w\s]+):(.*)$/)
    pairs.each do |pair|
      case pair[0].strip
      when "Item Subtotal"
        self.ordersubtotal= pair[1].strip.sub("$","").to_f * 100
      when "Shipping Cost"
        self.ordershippingcost= pair[1].strip.sub("$","").to_f * 100
      when "GRAND TOTAL"
        self.ordertotal= pair[1].strip.sub("$","").to_f * 100
      when "Shipping Method"
        self.ordershippingmethod= pair[1].strip
      when "Shipping Weight"
 #      self.shippingweight= pair[1].strip
      when "Discount Code"
        self.discountcode = "Y"
      when "Sales Tax"
        self.ordersalestax = pair[1].strip.sub("$","").to_f * 100
      end
      if summaryInfo =~pattTax 
        self.ordersalestax = $1.strip.sub("$","").to_f * 100
      end
    end
  end
  
  def parsePayment(paymentInfo)
  end
  

end
