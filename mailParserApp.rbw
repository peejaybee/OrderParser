require './mailParserCore.rb'
gem 'wxruby'


#
# Basic Frame Class. This creates the dialog window
#
class SimpleFrame < Wx::Frame 
  
  
  def initialize()
    #		super(nil)
    super(nil,-1,"Sample",Wx::Point.new(50,50),Wx::Size.new(300,300))
    $xml.load_frame_subclass(self,nil,'frmMain')
    
    @ctrlFolderTxt = Wx::Window.find_window_by_id(Wx::xrcid('txtFolder'),self)
    
    evt_menu(Wx::xrcid('mnuQuit')) do
      Wx::get_app.exit_main_loop()
    end
    
    evt_button(Wx::xrcid('btnGo')) do
      pc = MailParserCore.new()
      pc.parseMail(@ctrlFolderTxt.get_line_text(0))
      Wx::message_box("done")
    end
    
    evt_close() do
      Wx::get_app.exit_main_loop()
    end
  end
  
end

#
# Dialog subclass. Uses XRC for the dialog definition
#
class SimpleDialog < Wx::Dialog
  
  def initialize(parent)
    super()
    
    #
    # Load the dialog from XRC. We define $xml in on_init.
    # We could use XmlResource.get() over and over again, but
    # honestly, thats just too much work.
    #
    $xml.load_dialog_subclass(self,parent,'SAMPLE_DIALOG')
    
    #
    # Get the buttons. Note we use 'xrcid' much like the XRCID macro
    # in C++. Make sure the id's actually exist, or your program will crash!
    #
    @ok = Wx::Window.find_window_by_id(Wx::xrcid('wxID_OK'),self)
    @cancel = Wx::Window.find_window_by_id(Wx::xrcid('wxID_CANCEL'),self)
    @message = Wx::Window.find_window_by_id(Wx::xrcid('SAMPLE_MESSAGE'),self)
    
    #
    # Bind the buttons to event handlers
    #
    evt_button(Wx::xrcid('wxID_OK')) do
      end_modal(Wx::ID_OK)
    end
    
    evt_button(Wx::xrcid('wxID_CANCEL')) do
      end_modal(Wx::ID_CANCEL)
    end
    
    evt_button(Wx::xrcid('SAMPLE_MESSAGE')) do
      Wx::message_box("And now a message from our sponsors.")
    end
    
  end
  
end

#
# Application class.
#
class XrcApp < Wx::App
  
  def on_init
    #
    # Xrc dialogs can load images, so it's good to have
    # this line before loading a resource file
    #
    Wx::init_all_image_handlers()
    
    #
    # Create a resource handler
    #
    $xml = Wx::XmlResource.get();
    $xml.init_all_handlers();
    
    #
    # Load a resource file
    #
    $xml.load("gui/gui.xrc")	
    
    #
    # Show the main frame.
    #
    $main = SimpleFrame.new()
    $main.show(true)
  end
  
end



XrcApp.new().main_loop()
