object Form2: TForm2
  Left = 618
  Top = 55
  Width = 689
  Height = 563
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 136
    Top = 72
    Width = 185
    Height = 89
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    Lines.Strings = (
      'Memo')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WantTabs = True
    OnDblClick = MemoDblClick
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 8
    object Quitter1: TMenuItem
      Caption = 'Quitter'
      OnClick = Quitter1Click
    end
    object rait1: TMenuItem
      Caption = 'Trait'
      OnClick = rait1Click
    end
    object Date1: TMenuItem
      Caption = 'Date'
      OnClick = Date1Click
    end
  end
end
