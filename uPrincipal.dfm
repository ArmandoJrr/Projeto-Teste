object FrmPrincipal: TFrmPrincipal
  Left = 858
  Top = 374
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Servidor PostGres'
  ClientHeight = 98
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 47
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 145
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 24
    Top = 66
    Width = 75
    Height = 21
    ReadOnly = True
    TabOrder = 2
    Text = '211'
  end
  object ButtonOpenBrowser: TButton
    Left = 24
    Top = 112
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 3
    Visible = False
    OnClick = ButtonOpenBrowserClick
  end
  object ApplicationEvents: TApplicationEvents
    OnIdle = ApplicationEventsIdle
    Left = 320
    Top = 40
  end
end
