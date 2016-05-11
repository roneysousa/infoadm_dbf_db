program InfoADM;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  udmInfoADM in 'udmInfoADM.pas' {dmInfoADM: TDataModule},
  uCadFornecedores in 'uCadFornecedores.pas' {frmCadFornecedor},
  uFuncoes in 'uFuncoes.pas',
  uLocFornecedor in 'uLocFornecedor.pas' {frmLocFornecedor},
  uCadProdutos in 'uCadProdutos.pas' {frmCadProduto},
  uLocProduto in 'uLocProduto.pas' {frmLocProduto},
  uCadCliente in 'uCadCliente.pas' {frmCadClientes},
  uLocClientes in 'uLocClientes.pas' {frmLocClientes},
  uProdutoCliente in 'uProdutoCliente.pas' {frmProdutoClientes},
  uCadContrato in 'uCadContrato.pas' {frmCadContrato},
  uLocContratoClie in 'uLocContratoClie.pas' {frmLocContratoClie},
  uCadFunc in 'uCadFunc.pas' {frmCadFuncionario},
  uCadVendedor in 'uCadVendedor.pas' {frmCadVendedor},
  uCadContato in 'uCadContato.pas' {frmCadContato},
  uLocFunc in 'uLocFunc.pas' {frmLocFunc},
  uLocVendedor in 'uLocVendedor.pas' {frmLocVendedor},
  uLocContatoCliente in 'uLocContatoCliente.pas' {frmLocContato};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmInfoADM, dmInfoADM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
