require 'wxruby'
include Wx
require 'reportGeneratorCore'


Minimal_Quit = 1
Minimal_About = ID_ABOUT

ID_BUTTON_GO = 101


class MyFrame < Frame
  def initialize(title,pos,size,style=DEFAULT_FRAME_STYLE)
    super(nil,-1,title,pos,size,style)

    if RUBY_PLATFORM == "WXMSW"
      set_icon(Icon.new("mondrian.ico",BITMAP_TYPE_ICO))
    else
      set_icon(Icon.new("mondrian.xpm",BITMAP_TYPE_XPM))
    end

    menuFile = Menu.new
    helpMenu = Menu.new
    helpMenu.append(Minimal_About, "&About...\tF1", "Show about dialog")
    menuFile.append(Minimal_Quit, "E&xit\tAlt-X", "Quit this program")
    menuBar = MenuBar.new
    menuBar.append(menuFile, "&File")
    menuBar.append(helpMenu, "&Help")
    set_menu_bar(menuBar)

    create_status_bar(2)
    set_status_text("Welcome to wxRuby!")

    evt_menu(Minimal_Quit) {onQuit}
    evt_menu(Minimal_About) {onAbout}

  end

  def onQuit
    close(TRUE)
  end

  def onAbout
    msg =  sprintf("This is the About dialog of the minimal sample.\n" \
    		   "Welcome to %s", VERSION_STRING)

    message_box(msg, "About Minimal", OK | ICON_INFORMATION, self)

  end
end

class MyPanel < Panel
  def initialize(frame)
    super( frame )
    evt_button(ID_BUTTON_GO) { generateReport("12/1/2005","12/31/2005")}
  end
end

class RbApp < App
  def on_init
    frame = MyFrame.new("Minimal wxRuby App",Point.new(50, 50), Size.new(450, 340))
    panel = MyPanel.new(frame)
    btnGo = Button.new(panel,ID_BUTTON_GO,"Go")
    

    frame.show(TRUE)

  end
end


a = RbApp.new
a.main_loop()


        #if dialog.show_modal() == ID_OK
        #    retData = dialog.get_font_data()
        #    get_app().m_canvasFont = retData.get_chosen_font()
        #    get_app().m_canvasTextColour = retData.get_colour()
        #    $myCanvas.refresh()
        #end
