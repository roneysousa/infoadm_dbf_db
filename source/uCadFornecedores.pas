unit uCadFornecedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, DB, Mask, Buttons, Grids, DBGrids;

type
  TfrmCadFornecedor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    pnlSuperior: TPanel;
    DBText2: TDBText;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsFornecedor: TDataSource;
    Label2: TLabel;
    dbeNMFORN: TDBEdit;
    Label3: TLabel;
    dbeRazaoSocial: TDBEdit;
    Label4: TLabel;
    dbeENDERECO: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    dbeNRFONE: TDBEdit;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    dbeNRCGC: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    DBEdit14: TDBEdit;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    Label17: TLabel;
    DBEdit17: TDBEdit;
    Label18: TLabel;
    DBEdit18: TDBEdit;
    Label19: TLabel;
    DBEdit19: TDBEdit;
    DBComboBox1: TDBComboBox;
    btAdicionar: TBitBtn;
    btEditar: TBitBtn;
    btExcluir: TBitBtn;
    btLocalizar: TBitBtn;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    Label10: TLabel;
    DBEdit2: TDBEdit;
    GridFornecedor: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure dsFornecedorStateChange(Sender: TObject);
    procedure dsFornecedorDataChange(Sender: TObject; Field: TField);
    procedure GridFornecedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btEditarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btLocalizarClick(Sender: TObject);
    procedure dbeNRCGCExit(Sender: TObject);
    procedure dbeNMFORNExit(Sender: TObject);
    procedure dbeNMFORNKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadFornecedor: TfrmCadFornecedor;

implementation

Uses uFuncoes,udmInfoADM, uPrincipal, uLocFornecedor;

{$R *.dfm}

procedure TfrmCadFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     If (dsFornecedor.State in [dsInsert, dsEdit]) Then
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
     dmInfoADM.tbFornedores.Close;
     //
     uFuncoes.Limpar_Status;
     frmPrincipal.mnuNavegacao.Enabled := False;
     //
     Action := caFree;
end;

procedure TfrmCadFornecedor.FormActivate(Sender: TObject);
begin
     If (dmInfoADM.tbParametros.Active = False) Then
        dmInfoADM.tbParametros.Open;
     If (dmInfoADM.tbFornedores.Active = False) Then
        dmInfoADM.tbFornedores.Open;
     //
     dmInfoADM.tbFornedores.IndexFieldNames := 'FOR_NMFORN';
     dmInfoADM.tbFornedores.First; 
     //
     frmPrincipal.mnuNavegacao.Enabled := True;
     GridFornecedor.Align := alClient;   
end;

procedure TfrmCadFornecedor.dsFornecedorStateChange(Sender: TObject);
begin
    btAdicionar.Enabled := dsFornecedor.State in [dsBrowse];
    btEditar.Enabled    := dsFornecedor.State in [dsBrowse];
    btExcluir.Enabled   := dsFornecedor.State in [dsBrowse];
    btLocalizar.Enabled := dsFornecedor.State in [dsBrowse];
    //
    btGravar.Enabled   := dsFornecedor.State in [dsInsert,dsEdit];
    btCancelar.Enabled := dsFornecedor.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuPrimeiroItem .Enabled  := dsFornecedor.State in [dsBrowse];
    frmPrincipal.mnuAnteriorItem.Enabled   := dsFornecedor.State in [dsBrowse];
    frmPrincipal.mnuProximoItem.Enabled    := dsFornecedor.State in [dsBrowse];
    frmPrincipal.mnuUltimo.Enabled         := dsFornecedor.State in [dsBrowse];
    //
    frmPrincipal.mnuAdicionarItem.Enabled := dsFornecedor.State in [dsBrowse];
    frmPrincipal.mnuEditarItem.Enabled    := dsFornecedor.State in [dsBrowse];
    frmPrincipal.mnuExcluirItem.Enabled   := dsFornecedor.State in [dsBrowse];
    ///
    frmPrincipal.mnuGravarItem.Enabled   := dsFornecedor.State in [dsInsert,dsEdit];
    frmPrincipal.mnuCancelarItem.Enabled := dsFornecedor.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuLocalizarItem.Enabled   := dsFornecedor.State in [dsBrowse];
    GridFornecedor.Visible := dsFornecedor.State in [dsBrowse];
end;

procedure TfrmCadFornecedor.dsFornecedorDataChange(Sender: TObject;
  Field: TField);
begin
     frmPrincipal.StatusBar1.Panels[2].Text := ' Registro: ' + IntToStr(dsFornecedor.DataSet.RecNo) +
                          ' de ' + IntToStr(dsFornecedor.DataSet.RecordCount);
end;

