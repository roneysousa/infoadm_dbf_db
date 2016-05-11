unit uCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, DB, Mask, Buttons, Grids, DBGrids;

type
  TfrmCadClientes = class(TForm)
    pnlSuperior: TPanel;
    DBText2: TDBText;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsClientes: TDataSource;
    Label2: TLabel;
    dbeNMCLIE: TDBEdit;
    Label3: TLabel;
    dbeRZSOCIAL: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    cmbUFCLIE: TDBComboBox;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    Label11: TLabel;
    DBEdit10: TDBEdit;
    Label10: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    DBEdit14: TDBEdit;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    Label16: TLabel;
    DBEdit16: TDBEdit;
    Label17: TLabel;
    DBEdit17: TDBEdit;
    Label18: TLabel;
    DBEdit18: TDBEdit;
    Label19: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    btAdicionar: TBitBtn;
    btEditar: TBitBtn;
    btExcluir: TBitBtn;
    btLocalizar: TBitBtn;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    GridClientes: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsClientesStateChange(Sender: TObject);
    procedure dsClientesDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure GridClientesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btCancelarClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure dbeNMCLIEExit(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure dbeNMCLIEKeyPress(Sender: TObject; var Key: Char);
    procedure btLocalizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadClientes: TfrmCadClientes;

implementation

uses udmInfoADM, uPrincipal,uFuncoes, uLocClientes;

{$R *.dfm}

procedure TfrmCadClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     dmInfoADM.tbClientes.Close;
     dmInfoADM.tbSituacao.Close;
     //
     frmPrincipal.mnuNavegacao.Enabled := False;     
     //
     Action := caFree;
end;

procedure TfrmCadClientes.dsClientesStateChange(Sender: TObject);
begin
    btAdicionar.Enabled := dsClientes.State in [dsBrowse];
    btEditar.Enabled    := dsClientes.State in [dsBrowse];
    btExcluir.Enabled   := dsClientes.State in [dsBrowse];
    btLocalizar.Enabled := dsClientes.State in [dsBrowse];
    //
    btGravar.Enabled   := dsClientes.State in [dsInsert,dsEdit];
    btCancelar.Enabled := dsClientes.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuPrimeiroItem .Enabled  := dsClientes.State in [dsBrowse];
    frmPrincipal.mnuAnteriorItem.Enabled   := dsClientes.State in [dsBrowse];
    frmPrincipal.mnuProximoItem.Enabled    := dsClientes.State in [dsBrowse];
    frmPrincipal.mnuUltimo.Enabled         := dsClientes.State in [dsBrowse];
    //
    frmPrincipal.mnuAdicionarItem.Enabled := dsClientes.State in [dsBrowse];
    frmPrincipal.mnuEditarItem.Enabled    := dsClientes.State in [dsBrowse];
    frmPrincipal.mnuExcluirItem.Enabled   := dsClientes.State in [dsBrowse];
    ///
    frmPrincipal.mnuGravarItem.Enabled   := dsClientes.State in [dsInsert,dsEdit];
    frmPrincipal.mnuCancelarItem.Enabled := dsClientes.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuLocalizarItem.Enabled   := dsClientes.State in [dsBrowse];
    GridClientes.Visible := dsClientes.State in [dsBrowse];
end;

procedure TfrmCadClientes.dsClientesDataChange(Sender: TObject;
  Field: TField);
begin
     frmPrincipal.StatusBar1.Panels[2].Text := ' Registro: ' + IntToStr(dsClientes.DataSet.RecNo) +
                          ' de ' + IntToStr(dsClientes.DataSet.RecordCount);
end;

procedure TfrmCadClientes.FormActivate(Sender: TObject);
begin
     If (dmInfoADM.tbParametros.Active = False) Then
        dmInfoADM.tbParametros.Open;
     //
     If (dmInfoADM.tbClientes.Active = False) Then
        dmInfoADM.tbClientes.Open;
        dmInfoADM.tbClientes.IndexFieldNames := 'CLI_NMCLIE';
        dmInfoADM.tbClientes.First; 
     //
     If (dmInfoADM.tbSituacao.Active = False) Then
        dmInfoADM.tbSituacao.Open;
     //
     frmPrincipal.mnuNavegacao.Enabled := True;
     GridClientes.Align := alClient;
end;

procedure TfrmCadClientes.GridClientesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmCadClientes.btCancelarClick(Sender: TObject);
begin
     dmInfoADM.tbClientes.Cancel;  
end;

procedure TfrmCadClientes.btEditarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbClientes.Edit;
          dbeNMCLIE.SetFocus;
     Except
          Application.MessageBox('Este registro não pode ser alterado agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbClientes.Cancel;           
     End;
end;

procedure TfrmCadClientes.dbeNMCLIEExit(Sender: TObject);
begin
     If (dsClientes.State in [dsInsert,dsEdit]) Then
     begin
          If uFuncoes.Empty(dbeNMCLIE.Text) Then
          begin
               Application.MessageBox('Digite o nome do cliente!!!','ATENÇÃO',
                      MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dbeNMCLIE.SetFocus;
               //dmInfoADM.tbProdutos.FieldByName('PRO_NMPROD').AsString := '';
               dbeNMCLIE.Clear;
               Exit;
          End;
     End;
     //
     If (dsClientes.State in [dsInsert]) Then
     begin
          If (dmInfoADM.ValidaCampo(dmInfoADM.tbClientes ,'CLI_NMCLIE',dbeNMCLIE.Text)) Then
          begin
               Application.MessageBox('Cliente já cadastrado.',
                               'ATENÇÃO', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dbeNMCLIE.Clear;
               dbeNMCLIE.SetFocus;
               Exit;
          End;
     End;
end;

procedure TfrmCadClientes.btExcluirClick(Sender: TObject);
begin
    Try
        If Application.MessageBox('Deseja eliminar este registro?', 'Exclusão de registro',
                    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = ID_YES Then
           dmInfoADM.tbClientes.delete;             // Apagar o regitro atual.
    Except
          Application.MessageBox('Este registro não pode ser excluido agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
    End;
end;

procedure TfrmCadClientes.btAdicionarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbClientes.Append;
          dmInfoADM.tbClientes.FieldByName('CLI_DTCADA').AsDateTime :=  Date();
          dbeNMCLIE.SetFocus;
     Except
          Application.MessageBox('Error ao tentar incluir registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbClientes.Cancel;
     End;
end;

procedure TfrmCadClientes.btGravarClick(Sender: TObject);
begin
     Try
         If (dsClientes.State in [dsInsert,dsEdit]) Then
         begin
               If uFuncoes.Empty(dbeNMCLIE.Text) Then
               begin
                    Application.MessageBox('Digite o nome do cliente!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeNMCLIE.SetFocus;
                    Exit;
               End;
               //
               If uFuncoes.Empty(dbeRZSOCIAL.Text) Then
               begin
                    Application.MessageBox('Digite a razão social do cliente!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeRZSOCIAL.SetFocus;
                    Exit;
               End;
         End;
         //
         If (dsClientes.State in [dsInsert]) Then
         begin
              If (dmInfoADM.tbParametros.Active = False) Then
                  dmInfoADM.tbParametros.Open;
              //
              dmInfoADM.tbParametros.Edit;
              dmInfoADM.tbParametros.FieldByName('PAR_CDCLIE').AsFloat :=
                dmInfoADM.tbParametros.FieldByName('PAR_CDCLIE').AsFloat+1;
              dmInfoADM.tbParametros.Post;
              //
              dmInfoADM.tbClientes.FieldByName('CLI_CDCLIE').AsString :=
                 uFuncoes.StrZero(dmInfoADM.tbParametros.FieldByName('PAR_CDCLIE').AsString,7);
         End;
         //
         dmInfoADM.tbClientes.Post;
     Except
          Application.MessageBox('Error ao tentar gravar registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbClientes.Cancel;
     End;
end;

procedure TfrmCadClientes.dbeNMCLIEKeyPress(Sender: TObject;
  var Key: Char);
begin
     If (Key = #27) Then
     begin
          Key := #0;
          dmInfoADM.tbClientes.Cancel; 
     End;
end;

procedure TfrmCadClientes.btLocalizarClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmLocClientes, frmLocClientes);
      frmLocClientes.Caption := 'Localizar Cliente';
      frmLocClientes.ShowModal;
  Finally
      frmLocClientes.Free;
  End;
end;

end.
