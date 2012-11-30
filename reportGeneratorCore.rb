require 'rubygems'
require_gem 'activerecord'
require 'item.rb'
require 'order.rb'

ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => "localhost", :database => "spiritorders", :username => "root", :password => "grapplestank")

def clearTotals
  @itemTotals.keys.each do |key|
    @itemTotals[key] = 0
  end
end

def generateReport(strStartDate, strEndDate)  # Dates are inclusive, and in string form.
  headersRow = ["Order Number","order date","subtotal","discount","shipping","TOTAL","actual shipping","carrier","lori commission","ship date","zipcode","sales tax","NET","fees?"]
  itemCols = []
  rows = []
  
  @itemTotals = Hash.new
  
  #let's get all the items ordered this time
  itemCodes = Item.find_by_sql("SELECT DISTINCT itemnumber FROM items")
  itemCodes.each do |ic|
    itemCols << ic.itemnumber
    @itemTotals[ic.itemnumber] = 0
  end
  itemCols.each do |itemCol|
    headersRow << itemCol
  end
  rows << headersRow
  
  #Now fetch the orders
  orders = Order.find(:all, :conditions => "orderdate >= STR_TO_DATE('" + strStartDate + "','%m/%d/%Y') AND orderdate <= STR_TO_DATE('" + strEndDate + "','%m/%d/%Y')")
  orders.each do |order|
    thisRow = []
    thisRow << order.ordernumber
    thisRow << order.orderdate
    thisRow << order.ordersubtotal/ 100.0
    if order.discountcode == "Y"
      thisRow << "(10.00)"
    else
      thisRow << ""
    end
    thisRow << order.ordershippingcost / 100.0
    thisRow << order.ordertotal / 100.0
    thisRow << ""
    thisRow << order.ordershippingmethod
    thisRow << "(2.00)"
    thisRow << ""
    thisRow << (order.shippingzip == "" ? order.billingzip : order.shippingzip)
    thisRow << order.ordersalestax / 100.0
    thisRow << ""
    thisRow << ""
    #total up items
    order.items.each do |item|
      @itemTotals[item.itemnumber] = @itemTotals[item.itemnumber] + item.quantity
    end
    #add the totals to the row
    itemCols.each do |itemCol|
      thisRow << @itemTotals[itemCol]
    end
    clearTotals
    rows << thisRow
  end
  
  rows.each do |row|
    row.each do |entry|
      print entry, "\t"
    end
    print "\n"
  end
end
