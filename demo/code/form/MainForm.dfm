object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Demo'
  ClientHeight = 209
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 447
    Height = 177
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 8
    Top = 183
    Width = 431
    Height = 21
    Align = alCustom
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 0
    OnChange = Edit1Change
  end
end
