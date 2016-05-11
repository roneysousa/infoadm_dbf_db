unit udmInfoADM;

interface

uses
  SysUtils, Classes, DB, DBTables,DBIProcs, Forms;

type
  TdmInfoADM = class(TDataModule)
    bdInfoADM: TDatabase;
    tbParametros: TTable;
    tbFornedores: TTable;
    tbFornedoresFOR_CDFORN: TStringField;
    tbFornedoresFOR_NMFORN: TStringField;
    tbFornedoresFOR_RAFORN: TStringField;
    tbFornedoresFOR_CGCFOR: TStringField;
    tbFornedoresFOR_ENDERE: TStringField;
    tbFornedoresFOR_BAIRRO: TStringField;
    tbFornedoresFOR_NRFONE: TStringField;
    tbFornedoresFOR_FAXFOR: TStringField;
    tbFornedoresFOR_NRRAMA: TStringField;
    tbFornedoresFOR_NRTELE: TStringField;
    tbFornedoresFOR_CIDADE: TStringField;
    tbFornedoresFOR_UFFORN: TStringField;
    tbFornedoresFOR_CEPFOR: TStringField;
    tbFornedoresFOR_INESTA: TStringField;
    tbFornedoresFOR_NMCONT: TStringField;
    tbFornedoresFOR_CACONT: TStringField;
    tbFornedoresFOR_FONECO: TStringField;
    tbFornedoresFOR_RAMACO: TStringField;
    tbFornedoresFOR_EMAIL1: TStringField;
    tbFornedoresFOR_EMAIL2: TStringField;
    tbFornedoresFOR_HOMEPG: TStringField;
    tbFornedoresFOR_PEJURO: TFloatField;
    tbFornedoresFOR_PEMULT: TFloatField;
    qryFornecedor: TQuery;
    tbProdutos: TTable;
    qryProdutos: TQuery;
    tbProdutosPRO_CDPROD: TStringField;
    tbProdutosPRO_CDREFE: TStringField;
    tbProdutosPRO_CDFORN: TStringField;
    tbProdutosPRO_NMPROD: TStringField;
    tbProdutosPRO_CDFABR: TStringField;
    tbProdutosPRO_NMFABR: TStringField;
    tbProdutosPRO_CDUNID: TStringField;
    tbProdutosPRO_FMARMA: TStringField;
    tbProdutosPRO_QTARMA: TFloatField;
    tbProdutosPRO_PEARMA: TFloatField;
    tbProdutosPRO_CDGRUP: TStringField;
    tbProdutosPRO_CDSECA: TStringField;
    tbProdutosPRO_PELUCR: TFloatField;
    tbProdutosPRO_PEICMS: TFloatField;
    tbProdutosPRO_PERIPI: TFloatField;
    tbProdutosPRO_PESOCI: TFloatField;
    tbProdutosPRO_PEFINA: TFloatField;
    tbProdutosPRO_VLCUST: TCurrencyField;
    tbProdutosPRO_VLVEND: TCurrencyField;
    tbProdutosPRO_DTATUA: TDateField;
    tbProdutosPRO_VLSAID: TFloatField;
    tbProdutosPRO_VLMACU: TFloatField;
    tbGrupos: TTable;
    tbSecao: TTable;
    tbSecaoSEC_CDSECA: TStringField;
    tbSecaoSEC_NMSECA: TStringField;
    tbSecaoSEC_PECOMI: TFloatField;
    tbProdutosPRO_OBSERV: TStringField;
    tbUnidade: TTable;
    tbUnidadeUNI_CDUNID: TStringField;
    tbUnidadeUNI_NMUNID: TStringField;
    qryGrupos: TQuery;
    tbGruposGRU_CDSECA: TStringField;
    tbGruposGRU_CDGRUP: TStringField;
    tbGruposGRU_NMGRUP: TStringField;
    tbSituacao: TTable;
    tbSituacaoSIT_CDSITU: TStringField;
    tbSituacaoSIT_NMSITU: TStringField;
    tbClientes: TTable;
    tbClientesCLI_CDCLIE: TStringField;
    tbClientesCLI_NMCLIE: TStringField;
    tbClientesCLI_RASOCI: TStringField;
    tbClientesCLI_ENCLIE: TStringField;
    tbClientesCLI_CEPCLI: TStringField;
    tbClientesCLI_BACLIE: TStringField;
    tbClientesCLI_CICLIE: TStringField;
    tbClientesCLI_UFCLIE: TStringField;
    tbClientesCLI_NRFONE: TStringField;
    tbClientesCLI_NRRAMA: TStringField;
    tbClientesCLI_NUMFAX: TStringField;
    tbClientesCLI_NRCELU: TStringField;
    tbClientesCLI_CPFCGC: TStringField;
    tbClientesCLI_INSEST: TStringField;
    tbClientesCLI_NMCONT: TStringField;
    tbClientesCLI_VLDEBI: TFloatField;
    tbClientesCLI_CDSITU: TStringField;
    tbClientesCLI_EMAIL1: TStringField;
    tbClientesCLI_EMAIL2: TStringField;
    tbClientesCLI_HOMEPG: TStringField;
    tbClientesCLI_DTCADA: TDateField;
    tbClientesCLI_NRREGI: TMemoField;
    tbClientesCLI_NMSITU: TStringField;
    qryClientes: TQuery;
    tbProCliente: TTable;
    tbProClientePCL_CDCLIE: TStringField;
    tbProClientePCL_CDPROD: TStringField;
    tbProClientePCL_NMPROD: TStringField;
    tbContratos: TTable;
    tbContratosCON_NRCONT: TStringField;
    tbContratosCON_CDCLIE: TStringField;
    tbContratosCON_NMCLIE: TStringField;
    tbContratosCON_DTCONT: TDateField;
    tbContratosCON_DTVENC: TDateField;
    tbContratosCON_DTENCE: TDateField;
    tbContratosCON_DIACAR: TSmallintField;
    tbContratosCON_DIAFAT: TStringField;
    tbContratosCON_VLCONT: TFloatField;
    tbContratosCON_PEMULT: TFloatField;
    tbContratosCON_PEJURO: TFloatField;
    tbContratosCON_FLSITU: TStringField;
    tbContratosCON_FLCOBR: TStringField;
    tbContratosCON_NMCLIE2: TStringField;
    tbFuncionarios: TTable;
    tbFuncionariosFUN_CDFUNC: TStringField;
    tbFuncionariosFUN_NMFUNC: TStringField;
    tbFuncionariosFUN_ENDERE: TStringField;
    tbFuncionariosFUN_BAIRRO: TStringField;
    tbFuncionariosFUN_CIDADE: TStringField;
    tbFuncionariosFUN_UFFUNC: TStringField;
    tbFuncionariosFUN_CEPFUN: TStringField;
    tbFuncionariosFUN_NRFONE: TStringField;
    tbFuncionariosFUN_NRCELU: TStringField;
    tbFuncionariosFUN_NRIDEN: TStringField;
    tbFuncionariosFUN_ORIDEN: TStringField;
    tbFuncionariosFUN_UFIDEN: TStringField;
    tbFuncionariosFUN_NRTITU: TStringField;
    tbFuncionariosFUN_ZOTITU: TStringField;
    tbFuncionariosFUN_SETITU: TStringField;
    tbFuncionariosFUN_CPFCGC: TStringField;
    tbFuncionariosFUN_NMCARG: TStringField;
    tbFuncionariosFUN_DTADMI: TStringField;
    tbFuncionariosFUN_DTRECI: TStringField;
    tbFuncionariosFUN_INESTA: TStringField;
    tbFuncionariosFUN_FIESTA: TStringField;
    tbFuncionariosFUN_HORARI: TStringField;
    tbFuncionariosFUN_DTNASC: TStringField;
    tbFuncionariosFUN_VLSALA: TFloatField;
    tbVendedores: TTable;
    tbVendedoresVEN_CDVEND: TStringField;
    tbVendedoresVEN_NMVEND: TStringField;
    tbVendedoresVEN_ENDVEN: TStringField;
    tbVendedoresVEN_BAVEND: TStringField;
    tbVendedoresVEN_CIVEND: TStringField;
    tbVendedoresVEN_UFVEND: TStringField;
    tbVendedoresVEN_CEPVEN: TStringField;
    tbVendedoresVEN_NRFONE: TStringField;
    tbVendedoresVEN_PECOMI: TFloatField;
    tbContato: TTable;
    tbContatoFON_NMCONT: TStringField;
    tbContatoFON_NMEMPR: TStringField;
    tbContatoFON_ENDERE: TStringField;
    tbContatoFON_BAIRRO: TStringField;
    tbContatoFON_CEPCON: TStringField;
    tbContatoFON_CIDADE: TStringField;
    tbContatoFON_UFCONT: TStringField;
    tbContatoFON_NRFONE: TStringField;
    tbContatoFON_NRCELU: TStringField;
    qryContratos: TQuery;
    qryContratosCON_NRCONT: TStringField;
    qryContratosCON_CDCLIE: TStringField;
    qryContratosCON_NMCLIE: TStringField;
    qryFuncionario: TQuery;
    qryVendedor: TQuery;
    qryContatos: TQuery;
    procedure tbParametrosAfterPost(DataSet: TDataSet);
    procedure tbFornedoresAfterPost(DataSet: TDataSet);
    procedure tbProdutosAfterPost(DataSet: TDataSet);
    procedure tbGruposAfterPost(DataSet: TDataSet);
    procedure tbSecaoAfterPost(DataSet: TDataSet);
    procedure tbUnidadeAfterPost(DataSet: TDataSet);
    procedure tbSituacaoAfterPost(DataSet: TDataSet);
    procedure tbClientesAfterPost(DataSet: TDataSet);
    procedure tbProClienteAfterPost(DataSet: TDataSet);
    procedure tbContratosAfterPost(DataSet: TDataSet);
    procedure tbFuncionariosAfterPost(DataSet: TDataSet);
    procedure tbVendedoresAfterPost(DataSet: TDataSet);
    procedure tbContatoAfterPost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
     function ValidaCampo(Table: TTable; Campo, Text: String): Boolean;  
    { Public declarations }
  end;

