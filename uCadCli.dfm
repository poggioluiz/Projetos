object frmCadCli: TfrmCadCli
  Left = 0
  Top = 0
  Caption = 'Cadastro Cliente'
  ClientHeight = 300
  ClientWidth = 454
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblNome: TLabel
    Left = 8
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object lblRG: TLabel
    Left = 8
    Top = 49
    Width = 14
    Height = 13
    Caption = 'RG'
  end
  object lblCPF: TLabel
    Left = 164
    Top = 49
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object lblTelefone: TLabel
    Left = 8
    Top = 92
    Width = 42
    Height = 13
    Caption = 'Telefone'
  end
  object lblEmail: TLabel
    Left = 164
    Top = 92
    Width = 24
    Height = 13
    Caption = 'Email'
  end
  object lblCEP: TLabel
    Left = 8
    Top = 134
    Width = 19
    Height = 13
    Caption = 'CEP'
  end
  object lblUF: TLabel
    Left = 270
    Top = 134
    Width = 13
    Height = 13
    Caption = 'UF'
  end
  object lblPais: TLabel
    Left = 114
    Top = 134
    Width = 19
    Height = 13
    Caption = 'Pa'#237's'
  end
  object lblCidade: TLabel
    Left = 8
    Top = 174
    Width = 33
    Height = 13
    Caption = 'Cidade'
  end
  object lblBairro: TLabel
    Left = 164
    Top = 174
    Width = 28
    Height = 13
    Caption = 'Bairro'
  end
  object lblComplemento: TLabel
    Left = 8
    Top = 257
    Width = 65
    Height = 13
    Caption = 'Complemento'
  end
  object lblNumero: TLabel
    Left = 220
    Top = 257
    Width = 37
    Height = 13
    Caption = 'N'#250'mero'
  end
  object Label3: TLabel
    Left = 8
    Top = 214
    Width = 55
    Height = 13
    Caption = 'Logradouro'
  end
  object Label14: TLabel
    Left = 496
    Top = 520
    Width = 49
    Height = 13
    Caption = 'vdNumero'
    FocusControl = DBEdit13
  end
  object btnFinalizar: TButton
    Left = 328
    Top = 174
    Width = 116
    Height = 25
    Caption = 'Finalizar'
    TabOrder = 0
    OnClick = btnFinalizarClick
  end
  object edtNome: TDBEdit
    Left = 8
    Top = 22
    Width = 306
    Height = 21
    DataField = 'vdNome'
    DataSource = dsCliente
    TabOrder = 1
  end
  object edtRG: TDBEdit
    Left = 8
    Top = 65
    Width = 150
    Height = 21
    DataField = 'vdRG'
    DataSource = dsCliente
    TabOrder = 2
  end
  object edtCPF: TDBEdit
    Left = 164
    Top = 65
    Width = 150
    Height = 21
    DataField = 'vdCPF'
    DataSource = dsCliente
    TabOrder = 3
  end
  object edtTelefone: TDBEdit
    Left = 8
    Top = 107
    Width = 150
    Height = 21
    DataField = 'vdTelefone'
    DataSource = dsCliente
    TabOrder = 4
  end
  object edtEmail: TDBEdit
    Left = 164
    Top = 107
    Width = 150
    Height = 21
    DataField = 'vdEmail'
    DataSource = dsCliente
    TabOrder = 5
  end
  object edtCEP: TDBEdit
    Left = 8
    Top = 147
    Width = 100
    Height = 21
    DataField = 'vdCEP'
    DataSource = dsCliente
    TabOrder = 6
    OnExit = edtCEPExit
  end
  object edtPais: TDBEdit
    Left = 114
    Top = 147
    Width = 150
    Height = 21
    DataField = 'vdPais'
    DataSource = dsCliente
    TabOrder = 7
  end
  object edtUF: TDBEdit
    Left = 270
    Top = 147
    Width = 44
    Height = 21
    DataField = 'vdUF'
    DataSource = dsCliente
    TabOrder = 8
  end
  object edtCidade: TDBEdit
    Left = 8
    Top = 187
    Width = 150
    Height = 21
    DataField = 'vdCidade'
    DataSource = dsCliente
    TabOrder = 9
  end
  object edtBairro: TDBEdit
    Left = 164
    Top = 187
    Width = 150
    Height = 21
    DataField = 'vdBairro'
    DataSource = dsCliente
    TabOrder = 10
  end
  object edtLogradouro: TDBEdit
    Left = 8
    Top = 230
    Width = 306
    Height = 21
    DataField = 'vdLogradouro'
    DataSource = dsCliente
    TabOrder = 11
  end
  object edtComplemento: TDBEdit
    Left = 8
    Top = 272
    Width = 206
    Height = 21
    DataField = 'vdComplemento'
    DataSource = dsCliente
    TabOrder = 12
  end
  object DBEdit13: TDBEdit
    Left = 496
    Top = 536
    Width = 134
    Height = 21
    DataField = 'vdNumero'
    DataSource = dsCliente
    TabOrder = 13
  end
  object edtNumero: TDBEdit
    Left = 220
    Top = 272
    Width = 94
    Height = 21
    DataField = 'vdNumero'
    DataSource = dsCliente
    TabOrder = 14
  end
  object btnInserir: TButton
    Left = 330
    Top = 50
    Width = 116
    Height = 25
    Caption = 'Inserir'
    TabOrder = 15
    OnClick = btnInserirClick
  end
  object btnEditar: TButton
    Left = 328
    Top = 81
    Width = 116
    Height = 25
    Caption = 'Editar'
    TabOrder = 16
    OnClick = btnEditarClick
  end
  object DBNavigator1: TDBNavigator
    Left = 328
    Top = 19
    Width = 115
    Height = 25
    DataSource = dsCliente
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    TabOrder = 17
  end
  object btnCancelar: TButton
    Left = 328
    Top = 112
    Width = 116
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 18
    OnClick = btnCancelarClick
  end
  object btnDeletar: TButton
    Left = 328
    Top = 143
    Width = 116
    Height = 25
    Caption = 'Deletar'
    TabOrder = 19
    OnClick = btnDeletarClick
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    object cdsClientevdNome: TStringField
      FieldName = 'vdNome'
      Size = 200
    end
    object cdsClientevdRG: TStringField
      FieldName = 'vdRG'
    end
    object cdsClientevdCPF: TStringField
      FieldName = 'vdCPF'
    end
    object cdsClientevdTelefone: TStringField
      FieldName = 'vdTelefone'
    end
    object cdsClientevdEmail: TStringField
      FieldName = 'vdEmail'
      Size = 200
    end
    object cdsClientevdCEP: TStringField
      FieldName = 'vdCEP'
      Size = 8
    end
    object cdsClientevdPais: TStringField
      FieldName = 'vdPais'
      Size = 50
    end
    object cdsClientevdUF: TStringField
      FieldName = 'vdUF'
      Size = 2
    end
    object cdsClientevdCidade: TStringField
      FieldName = 'vdCidade'
      Size = 50
    end
    object cdsClientevdBairro: TStringField
      DisplayWidth = 100
      FieldName = 'vdBairro'
      Size = 100
    end
    object cdsClientevdLogradouro: TStringField
      FieldName = 'vdLogradouro'
      Size = 200
    end
    object cdsClientevdComplemento: TStringField
      FieldName = 'vdComplemento'
      Size = 200
    end
    object cdsClientevdNumero: TStringField
      FieldName = 'vdNumero'
      Size = 10
    end
  end
  object dsCliente: TDataSource
    DataSet = cdsCliente
    Left = 104
  end
end
