object Form1: TForm1
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Settings'
  ClientHeight = 73
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object HomePage: TLabel
    Left = 0
    Top = 5
    Width = 51
    Height = 13
    Caption = 'HomePage'
  end
  object Favour: TLabel
    Left = 0
    Top = 53
    Width = 51
    Height = 13
    Caption = 'Favourites'
  end
  object edHomepage: TEdit
    Left = 57
    Top = 2
    Width = 175
    Height = 21
    TabOrder = 0
    Text = 'Yandex.ru'
  end
  object Setcombobox: TComboBox
    Left = 57
    Top = 50
    Width = 175
    Height = 21
    TabOrder = 1
    Text = 'Setcombobox'
  end
  object OkHP: TButton
    Left = 238
    Top = 0
    Width = 81
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = OkHPClick
  end
  object favOk: TButton
    Left = 238
    Top = 48
    Width = 81
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = favOkClick
  end
end
