gem 'activerecord'
require './item.rb'
require './order.rb'
require 'yaml'
require 'net/imap'

class MailParserCore
  
  def initialize()
    super()
    @config = YAML.load_file("orderSystemConfig.yaml")
    ActiveRecord::Base.establish_connection(:adapter => "mysql", :host => @config["dbserver"], :database => @config["database"], :username => @config["dbuser"], :password => @config["dbpassword"])
  end
  
  def parseMail(folderName)
    #set up log files
    now = Time.new
    rejFile = File.new("parse.rej","w")
    logFile = File.new("order_run-" + now.month.to_s + "-" + now.day.to_s + "-" + now.year.to_s + ".log","w")
    
    #connect to the IMAP server with the orders
    imap = Net::IMAP.new(@config["mailserver"])
    imap.authenticate("LOGIN",@config["maillogin"],@config["mailpassword"])
    imap.select(folderName)
    
    
    @cntMessages = 0
    @cntOrders = 0
    @cntDupes = 0
    @cntBadMessages = 0
    
    #get all the messages to the store
    imap.search(["TO", "fulfillment@spirit7thfire.com"]).each do |message_id|
      @cntMessages = @cntMessages + 1
      print "+"
      bodyText = imap.fetch(message_id, "BODY[TEXT]")
      mess = bodyText[0].attr["BODY[TEXT]"]
      
      ord = Order.parse(mess)
      isDuplicate = false
      if !ord.nil?
        envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
        ord.orderdate = envelope.date
        ord.save
        if ord.errors.count == 0
          @cntOrders = @cntOrders + 1
        else
          # See if the errors were from a duplicate or something else
          ord.errors.each do |attr, msg|
            if msg[0,14] == "ERRORDEREXISTS"
              isDuplicate = true
            end
          end
          if isDuplicate
            logFile.print("duplicate order ", ord.ordernumber, "\n")
            @cntDupes = @cntDupes + 1
          else
            logFile.print("errors in order " , ord.ordernumber)
          end
        end
      else
        # This did not parse as an Americart message
        @cntBadMessages = @cntBadMessages + 1
        rejFile.puts(mess)
      end
    end
  end
end