var
  dmInfoADM: TdmInfoADM;

implementation

{$R *.dfm}

procedure TdmInfoADM.tbParametrosAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbParametros.Handle);     //Evitando Perdas de Dados.
     tbParametros.FlushBuffers;
     tbParametros.Refresh;
end;

procedure TdmInfoADM.tbFornedoresAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbFornedores.Handle);     //Evitando Perdas de Dados.
     tbFornedores.FlushBuffers;
     tbFornedores.Refresh;
end;

procedure TdmInfoADM.tbProdutosAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbProdutos.Handle);     //Evitando Perdas de Dados.
     tbProdutos.FlushBuffers;
     tbProdutos.Refresh;
end;

procedure TdmInfoADM.tbGruposAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbGrupos.Handle);     //Evitando Perdas de Dados.
     tbGrupos.FlushBuffers;
     tbGrupos.Refresh;
end;

procedure TdmInfoADM.tbSecaoAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbSecao.Handle);     //Evitando Perdas de Dados.
     tbSecao.FlushBuffers;
     tbSecao.Refresh;
end;

procedure TdmInfoADM.tbUnidadeAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbUnidade.Handle);     //Evitando Perdas de Dados.
     tbUnidade.FlushBuffers;
     tbUnidade.Refresh;
end;

function TdmInfoADM.ValidaCampo(Table: TTable; Campo,
  Text: String): Boolean;
