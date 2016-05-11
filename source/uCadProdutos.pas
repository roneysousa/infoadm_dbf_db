unit uCadProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Buttons, Mask, DB, Grids, DBGrids,
  ToolEdit;

type
  TfrmCadProduto = class(TForm)
    pnlSuperior: TPanel;
    DBText2: TDBText;
    Panel1: TPanel;
    Panel2: TPanel;
    btAdicionar: TBitBtn;
    btEditar: TBitBtn;
    btExcluir: TBitBtn;
    btLocalizar: TBitBtn;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    Label1: TLabel;
    dsProdutos: TDataSource;
    cmbCDFORN: TDBLookupComboBox;
    Label2: TLabel;
    dbeCDPROD: TDBEdit;
    Label3: TLabel;
    dbeCDREFE: TDBEdit;
    Label4: TLabel;
    dbeNMPROD: TDBEdit;
    Label5: TLabel;
    cmbCDFABR: TDBLookupComboBox;
    Label6: TLabel;
    cmbCDUNID: TDBLookupComboBox;
    Label7: TLabel;
    cmbFARMA: TDBLookupComboBox;
    Label8: TLabel;
    DBEdit4: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    cmbCDSECA: TDBLookupComboBox;
    Label11: TLabel;
    dbeVLCUST: TDBEdit;
    Label12: TLabel;
    DBEdit6: TDBEdit;
    Label13: TLabel;
    DBEdit7: TDBEdit;
    Label14: TLabel;
    DBEdit8: TDBEdit;
    Label15: TLabel;
    DBEdit9: TDBEdit;
    Label16: TLabel;
    DBEdit10: TDBEdit;
    Label17: TLabel;
    dbeVLVEND: TDBEdit;
    dsFornecedor: TDataSource;
    dsGrupos: TDataSource;
    dsSecoes: TDataSource;
    dsUnidade: TDataSource;
    edtNMGRUP: TEdit;
    GridGrupo: TDBGrid;
    GridProdutos: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure GridProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dsProdutosStateChange(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure dsProdutosDataChange(Sender: TObject; Field: TField);
    procedure cmbCDFORNExit(Sender: TObject);
    procedure cmbCDFABRExit(Sender: TObject);
    procedure cmbCDUNIDExit(Sender: TObject);
    procedure cmbFARMAExit(Sender: TObject);
    procedure cmbCDSECAExit(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure dbeNMPRODExit(Sender: TObject);
    procedure edtNMGRUPEnter(Sender: TObject);
    procedure btLocalizarClick(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure dbeNMPRODKeyPress(Sender: TObject; var Key: Char);
    procedure edtNMGRUPKeyPress(Sender: TObject; var Key: Char);
    procedure GridGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure GridGrupoExit(Sender: TObject);
  private
    Procedure Adicionar_Grupos;
    Procedure Localizar_Grupo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

uses udmInfoADM, uPrincipal,uFuncoes, uLocProduto;

{$R *.dfm}

procedure TfrmCadProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     If (dsProdutos.State in [dsInsert, dsEdit]) Then
     begin
          If Application.MessageBox('Salvar alterações?', 'ATENÇÃO',
                    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = ID_YES Then
          begin
               Action := caNone;
               btGravar.SetFocus;
               Exit;
          End
          Else
              btCancelarClick(Sender);
     End;
     //
     dmInfoADM.tbProdutos.Close;
     dmInfoADM.tbFornedores.Close;
     dmInfoADM.qryGrupos.Close;
     dmInfoADM.tbSecao.Close;
     dmInfoADM.tbUnidade.Close;
     //
     uFuncoes.Limpar_Status;
     frmPrincipal.mnuNavegacao.Enabled := False;
     //
     Action := caFree;
end;

procedure TfrmCadProduto.FormActivate(Sender: TObject);
begin
     If (dmInfoADM.tbParametros.Active = False) Then
        dmInfoADM.tbParametros.Open;
     If (dmInfoADM.tbProdutos.Active = False) Then
        dmInfoADM.tbProdutos.Open;
     If (dmInfoADM.tbFornedores.Active = False) Then
        dmInfoADM.tbFornedores.Open;
     dmInfoADM.tbFornedores.IndexFieldNames := 'FOR_NMFORN';
     //
     If (dmInfoADM.qryGrupos.Active = False) Then
        dmInfoADM.qryGrupos.Open;
     //
     If (dmInfoADM.tbSecao.Active = False) Then
        dmInfoADM.tbSecao.Open;
     If (dmInfoADM.tbUnidade.Active = False) then
        dmInfoADM.tbUnidade.Open;
     //
     dmInfoADM.tbProdutos.IndexFieldNames := 'PRO_NMPROD';
     dmInfoADM.tbProdutos.First;
     //
     frmPrincipal.mnuNavegacao.Enabled := True;
     GridProdutos.Align := alClient;
end;

procedure TfrmCadProduto.GridProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmCadProduto.dsProdutosStateChange(Sender: TObject);
begin
    btAdicionar.Enabled := dsProdutos.State in [dsBrowse];
    btEditar.Enabled    := dsProdutos.State in [dsBrowse];
    btExcluir.Enabled   := dsProdutos.State in [dsBrowse];
    btLocalizar.Enabled := dsProdutos.State in [dsBrowse];
    //
    btGravar.Enabled   := dsProdutos.State in [dsInsert,dsEdit];
    btCancelar.Enabled := dsProdutos.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuPrimeiroItem .Enabled  := dsProdutos.State in [dsBrowse];
    frmPrincipal.mnuAnteriorItem.Enabled   := dsProdutos.State in [dsBrowse];
    frmPrincipal.mnuProximoItem.Enabled    := dsProdutos.State in [dsBrowse];
    frmPrincipal.mnuUltimo.Enabled         := dsProdutos.State in [dsBrowse];
    //
    frmPrincipal.mnuAdicionarItem.Enabled := dsProdutos.State in [dsBrowse];
    frmPrincipal.mnuEditarItem.Enabled    := dsProdutos.State in [dsBrowse];
    frmPrincipal.mnuExcluirItem.Enabled   := dsProdutos.State in [dsBrowse];
    ///
    frmPrincipal.mnuGravarItem.Enabled   := dsProdutos.State in [dsInsert,dsEdit];
    frmPrincipal.mnuCancelarItem.Enabled := dsProdutos.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuLocalizarItem.Enabled   := dsProdutos.State in [dsBrowse];
    GridProdutos.Visible := dsProdutos.State in [dsBrowse];
    //
    {If (dsProdutos.State in [dsInsert,dsEdit]) Then
        edtNMGRUP.Top := cmbCDGRUP.Top;} 
end;

procedure TfrmCadProduto.btCancelarClick(Sender: TObject);
begin
      dmInfoADM.tbProdutos.Cancel; 
end;

procedure TfrmCadProduto.btEditarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbProdutos.Edit;
          Adicionar_Grupos;
          Localizar_Grupo;
          dbeCDREFE.SetFocus;
     Except
          Application.MessageBox('Este registro não pode ser alterado agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
     End;
end;

procedure TfrmCadProduto.btExcluirClick(Sender: TObject);
begin
    Try
        If Application.MessageBox('Deseja eliminar este registro?', 'Exclusão de registro',
                    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = ID_YES Then
           dmInfoADM.tbProdutos.delete;             // Apagar o regitro atual.
    Except
          Application.MessageBox('Este registro não pode ser excluido agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
    End;
end;

procedure TfrmCadProduto.dsProdutosDataChange(Sender: TObject;
  Field: TField);
begin
     frmPrincipal.StatusBar1.Panels[2].Text := ' Registro: ' + IntToStr(dsProdutos.DataSet.RecNo) +
                          ' de ' + IntToStr(dsProdutos.DataSet.RecordCount);
end;

procedure TfrmCadProduto.cmbCDFORNExit(Sender: TObject);
begin
   If (dsProdutos.State in [dsInsert,dsEdit]) Then
   begin
     If uFuncoes.Empty(cmbCDFORN.Text) Then
     begin
          Application.MessageBox('Selecione o fornecedor!!!','ATENÇÃO',
             MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
          cmbCDFORN.SetFocus;
     End;
   End;
end;

procedure TfrmCadProduto.cmbCDFABRExit(Sender: TObject);
begin
   If (dsProdutos.State in [dsInsert,dsEdit]) Then
   begin
     If uFuncoes.Empty(cmbCDFABR.Text) Then
     begin
          Application.MessageBox('Selecione o fabricante!!!','ATENÇÃO',
             MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
          cmbCDFABR.SetFocus;
     End;
     //
     dmInfoADM.tbProdutos.FieldByName('PRO_NMFABR').AsString := cmbCDFABR.Text;   
   End;
end;

procedure TfrmCadProduto.cmbCDUNIDExit(Sender: TObject);
begin
   If (dsProdutos.State in [dsInsert,dsEdit]) Then
   begin
     If uFuncoes.Empty(cmbCDUNID.Text) Then
     begin
          Application.MessageBox('Selecione a unidade!!!','ATENÇÃO',
             MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
          cmbCDUNID.SetFocus;
     End;
   End;
end;

procedure TfrmCadProduto.cmbFARMAExit(Sender: TObject);
begin
   If (dsProdutos.State in [dsInsert,dsEdit]) Then
   begin
     If uFuncoes.Empty(cmbFARMA.Text) Then
     begin
          Application.MessageBox('Selecione a forma de armazenamento!!!','ATENÇÃO',
             MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
          cmbFARMA.SetFocus;
     End;
   End;
end;

procedure TfrmCadProduto.cmbCDSECAExit(Sender: TObject);
begin
   If (dsProdutos.State in [dsInsert,dsEdit]) Then
   begin
     If uFuncoes.Empty(cmbCDSECA.Text) Then
     begin
          Application.MessageBox('Selecione a seção!!!','ATENÇÃO',
             MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
          cmbCDSECA.SetFocus;
          Exit;
     End;
   End;
   //
   Adicionar_Grupos;
end;

procedure TfrmCadProduto.btGravarClick(Sender: TObject);
begin
     Try
         If (dsProdutos.State in [dsInsert,dsEdit]) Then
         begin
               If uFuncoes.Empty(dbeNMPROD.Text) Then
               begin
                    Application.MessageBox('Digite a descrição do produto!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeNMPROD.SetFocus;
                    Exit;
               End;
               //
               If uFuncoes.Empty(dbeVLVEND.Text) Then
               begin
                    Application.MessageBox('Digite o valor de venda!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeVLVEND.SetFocus;
                    Exit;
               End;
         End;
         //
         If (dsProdutos.State in [dsInsert]) Then
         begin
              If (dmInfoADM.tbParametros.Active = False) Then
                  dmInfoADM.tbParametros.Open;
              //
              dmInfoADM.tbParametros.Edit;
              dmInfoADM.tbParametros.FieldByName('PAR_CDPROD').AsFloat :=
                dmInfoADM.tbParametros.FieldByName('PAR_CDPROD').AsFloat+1;
              dmInfoADM.tbParametros.Post;
              //
              dmInfoADM.tbProdutos.FieldByName('PRO_CDPROD').AsString :=
                 uFuncoes.StrZero(dmInfoADM.tbParametros.FieldByName('PAR_CDPROD').AsString,14);
         End;
         //
         {If (dmInfoADM.qryGrupos.Locate('GRU_CDSECA;GRU_NMGRUP',
             VarArrayOf([dmInfoADM.tbProdutos.FieldByName('PRO_CDSECA').AsString,
                         cmbCDGRUP.Text]),[])) Then
             dmInfoADM.tbProdutos.FieldByName('PRO_CDGRUP').AsString :=
                 dmInfoADM.qryGrupos.FieldByName('GRU_CDGRUP').AsString;}
         //
         dmInfoADM.tbProdutos.Post;
     Except
          Application.MessageBox('Error ao tentar gravar registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbProdutos.Cancel;
     End;
end;

procedure TfrmCadProduto.dbeNMPRODExit(Sender: TObject);
begin
     If (dsProdutos.State in [dsInsert,dsEdit]) Then
     begin
          If uFuncoes.Empty(dbeNMPROD.Text) Then
          begin
               Application.MessageBox('Digite a descrição do produto!!!','ATENÇÃO',
                      MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dbeNMPROD.SetFocus;
               dmInfoADM.tbProdutos.FieldByName('PRO_NMPROD').AsString := '';
               dbeNMPROD.Clear;
               Exit;
          End;
     End;
     //
     If (dsProdutos.State in [dsInsert]) Then
     begin
          If (dmInfoADM.ValidaCampo(dmInfoADM.tbProdutos ,'PRO_NMPROD',dbeNMPROD.Text)) Then
          begin
               Application.MessageBox('Produto já cadastrado.',
                               'ATENÇÃO', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dbeNMPROD.Clear;
               dbeNMPROD.SetFocus;
               Exit;
          End;
     End;
end;

procedure TfrmCadProduto.Adicionar_Grupos;
Var
    W_CDSECA : String;
begin
     W_CDSECA := dmInfoADM.tbProdutos.fieldByName('PRO_CDSECA').AsString;
     With dmInfoADM.qryGrupos do
     begin
          SQL.Clear;
          Close;
          SQL.Add('Select * from ADMGRU');
          SQL.Add('Where GRU_CDSECA='+quotedstr(W_CDSECA));
          SQL.Add('order by GRU_NMGRUP');
          Prepare;
          Open;
     End;
     //
     dmInfoADM.qryGrupos.First;
     //cmbCDGRUP.Clear;
     {While not (dmInfoADM.qryGrupos.Eof) do
     begin
          cmbCDGRUP.Items.Add(dmInfoADM.qryGrupos.fieldByName('GRU_NMGRUP').AsString);
          dmInfoADM.qryGrupos.Next;
     End;}
end;

procedure TfrmCadProduto.Localizar_Grupo;
Var
    W_CDSECA,W_CDGRUP:String;
begin
     W_CDSECA := dmInfoADM.tbProdutos.FieldByName('PRO_CDSECA').AsString;
     W_CDGRUP := dmInfoADM.tbProdutos.FieldByName('PRO_CDGRUP').AsString;
     //
     If (dmInfoADM.qryGrupos.Locate('GRU_CDGRUP;GRU_CDSECA', VarArrayOf([W_CDGRUP,W_CDSECA]),[])) Then
          edtNMGRUP.Text  := dmInfoADM.qryGrupos.FieldByName('GRU_NMGRUP').AsString
     Else
         ShowMessage('Não encontrou!!!');
end;

procedure TfrmCadProduto.edtNMGRUPEnter(Sender: TObject);
begin
{     edtNMGRUP.Visible := False;
     cmbCDGRUP.Visible := True;}
end;

procedure TfrmCadProduto.btLocalizarClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmLocProduto, frmLocProduto);
      frmLocProduto.Caption := 'Localizar Produto';
      frmLocProduto.ShowModal;
  Finally
      frmLocProduto.Free;
  End;
end;

procedure TfrmCadProduto.btAdicionarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbProdutos.Append;
          cmbCDFORN.SetFocus;
     Except
          Application.MessageBox('Error ao tentar incluir registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbProdutos.Cancel;
     End;
end;

procedure TfrmCadProduto.dbeNMPRODKeyPress(Sender: TObject; var Key: Char);
begin
     If (Key = #27) Then
     begin
          Key := #0;
          dmInfoADM.tbProdutos.Cancel; 
     End;
end;

procedure TfrmCadProduto.edtNMGRUPKeyPress(Sender: TObject; var Key: Char);
begin
     If (Key = #13) Then
     begin
          Key := #0;
          GridGrupo.Visible := True;
          GridGrupo.SetFocus;
     End;
end;

procedure TfrmCadProduto.GridGrupoKeyPress(Sender: TObject; var Key: Char);
begin
     If (Key = #13) Then
     begin
          Key := #0;
          dmInfoADM.tbProdutos.FieldByName('PRO_CDGRUP').AsString :=
              dmInfoADM.tbGrupos.FieldByName('GRU_CDGRUP').AsString;
          GridGrupo.Visible := False;
          Localizar_Grupo;
          dbeVLCUST.SetFocus;  
     End;
end;

procedure TfrmCadProduto.GridGrupoExit(Sender: TObject);
begin
     GridGrupo.Visible := False;
end;

end.
