object Form1: TForm1
  Left = 241
  Top = 115
  Width = 1038
  Height = 674
  Caption = 'Infos DB'
  Color = 8454143
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object LCAT: TListBox
    Left = 0
    Top = 296
    Width = 145
    Height = 248
    Color = 16777088
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    Sorted = True
    TabOrder = 0
    OnClick = LCATClick
  end
  object LRUB: TListBox
    Left = 144
    Top = 296
    Width = 145
    Height = 248
    Color = 8454016
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    Sorted = True
    TabOrder = 1
    OnClick = LRUBClick
  end
  object LTIT: TListBox
    Left = 0
    Top = 0
    Width = 289
    Height = 273
    Color = clSilver
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 2
    OnClick = LTITClick
  end
  object bCHERCHE: TButton
    Left = 0
    Top = 273
    Width = 57
    Height = 22
    Caption = 'CHERCHE'
    TabOrder = 3
    OnClick = bCHERCHEClick
  end
  object eCHERCHE: TEdit
    Left = 56
    Top = 272
    Width = 233
    Height = 22
    TabOrder = 4
  end
  object M1: TMemo
    Left = 288
    Top = 0
    Width = 593
    Height = 543
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'M1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 5
    WantTabs = True
    OnDblClick = M1DblClick
  end
  object LX: TListBox
    Left = 200
    Top = 48
    Width = 761
    Height = 97
    Color = 16744703
    ItemHeight = 14
    TabOrder = 6
    Visible = False
  end
  object MainMenu1: TMainMenu
    Left = 904
    Top = 8
    object Fichiers1: TMenuItem
      Caption = 'Fichiers'
      object Charger1: TMenuItem
        Caption = 'Charger'
        OnClick = Charger1Click
      end
      object Sauver1: TMenuItem
        Caption = 'Sauver'
        OnClick = Sauver1Click
      end
      object Sauversous1: TMenuItem
        Caption = 'Sauver sous'
        OnClick = Sauversous1Click
      end
      object Quitter2: TMenuItem
        Caption = 'Quitter'
        OnClick = Quitter2Click
      end
    end
    object Ajouter1: TMenuItem
      Caption = 'Ajouter'
      OnClick = Ajouter1Click
    end
    object Modifier1: TMenuItem
      Caption = 'Modifier'
      OnClick = Modifier1Click
    end
    object Suypprimer1: TMenuItem
      Caption = 'Supprimer'
      OnClick = Suypprimer1Click
    end
    object rait1: TMenuItem
      Caption = 'Trait'
      OnClick = rait1Click
    end
    object Date1: TMenuItem
      Caption = 'Date'
      OnClick = Date1Click
    end
    object Effacer1: TMenuItem
      Caption = 'Effacer'
      OnClick = Effacer1Click
    end
    object Executer1: TMenuItem
      Caption = 'Executer'
      OnClick = Executer1Click
    end
    object propos1: TMenuItem
      Caption = 'a propos'
      OnClick = propos1Click
    end
    object Quitter1: TMenuItem
      Caption = 'Quitter'
      OnClick = Quitter1Click
    end
  end
  object O1: TOpenDialog
    Filter = 'Fichier INFOS (*.ifo)|*.ifo'
    Left = 912
    Top = 184
  end
  object S1: TSaveDialog
    Filter = 'Fichier INFOS (*.ifo)|*.ifo'
    Left = 912
    Top = 224
  end
end
