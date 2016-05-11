unit uProdutoCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, DB, Buttons, Mask,
  RxLookup;

type
  TfrmProdutoClientes = class(TForm)
    pnlSuperior: TPanel;
    DBText2: TDBText;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtCDCLIE: TEdit;
    dsProdutoCliente: TDataSource;
    dsCliente: TDataSource;
    lbl_NMCLIE: TLabel;
    btAdicionar: TBitBtn;
    btEditar: TBitBtn;
    btExcluir: TBitBtn;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    lbl_CODIGO: TLabel;
    dbeCDCLIE: TDBEdit;
    lbl_NMPROD: TLabel;
    cmbNMCLIE: TRxDBLookupCombo;
    dsProduto: TDataSource;
    GridCliente: TDBGrid;
    GridProdutos: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCDCLIEKeyPress(Sender: TObject; var Key: Char);
    procedure GridClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCDCLIEChange(Sender: TObject);
    procedure GridProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GridProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dsProdutoClienteDataChange(Sender: TObject; Field: TField);
    procedure dsProdutoClienteStateChange(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure edtCDCLIEEnter(Sender: TObject);
  private
    Procedure Buscar_Produtos;
    Procedure Esconder_Botoes;
    Procedure Mostrar_Botoes;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutoClientes: TfrmProdutoClientes;
  M_CDCLIE : String;

implementation

Uses udmInfoADM, uFuncoes, uPrincipal;

{$R *.dfm}

procedure TfrmProdutoClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     If (dmInfoADM.qryClientes.Active = True) Then
        dmInfoADM.qryClientes.Close;
     //
     dmInfoADM.tbProdutos.Close;
     dmInfoADM.tbProCliente.Close;
     //
     uFuncoes.Limpar_Status;
     //
     Action := caFree;
end;

procedure TfrmProdutoClientes.edtCDCLIEKeyPress(Sender: TObject;
  var Key: Char);
begin
     If (Key = #13) Then
     begin
          Key := #0;
          If uFuncoes.Empty(edtCDCLIE.Text) Then
          begin
               With dmInfoADM.qryClientes do
               begin
                    SQL.Clear;
                    Close;
                    SQL.Add('Select * from ADMCLI');
                    SQL.Add('order by CLI_NMCLIE');
                    Prepare;
                    Open;
               End;
               //
               GridProdutos.Visible := False;
               GridCliente.Align    := alClient;
               GridCliente.Visible  := True;
          End
          Else
              Buscar_Produtos;
          //
          If not (dmInfoADM.qryClientes.Locate('CLI_CDCLIE',uFuncoes.StrZero(edtCDCLIE.Text,7),[loPartialKey,loCaseInsensitive])) Then
          begin
               Application.MessageBox('Registro de cliente inexistente!', 'ATEN��O',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
                edtCDCLIE.SetFocus;
                Exit
          End;
     End;
end;

procedure TfrmProdutoClientes.GridClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
     If (Key = #13) Then
     begin
          Key := #0;
          GridCliente.Visible  := False;
          //
          edtCDCLIE.Text       := dmInfoADM.qryClientes.fieldByName('CLI_CDCLIE').AsString;
          lbl_NMCLIE.Caption   := dmInfoADM.qryClientes.fieldByName('CLI_NMCLIE').AsString;
          //
          GridProdutos.Align   := alClient;
          GridProdutos.Visible := True;
     End;
end;

procedure TfrmProdutoClientes.edtCDCLIEChange(Sender: TObject);
begin
     //
     M_CDCLIE := '';
     If (GridCliente.Visible = True) Then
     begin
         GridCliente.Align := alClient;
         M_CDCLIE := edtCDCLIE.Text;
         //
         If uFuncoes.StrIsInteger(M_CDCLIE) Then
              dmInfoADM.qryClientes.Locate('CLI_CDCLIE',uFuncoes.StrZero(M_CDCLIE,7),[loPartialKey])
         Else
              dmInfoADM.qryClientes.Locate('CLI_NMCLIE',M_CDCLIE,[loPartialKey,loCaseInsensitive]);
         //
         lbl_NMCLIE.Caption := dmInfoADM.qryClientes.fieldByName('CLI_NMCLIE').AsString;
     End
     Else
     begin
         GridCliente.Align := alClient;
         GridCliente.Visible := True;
         //
         M_CDCLIE := uFuncoes.StrZero(edtCDCLIE.Text,7);
         dmInfoADM.qryClientes.Locate('CLI_CDCLIE',M_CDCLIE,[loPartialKey]);
         lbl_NMCLIE.Caption := dmInfoADM.qryClientes.fieldByName('CLI_NMCLIE').AsString;
     End;
     //
     If uFuncoes.Empty(edtCDCLIE.Text) Then
     begin
         lbl_NMCLIE.Caption   := edtCDCLIE.Text;
         GridCliente.Visible  :=  False;
         GridProdutos.Visible := False;
         Esconder_Botoes;
     End;
end;

procedure TfrmProdutoClientes.GridProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
     If (Key = #27) Then
     begin
          Key := #0;
          GridProdutos.Visible := False;
          //
          edtCDCLIE.Clear;
          edtCDCLIE.SetFocus;
     End;
end;

procedure TfrmProdutoClientes.GridProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmProdutoClientes.GridClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmProdutoClientes.FormActivate(Sender: TObject);
begin
     If (dmInfoADM.tbProdutos.Active = False) then
         dmInfoADM.tbProdutos.Open;
     dmInfoADM.tbProdutos.IndexFieldNames := 'PRO_NMPROD';
     //
     If (dmInfoADM.tbProCliente.Active = False) Then
         dmInfoADM.tbProCliente.Open;
    //
    Esconder_Botoes;
    //
    With dmInfoADM.qryClientes do
    begin
         SQL.Clear;
         Close;
         SQL.Add('Select * from ADMCLI');
         SQL.Add('order  by CLI_NMCLIE');
         Prepare;
         Open;
    End;
end;

procedure TfrmProdutoClientes.Buscar_Produtos;
Var
   W_CDCLIE : String;
begin
     W_CDCLIE := dmInfoADM.qryClientes.fieldByName('CLI_CDCLIE').AsString;
     //
     dmInfoADM.tbProCliente.Filtered := False;
     dmInfoADM.tbProCliente.Filter   := 'PCL_CDCLIE='+quotedstr(W_CDCLIE);
     dmInfoADM.tbProCliente.Filtered := True;
     //
     GridCliente.Visible  := False;
     GridProdutos.Align   := alClient;
     GridProdutos.Visible := True;
     //
     edtCDCLIE.Text := W_CDCLIE;
     Mostrar_Botoes;
end;

procedure TfrmProdutoClientes.dsProdutoClienteDataChange(Sender: TObject;
  Field: TField);
begin
     frmPrincipal.StatusBar1.Panels[2].Text := ' Registro: ' + IntToStr(dsProdutoCliente.DataSet.RecNo) +
                          ' de ' + IntToStr(dsProdutoCliente.DataSet.RecordCount);
end;

procedure TfrmProdutoClientes.dsProdutoClienteStateChange(Sender: TObject);
begin
    btAdicionar.Enabled := dsProdutoCliente.State in [dsBrowse];
    btEditar.Enabled    := (dsProdutoCliente.State in [dsBrowse]) And
                           (dmInfoADM.tbProCliente.RecordCount >0);
    btExcluir.Enabled   := (dsProdutoCliente.State in [dsBrowse]) And
                            (dmInfoADM.tbProCliente.RecordCount >0);
    //
    btGravar.Enabled   := dsProdutoCliente.State in [dsInsert,dsEdit];
    btCancelar.Enabled := dsProdutoCliente.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuPrimeiroItem .Enabled  := dsProdutoCliente.State in [dsBrowse];
    frmPrincipal.mnuAnteriorItem.Enabled   := dsProdutoCliente.State in [dsBrowse];
    frmPrincipal.mnuProximoItem.Enabled    := dsProdutoCliente.State in [dsBrowse];
    frmPrincipal.mnuUltimo.Enabled         := dsProdutoCliente.State in [dsBrowse];
    //
    frmPrincipal.mnuAdicionarItem.Enabled := dsProdutoCliente.State in [dsBrowse];
    frmPrincipal.mnuEditarItem.Enabled    := dsProdutoCliente.State in [dsBrowse];
    frmPrincipal.mnuExcluirItem.Enabled   := dsProdutoCliente.State in [dsBrowse];
    ///
    frmPrincipal.mnuGravarItem.Enabled   := dsProdutoCliente.State in [dsInsert,dsEdit];
    frmPrincipal.mnuCancelarItem.Enabled := dsProdutoCliente.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuLocalizarItem.Enabled   := dsProdutoCliente.State in [dsBrowse];
    //
    lbl_CODIGO.Visible := dsProdutoCliente.State in [dsInsert,dsEdit];
    lbl_NMPROD.Visible := dsProdutoCliente.State in [dsInsert,dsEdit];
    dbeCDCLIE.Visible  := dsProdutoCliente.State in [dsInsert,dsEdit];
    cmbNMCLIE.Visible  := dsProdutoCliente.State in [dsInsert,dsEdit];
    //
end;

procedure TfrmProdutoClientes.btEditarClick(Sender: TObject);
begin
     Try
          GridCliente.Visible  := False;
          GridProdutos.Visible := False;
          dmInfoADM.tbProCliente.Edit;
          cmbNMCLIE.SetFocus;
     Except
          Application.MessageBox('Este registro n�o pode ser alterado agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbProCliente.Cancel;
     End;
end;

procedure TfrmProdutoClientes.btExcluirClick(Sender: TObject);
begin
    Try
        If Application.MessageBox('Deseja eliminar este registro?', 'Exclus�o de registro',
                    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = ID_YES Then
           dmInfoADM.tbClientes.delete;             // Apagar o regitro atual.
    Except
          Application.MessageBox('Este registro n�o pode ser excluido agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
    End;
end;

procedure TfrmProdutoClientes.btCancelarClick(Sender: TObject);
begin
     dmInfoADM.tbProCliente.Cancel;             // Apagar o regitro atual.
     GridProdutos.Visible := True;
end;

procedure TfrmProdutoClientes.Esconder_Botoes;
begin
    btAdicionar.Visible := False;
    btEditar.Visible    := False;
    btExcluir.Visible   := False;
    btGravar.Visible    := False;
    btCancelar.Visible  := False;
end;

procedure TfrmProdutoClientes.Mostrar_Botoes;
begin
    btAdicionar.Visible := True;
    btEditar.Visible    := True;
    btExcluir.Visible   := True;
    btGravar.Visible    := True;
    btCancelar.Visible  := True;
end;

procedure TfrmProdutoClientes.btAdicionarClick(Sender: TObject);
begin
     Try
         GridCliente.Visible  := False;
         GridProdutos.Visible := False;
         //
         dmInfoADM.tbProCliente.Append;
         dmInfoADM.tbProCliente.FieldByName('PCL_CDCLIE').AsString :=
             dmInfoADM.qryClientes.FieldByName('CLI_CDCLIE').AsString;
         cmbNMCLIE.SetFocus;
    Except
         Application.MessageBox('Erro ao tentar incluir registros!!!', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
         dmInfoADM.tbProCliente.Cancel;
    End;
end;

procedure TfrmProdutoClientes.btGravarClick(Sender: TObject);
begin
     Try
          If (dsProdutoCliente.State in [dsInsert, dsEdit]) Then
          begin
               If uFuncoes.Empty(cmbNMCLIE.Text) Then
               begin
                    Application.MessageBox('Selecione o produto!!!', 'ATEN��O',
                         MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
                    cmbNMCLIE.SetFocus;
                    Exit;
               End;
          End;
          //
          dmInfoADM.tbProCliente.Post;
          GridProdutos.Visible := True;
     Except
         Application.MessageBox('Erro ao tentar gravar registros!!!', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
         dmInfoADM.tbProCliente.Cancel;
     End;
end;

procedure TfrmProdutoClientes.edtCDCLIEEnter(Sender: TObject);
begin
     edtCDCLIE.Clear; 
end;

end.
