object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'Servidor WMS'
  ClientHeight = 191
  ClientWidth = 572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 572
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Servidor Wms'
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlightText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 43
    Width = 572
    Height = 148
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 1
    object memLog: TMemo
      Left = 0
      Top = 0
      Width = 572
      Height = 148
      Align = alClient
      BorderStyle = bsNone
      Lines.Strings = (
        '')
      TabOrder = 0
    end
  end
end