procedure TfrmCadFornecedor.GridFornecedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmCadFornecedor.btEditarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbFornedores.Edit;
          dbeNMFORN.SetFocus;
     Except
          Application.MessageBox('Este registro não pode ser alterado agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
     End;
end;

procedure TfrmCadFornecedor.btCancelarClick(Sender: TObject);
begin
     dmInfoADM.tbFornedores.Cancel;
end;

procedure TfrmCadFornecedor.btGravarClick(Sender: TObject);
begin
     Try
          If (dsFornecedor.State in [dsInsert,dsEdit]) Then
          begin
               If uFuncoes.Empty(dbeNMFORN.Text) Then
               begin
                    Application.MessageBox('Digite o nome do fornecedor?', 'ATENÇÃO',
                        MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
                    dbeNMFORN.SetFocus;
                    Exit;
               end;
          End;
          //
          {If (dsFornecedor.State in [dsInsert,dsEdit]) Then
          begin
               If uFuncoes.Empty(dbeNRFONE.Text) Then
               begin
                    Application.MessageBox('Digite o n.º do telefone?', 'ATENÇÃO',
                        MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
                    dbeNRFONE.SetFocus;
                    Exit;
               end;
          End;}
          //
          If (dsFornecedor.State in [dsInsert]) Then
          begin
               If (dmInfoADM.tbParametros.Active = False) Then
                  dmInfoADM.tbParametros.Open;
               //
               dmInfoADM.tbParametros.Edit;
               dmInfoADM.tbParametros.FieldByName('PAR_CDFORN').AsFloat :=
                  dmInfoADM.tbParametros.FieldByName('PAR_CDFORN').AsFloat+1;
               dmInfoADM.tbParametros.Post;
               //
               dmInfoADM.tbFornedores.FieldByName('FOR_CDFORN').AsString :=
                  uFuncoes.StrZero(dmInfoADM.tbParametros.FieldByName('PAR_CDFORN').AsString,5);
          End;
          //
          dmInfoADM.tbFornedores.Post;
     Except
          Application.MessageBox('Error ao tentar gravar registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbFornedores.Cancel;           
     End;
end;

procedure TfrmCadFornecedor.btAdicionarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbFornedores.Append;
          dbeNMFORN.SetFocus;
     Except
          Application.MessageBox('Error ao tentar incluir registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbFornedores.Cancel;
     End;
end;

procedure TfrmCadFornecedor.btExcluirClick(Sender: TObject);
begin
    Try
        If Application.MessageBox('Deseja eliminar este registro?', 'Exclusão de registro',
                    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = ID_YES Then
           dmInfoADM.tbFornedores.delete;             // Apagar o regitro atual.
    Except
          Application.MessageBox('Este registro não pode ser excluido agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
    End;
end;

procedure TfrmCadFornecedor.btLocalizarClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmLocFornecedor, frmLocFornecedor);
      //FrmProcurar.modo := 2;
      frmLocFornecedor.Caption := 'Localizar';
      frmLocFornecedor.ShowModal;
  Finally
      frmLocFornecedor.Free;
  End;
end;

procedure TfrmCadFornecedor.dbeNRCGCExit(Sender: TObject);
begin
   If (dsFornecedor.State in [dsInsert, dsEdit]) Then
   begin
       If not uFuncoes.Empty(dbeNRCGC.Text) Then
       begin
            If not uFuncoes.CGC(dbeNRCGC.Text) Then
            begin
                 Application.MessageBox('CGC não confere, digite novamente!!!','ATENÇÃO',
                    MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                 dbeNRCGC.Clear;
                 dbeNRCGC.SetFocus;
            End;
       End;
   End;
end;

procedure TfrmCadFornecedor.dbeNMFORNExit(Sender: TObject);
begin
   If (dsFornecedor.State in [dsInsert, dsEdit]) Then
   begin
       If uFuncoes.Empty(dbeNMFORN.Text) Then
       begin
            Application.MessageBox('Digite o nome do fornecedor!!!','ATENÇÃO',
                    MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
            dbeNMFORN.SetFocus;
       End;
   End;
   //
   If (dsFornecedor.State in [dsInsert]) Then
   begin
        If (dmInfoADM.ValidaCampo(dmInfoADM.tbFornedores ,'FOR_NMFORN',dbeNMFORN.Text)) Then
        begin
               Application.MessageBox('Fornecedor já cadastrado.',
                               'ATENÇÃO', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dbeNMFORN.SetFocus;
               dmInfoADM.tbFornedores.FieldByName('FOR_NMFORN').AsString := '';    
               dbeNMFORN.Clear;
               Exit;
        End;
   End;
end;

procedure TfrmCadFornecedor.dbeNMFORNKeyPress(Sender: TObject;
  var Key: Char);
begin
     If (Key = #27) Then
     begin
          Key := #0;
          dmInfoADM.tbFornedores.Cancel; 
     End;
end;

end.