Var
  Tabela : TTable;
begin
    Tabela := TTable.Create(Application);
    Tabela.DatabaseName := Table.DatabaseName;
    Tabela.TableName := Table.TableName;
    Tabela.Open;
    If Not(Tabela.Locate(Campo,Text,[])) Then
    begin
        result := False;
        Tabela.Free;
    end
    Else
    Begin
        result := True;
        Tabela.Free;
    End;
end;

procedure TdmInfoADM.tbSituacaoAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbSituacao.Handle);     //Evitando Perdas de Dados.
     tbSituacao.FlushBuffers;
     tbSituacao.Refresh;
end;

procedure TdmInfoADM.tbClientesAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbClientes.Handle);     //Evitando Perdas de Dados.
     tbClientes.FlushBuffers;
     tbClientes.Refresh;
end;

procedure TdmInfoADM.tbProClienteAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbProCliente.Handle);     //Evitando Perdas de Dados.
     tbProCliente.FlushBuffers;
     tbProCliente.Refresh;
end;

procedure TdmInfoADM.tbContratosAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbContratos.Handle);     //Evitando Perdas de Dados.
     tbContratos.FlushBuffers;
     tbContratos.Refresh;
end;

procedure TdmInfoADM.tbFuncionariosAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbFuncionarios.Handle);     //Evitando Perdas de Dados.
     tbFuncionarios.FlushBuffers;
     tbFuncionarios.Refresh;
end;

procedure TdmInfoADM.tbVendedoresAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbVendedores.Handle);     //Evitando Perdas de Dados.
     tbVendedores.FlushBuffers;
     tbVendedores.Refresh;
end;

procedure TdmInfoADM.tbContatoAfterPost(DataSet: TDataSet);
begin
     DBISaveChanges(tbContato.Handle);     //Evitando Perdas de Dados.
     tbContato.FlushBuffers;
     tbContato.Refresh;
end;

procedure TdmInfoADM.DataModuleCreate(Sender: TObject);
begin
     { se o alias não existir... }
     If not Session.IsAlias('InfoADM') then
     begin
          { Adiciona o alias }
          Session.AddStandardAlias('InfoADM', 'C:\INFOG2\InfoADM\Dados', 'PARADOX');
          { Salva o arquivo de configuração do BDE }
          Session.SaveConfigFile;
     end;
     //
     bdInfoADM.Open;
end;

end.
