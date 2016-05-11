object dmInfoADM: TdmInfoADM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 211
  Top = 158
  Height = 369
  Width = 550
  object bdInfoADM: TDatabase
    AliasName = 'InfoADM'
    Connected = True
    DatabaseName = 'InfoADM'
    LoginPrompt = False
    SessionName = 'Default'
    TransIsolation = tiDirtyRead
    Left = 488
    Top = 8
  end
  object tbParametros: TTable
    Active = True
    AfterPost = tbParametrosAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMPAR.DB'
    Left = 32
    Top = 16
  end
  object tbFornedores: TTable
    AfterPost = tbFornedoresAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMFOR.DB'
    Left = 32
    Top = 72
    object tbFornedoresFOR_CDFORN: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_CDFORN'
      Size = 5
    end
    object tbFornedoresFOR_NMFORN: TStringField
      FieldName = 'FOR_NMFORN'
    end
    object tbFornedoresFOR_RAFORN: TStringField
      FieldName = 'FOR_RAFORN'
      Size = 40
    end
    object tbFornedoresFOR_CGCFOR: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_CGCFOR'
      EditMask = '99.999.999/9999-99;0;_'
      Size = 14
    end
    object tbFornedoresFOR_ENDERE: TStringField
      FieldName = 'FOR_ENDERE'
      Size = 40
    end
    object tbFornedoresFOR_BAIRRO: TStringField
      FieldName = 'FOR_BAIRRO'
    end
    object tbFornedoresFOR_NRFONE: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_NRFONE'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object tbFornedoresFOR_FAXFOR: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_FAXFOR'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object tbFornedoresFOR_NRRAMA: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_NRRAMA'
      Size = 4
    end
    object tbFornedoresFOR_NRTELE: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_NRTELE'
      EditMask = '9999-9999;1;_'
      Size = 9
    end
    object tbFornedoresFOR_CIDADE: TStringField
      FieldName = 'FOR_CIDADE'
    end
    object tbFornedoresFOR_UFFORN: TStringField
      FieldName = 'FOR_UFFORN'
      Size = 2
    end
    object tbFornedoresFOR_CEPFOR: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_CEPFOR'
      EditMask = '99999-999;0;_'
      Size = 8
    end
    object tbFornedoresFOR_INESTA: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_INESTA'
      EditMask = '99.999.999-9/99999;0;_'
      Size = 14
    end
    object tbFornedoresFOR_NMCONT: TStringField
      FieldName = 'FOR_NMCONT'
    end
    object tbFornedoresFOR_CACONT: TStringField
      FieldName = 'FOR_CACONT'
    end
    object tbFornedoresFOR_FONECO: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_FONECO'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object tbFornedoresFOR_RAMACO: TStringField
      Alignment = taRightJustify
      FieldName = 'FOR_RAMACO'
      Size = 4
    end
    object tbFornedoresFOR_EMAIL1: TStringField
      FieldName = 'FOR_EMAIL1'
      Size = 60
    end
    object tbFornedoresFOR_EMAIL2: TStringField
      FieldName = 'FOR_EMAIL2'
      Size = 60
    end
    object tbFornedoresFOR_HOMEPG: TStringField
      FieldName = 'FOR_HOMEPG'
      Size = 60
    end
    object tbFornedoresFOR_PEJURO: TFloatField
      FieldName = 'FOR_PEJURO'
    end
    object tbFornedoresFOR_PEMULT: TFloatField
      FieldName = 'FOR_PEMULT'
    end
  end
  object qryFornecedor: TQuery
    DatabaseName = 'InfoADM'
    SQL.Strings = (
      'Select * from ADMFOR')
    Left = 104
    Top = 72
  end
  object tbProdutos: TTable
    AfterPost = tbProdutosAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMPRO.DB'
    Left = 32
    Top = 120
    object tbProdutosPRO_CDPROD: TStringField
      Alignment = taRightJustify
      FieldName = 'PRO_CDPROD'
      Size = 14
    end
    object tbProdutosPRO_CDREFE: TStringField
      Alignment = taRightJustify
      FieldName = 'PRO_CDREFE'
      Size = 13
    end
    object tbProdutosPRO_CDFORN: TStringField
      Alignment = taRightJustify
      FieldName = 'PRO_CDFORN'
      Size = 5
    end
    object tbProdutosPRO_NMPROD: TStringField
      FieldName = 'PRO_NMPROD'
      Size = 40
    end
    object tbProdutosPRO_CDFABR: TStringField
      Alignment = taRightJustify
      FieldName = 'PRO_CDFABR'
      Size = 5
    end
    object tbProdutosPRO_NMFABR: TStringField
      FieldName = 'PRO_NMFABR'
    end
    object tbProdutosPRO_CDUNID: TStringField
      Alignment = taRightJustify
      FieldName = 'PRO_CDUNID'
      Size = 3
    end
    object tbProdutosPRO_FMARMA: TStringField
      Alignment = taRightJustify
      FieldName = 'PRO_FMARMA'
      Size = 3
    end
    object tbProdutosPRO_QTARMA: TFloatField
      FieldName = 'PRO_QTARMA'
    end
    object tbProdutosPRO_PEARMA: TFloatField
      FieldName = 'PRO_PEARMA'
    end
    object tbProdutosPRO_CDGRUP: TStringField
      Alignment = taRightJustify
      FieldName = 'PRO_CDGRUP'
      Size = 2
    end
    object tbProdutosPRO_CDSECA: TStringField
      Alignment = taRightJustify
      FieldName = 'PRO_CDSECA'
      Size = 2
    end
    object tbProdutosPRO_PELUCR: TFloatField
      FieldName = 'PRO_PELUCR'
    end
    object tbProdutosPRO_PEICMS: TFloatField
      FieldName = 'PRO_PEICMS'
    end
    object tbProdutosPRO_PERIPI: TFloatField
      FieldName = 'PRO_PERIPI'
    end
    object tbProdutosPRO_PESOCI: TFloatField
      FieldName = 'PRO_PESOCI'
    end
    object tbProdutosPRO_PEFINA: TFloatField
      FieldName = 'PRO_PEFINA'
    end
    object tbProdutosPRO_VLCUST: TCurrencyField
      FieldName = 'PRO_VLCUST'
    end
    object tbProdutosPRO_VLVEND: TCurrencyField
      FieldName = 'PRO_VLVEND'
    end
    object tbProdutosPRO_DTATUA: TDateField
      Alignment = taRightJustify
      FieldName = 'PRO_DTATUA'
      EditMask = '99/99/9999;0;_'
    end
    object tbProdutosPRO_VLSAID: TFloatField
      FieldName = 'PRO_VLSAID'
    end
    object tbProdutosPRO_VLMACU: TFloatField
      FieldName = 'PRO_VLMACU'
    end
    object tbProdutosPRO_OBSERV: TStringField
      FieldName = 'PRO_OBSERV'
      Size = 50
    end
  end
  object qryProdutos: TQuery
    DatabaseName = 'InfoADM'
    SQL.Strings = (
      'Select * from ADMPRO')
    Left = 104
    Top = 120
  end
  object tbGrupos: TTable
    AfterPost = tbGruposAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMGRU.DB'
    Left = 104
    Top = 16
    object tbGruposGRU_CDSECA: TStringField
      FieldName = 'GRU_CDSECA'
      Size = 2
    end
    object tbGruposGRU_CDGRUP: TStringField
      FieldName = 'GRU_CDGRUP'
      Size = 2
    end
    object tbGruposGRU_NMGRUP: TStringField
      FieldName = 'GRU_NMGRUP'
      Size = 30
    end
  end
  object tbSecao: TTable
    AfterPost = tbSecaoAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    IndexFieldNames = 'SEC_NMSECA'
    TableName = 'ADMSEC.DB'
    Left = 216
    Top = 16
    object tbSecaoSEC_CDSECA: TStringField
      FieldName = 'SEC_CDSECA'
      Size = 2
    end
    object tbSecaoSEC_NMSECA: TStringField
      FieldName = 'SEC_NMSECA'
      Size = 30
    end
    object tbSecaoSEC_PECOMI: TFloatField
      FieldName = 'SEC_PECOMI'
    end
  end
  object tbUnidade: TTable
    AfterPost = tbUnidadeAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    IndexFieldNames = 'UNI_NMUNID'
    TableName = 'ADMUNI.DB'
    Left = 272
    Top = 16
    object tbUnidadeUNI_CDUNID: TStringField
      FieldName = 'UNI_CDUNID'
      Size = 3
    end
    object tbUnidadeUNI_NMUNID: TStringField
      FieldName = 'UNI_NMUNID'
      Size = 30
    end
  end
  object qryGrupos: TQuery
    DatabaseName = 'InfoADM'
    SQL.Strings = (
      'Select * from ADMGRU order by GRU_NMGRUP')
    Left = 160
    Top = 16
  end
  object tbSituacao: TTable
    AfterPost = tbSituacaoAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMSIT.DB'
    Left = 328
    Top = 16
    object tbSituacaoSIT_CDSITU: TStringField
      FieldName = 'SIT_CDSITU'
      Size = 3
    end
    object tbSituacaoSIT_NMSITU: TStringField
      FieldName = 'SIT_NMSITU'
      Size = 35
    end
  end
  object tbClientes: TTable
    AfterPost = tbClientesAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMCLI.DB'
    Left = 32
    Top = 176
    object tbClientesCLI_CDCLIE: TStringField
      Alignment = taRightJustify
      FieldName = 'CLI_CDCLIE'
      Size = 7
    end
    object tbClientesCLI_NMCLIE: TStringField
      FieldName = 'CLI_NMCLIE'
      Size = 50
    end
    object tbClientesCLI_RASOCI: TStringField
      FieldName = 'CLI_RASOCI'
      Size = 50
    end
    object tbClientesCLI_ENCLIE: TStringField
      FieldName = 'CLI_ENCLIE'
      Size = 40
    end
    object tbClientesCLI_CEPCLI: TStringField
      Alignment = taRightJustify
      FieldName = 'CLI_CEPCLI'
      EditMask = '99999-999;0;_'
      Size = 8
    end
    object tbClientesCLI_BACLIE: TStringField
      FieldName = 'CLI_BACLIE'
    end
    object tbClientesCLI_CICLIE: TStringField
      FieldName = 'CLI_CICLIE'
    end
    object tbClientesCLI_UFCLIE: TStringField
      FieldName = 'CLI_UFCLIE'
      Size = 2
    end
    object tbClientesCLI_NRFONE: TStringField
      Alignment = taRightJustify
      FieldName = 'CLI_NRFONE'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object tbClientesCLI_NRRAMA: TStringField
      Alignment = taRightJustify
      FieldName = 'CLI_NRRAMA'
      Size = 4
    end
    object tbClientesCLI_NUMFAX: TStringField
      Alignment = taRightJustify
      FieldName = 'CLI_NUMFAX'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object tbClientesCLI_NRCELU: TStringField
      Alignment = taRightJustify
      FieldName = 'CLI_NRCELU'
      EditMask = '9999-9999;0;_'
      Size = 8
    end
    object tbClientesCLI_CPFCGC: TStringField
      Alignment = taRightJustify
      FieldName = 'CLI_CPFCGC'
      EditMask = '99.999.999/9999-99;0;_'
      Size = 14
    end
    object tbClientesCLI_INSEST: TStringField
      Alignment = taRightJustify
      FieldName = 'CLI_INSEST'
      EditMask = '99.999.999-9/99999;0;_'
      Size = 14
    end
    object tbClientesCLI_DTCADA: TDateField
      FieldName = 'CLI_DTCADA'
      EditMask = '99/99/9999;1;_'
    end
    object tbClientesCLI_NMCONT: TStringField
      FieldName = 'CLI_NMCONT'
    end
    object tbClientesCLI_NRREGI: TMemoField
      FieldName = 'CLI_NRREGI'
      BlobType = ftMemo
      Size = 150
    end
    object tbClientesCLI_VLDEBI: TFloatField
      FieldName = 'CLI_VLDEBI'
    end
    object tbClientesCLI_CDSITU: TStringField
      Alignment = taRightJustify
      FieldName = 'CLI_CDSITU'
      Size = 3
    end
    object tbClientesCLI_NMSITU: TStringField
      FieldKind = fkLookup
      FieldName = 'CLI_NMSITU'
      LookupDataSet = tbSituacao
      LookupKeyFields = 'SIT_CDSITU'
      LookupResultField = 'SIT_NMSITU'
      KeyFields = 'CLI_CDSITU'
      Size = 35
      Lookup = True
    end
    object tbClientesCLI_EMAIL1: TStringField
      FieldName = 'CLI_EMAIL1'
      Size = 60
    end
    object tbClientesCLI_EMAIL2: TStringField
      FieldName = 'CLI_EMAIL2'
      Size = 60
    end
    object tbClientesCLI_HOMEPG: TStringField
      FieldName = 'CLI_HOMEPG'
      Size = 60
    end
  end
  object qryClientes: TQuery
    DatabaseName = 'InfoADM'
    SQL.Strings = (
      'Select * from ADMCLI')
    Left = 104
    Top = 176
  end
  object tbProCliente: TTable
    AfterPost = tbProClienteAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMPCL.DB'
    Left = 32
    Top = 232
    object tbProClientePCL_CDCLIE: TStringField
      Alignment = taRightJustify
      FieldName = 'PCL_CDCLIE'
      Size = 7
    end
    object tbProClientePCL_CDPROD: TStringField
      Alignment = taRightJustify
      FieldName = 'PCL_CDPROD'
      Size = 14
    end
    object tbProClientePCL_NMPROD: TStringField
      FieldKind = fkLookup
      FieldName = 'PCL_NMPROD'
      LookupDataSet = tbProdutos
      LookupKeyFields = 'PRO_CDPROD'
      LookupResultField = 'PRO_NMPROD'
      KeyFields = 'PCL_CDPROD'
      Size = 40
      Lookup = True
    end
  end
  object tbContratos: TTable
    AfterPost = tbContratosAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMCON.DB'
    Left = 104
    Top = 232
    object tbContratosCON_NRCONT: TStringField
      Alignment = taRightJustify
      FieldName = 'CON_NRCONT'
      EditMask = '99999/9999;0;_'
      Size = 9
    end
    object tbContratosCON_CDCLIE: TStringField
      Alignment = taRightJustify
      FieldName = 'CON_CDCLIE'
      Size = 7
    end
    object tbContratosCON_NMCLIE: TStringField
      FieldName = 'CON_NMCLIE'
      Size = 50
    end
    object tbContratosCON_NMCLIE2: TStringField
      FieldKind = fkLookup
      FieldName = 'CON_NMCLIE2'
      LookupDataSet = tbClientes
      LookupKeyFields = 'CLI_CDCLIE'
      LookupResultField = 'CLI_NMCLIE'
      KeyFields = 'CON_CDCLIE'
      Size = 40
      Lookup = True
    end
    object tbContratosCON_DTCONT: TDateField
      Alignment = taRightJustify
      FieldName = 'CON_DTCONT'
      EditMask = '99/99/9999;1;_'
    end
    object tbContratosCON_DTVENC: TDateField
      Alignment = taRightJustify
      FieldName = 'CON_DTVENC'
      EditMask = '99/99/9999;1;_'
    end
    object tbContratosCON_DTENCE: TDateField
      Alignment = taRightJustify
      FieldName = 'CON_DTENCE'
      EditMask = '99/99/9999;1;_'
    end
    object tbContratosCON_DIACAR: TSmallintField
      FieldName = 'CON_DIACAR'
    end
    object tbContratosCON_DIAFAT: TStringField
      FieldName = 'CON_DIAFAT'
      Size = 2
    end
    object tbContratosCON_VLCONT: TFloatField
      FieldName = 'CON_VLCONT'
      currency = True
    end
    object tbContratosCON_PEMULT: TFloatField
      FieldName = 'CON_PEMULT'
    end
    object tbContratosCON_PEJURO: TFloatField
      FieldName = 'CON_PEJURO'
    end
    object tbContratosCON_FLSITU: TStringField
      FieldName = 'CON_FLSITU'
      Size = 1
    end
    object tbContratosCON_FLCOBR: TStringField
      FieldName = 'CON_FLCOBR'
      Size = 1
    end
  end
  object tbFuncionarios: TTable
    AfterPost = tbFuncionariosAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMFUN.DB'
    Left = 32
    Top = 280
    object tbFuncionariosFUN_CDFUNC: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_CDFUNC'
      Size = 5
    end
    object tbFuncionariosFUN_NMFUNC: TStringField
      FieldName = 'FUN_NMFUNC'
      Size = 50
    end
    object tbFuncionariosFUN_ENDERE: TStringField
      FieldName = 'FUN_ENDERE'
      Size = 40
    end
    object tbFuncionariosFUN_BAIRRO: TStringField
      FieldName = 'FUN_BAIRRO'
    end
    object tbFuncionariosFUN_CIDADE: TStringField
      FieldName = 'FUN_CIDADE'
    end
    object tbFuncionariosFUN_UFFUNC: TStringField
      FieldName = 'FUN_UFFUNC'
      Size = 2
    end
    object tbFuncionariosFUN_CEPFUN: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_CEPFUN'
      EditMask = '99999-999;0;_'
      Size = 8
    end
    object tbFuncionariosFUN_NRFONE: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_NRFONE'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object tbFuncionariosFUN_NRCELU: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_NRCELU'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object tbFuncionariosFUN_NRIDEN: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_NRIDEN'
      Size = 12
    end
    object tbFuncionariosFUN_ORIDEN: TStringField
      FieldName = 'FUN_ORIDEN'
      Size = 4
    end
    object tbFuncionariosFUN_UFIDEN: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_UFIDEN'
      Size = 2
    end
    object tbFuncionariosFUN_NRTITU: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_NRTITU'
      EditMask = '9999999999-99;0;_'
      Size = 12
    end
    object tbFuncionariosFUN_ZOTITU: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_ZOTITU'
      EditMask = '999;1;_'
      Size = 3
    end
    object tbFuncionariosFUN_SETITU: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_SETITU'
      EditMask = '9999;1;_'
      Size = 4
    end
    object tbFuncionariosFUN_CPFCGC: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_CPFCGC'
      EditMask = '999.999.999-99;0;_'
      Size = 11
    end
    object tbFuncionariosFUN_NMCARG: TStringField
      FieldName = 'FUN_NMCARG'
    end
    object tbFuncionariosFUN_DTADMI: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_DTADMI'
      EditMask = '99/99/9999;1;_'
      Size = 10
    end
    object tbFuncionariosFUN_DTRECI: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_DTRECI'
      EditMask = '99/99/9999;1;_'
      Size = 10
    end
    object tbFuncionariosFUN_INESTA: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_INESTA'
      Size = 8
    end
    object tbFuncionariosFUN_FIESTA: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_FIESTA'
      Size = 8
    end
    object tbFuncionariosFUN_HORARI: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_HORARI'
      EditMask = '99:99 - 99:99 '#224's 99:99 - 99:99;0;_'
      Size = 16
    end
    object tbFuncionariosFUN_DTNASC: TStringField
      Alignment = taRightJustify
      FieldName = 'FUN_DTNASC'
      EditMask = '99/99/9999;1;_'
      Size = 10
    end
    object tbFuncionariosFUN_VLSALA: TFloatField
      FieldName = 'FUN_VLSALA'
      currency = True
    end
  end
  object tbVendedores: TTable
    AfterPost = tbVendedoresAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMVEN.DB'
    Left = 176
    Top = 80
    object tbVendedoresVEN_CDVEND: TStringField
      Alignment = taRightJustify
      FieldName = 'VEN_CDVEND'
      Size = 6
    end
    object tbVendedoresVEN_NMVEND: TStringField
      FieldName = 'VEN_NMVEND'
      Size = 40
    end
    object tbVendedoresVEN_ENDVEN: TStringField
      FieldName = 'VEN_ENDVEN'
      Size = 40
    end
    object tbVendedoresVEN_BAVEND: TStringField
      FieldName = 'VEN_BAVEND'
    end
    object tbVendedoresVEN_CIVEND: TStringField
      FieldName = 'VEN_CIVEND'
    end
    object tbVendedoresVEN_UFVEND: TStringField
      FieldName = 'VEN_UFVEND'
      Size = 2
    end
    object tbVendedoresVEN_CEPVEN: TStringField
      Alignment = taRightJustify
      FieldName = 'VEN_CEPVEN'
      EditMask = '99999-999;0;_'
      Size = 8
    end
    object tbVendedoresVEN_NRFONE: TStringField
      Alignment = taRightJustify
      FieldName = 'VEN_NRFONE'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object tbVendedoresVEN_PECOMI: TFloatField
      FieldName = 'VEN_PECOMI'
    end
  end
  object tbContato: TTable
    AfterPost = tbContatoAfterPost
    DatabaseName = 'InfoADM'
    SessionName = 'Default'
    TableName = 'ADMFON.DB'
    Left = 176
    Top = 136
    object tbContatoFON_NMCONT: TStringField
      FieldName = 'FON_NMCONT'
      Size = 30
    end
    object tbContatoFON_NMEMPR: TStringField
      FieldName = 'FON_NMEMPR'
      Size = 30
    end
    object tbContatoFON_ENDERE: TStringField
      FieldName = 'FON_ENDERE'
      Size = 40
    end
    object tbContatoFON_BAIRRO: TStringField
      FieldName = 'FON_BAIRRO'
    end
    object tbContatoFON_CEPCON: TStringField
      Alignment = taRightJustify
      FieldName = 'FON_CEPCON'
      EditMask = '99999-999;0;_'
      Size = 8
    end
    object tbContatoFON_CIDADE: TStringField
      FieldName = 'FON_CIDADE'
    end
    object tbContatoFON_UFCONT: TStringField
      FieldName = 'FON_UFCONT'
      Size = 2
    end
    object tbContatoFON_NRFONE: TStringField
      Alignment = taRightJustify
      FieldName = 'FON_NRFONE'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object tbContatoFON_NRCELU: TStringField
      Alignment = taRightJustify
      FieldName = 'FON_NRCELU'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
  end
  object qryContratos: TQuery
    DatabaseName = 'InfoADM'
    SQL.Strings = (
      'Select * from ADMCON')
    Left = 176
    Top = 192
    object qryContratosCON_NRCONT: TStringField
      FieldName = 'CON_NRCONT'
      Origin = 'INFOADM."ADMCON.DB".CON_NRCONT'
      EditMask = '99999/9999;0;_'
      Size = 9
    end
    object qryContratosCON_CDCLIE: TStringField
      FieldName = 'CON_CDCLIE'
      Origin = 'INFOADM."ADMCON.DB".CON_CDCLIE'
      Size = 7
    end
    object qryContratosCON_NMCLIE: TStringField
      FieldName = 'CON_NMCLIE'
      Origin = 'INFOADM."ADMCON.DB".CON_NMCLIE'
      Size = 50
    end
  end
  object qryFuncionario: TQuery
    DatabaseName = 'InfoADM'
    SQL.Strings = (
      'Select * from ADMFUN')
    Left = 112
    Top = 280
  end
  object qryVendedor: TQuery
    DatabaseName = 'InfoADM'
    SQL.Strings = (
      'Select * from ADMVEN')
    Left = 176
    Top = 248
  end
  object qryContatos: TQuery
    DatabaseName = 'InfoADM'
    SQL.Strings = (
      'Select * from ADMFON')
    Left = 256
    Top = 248
  end
end
