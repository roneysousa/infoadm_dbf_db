unit uCadFunc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, DB, Mask, Grids, DBGrids, Buttons;

type
  TfrmCadFuncionario = class(TForm)
    pnlSuperior: TPanel;
    DBText2: TDBText;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsFuncionario: TDataSource;
    Label2: TLabel;
    dbeNMFUNC: TDBEdit;
    Label3: TLabel;
    dbeENDFUN: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    cmbUFCLIE: TDBComboBox;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    dbeNRIDEN: TDBEdit;
    Label11: TLabel;
    DBEdit10: TDBEdit;
    Label12: TLabel;
    Label13: TLabel;
    dbeTilulo: TDBEdit;
    Label14: TLabel;
    DBEdit13: TDBEdit;
    Label15: TLabel;
    DBEdit14: TDBEdit;
    Label16: TLabel;
    DBEdit15: TDBEdit;
    Label17: TLabel;
    DBEdit16: TDBEdit;
    Label18: TLabel;
    DBEdit17: TDBEdit;
    Label19: TLabel;
    DBEdit18: TDBEdit;
    Label20: TLabel;
    DBEdit19: TDBEdit;
    Label21: TLabel;
    DBEdit20: TDBEdit;
    Label22: TLabel;
    DBEdit21: TDBEdit;
    DBComboBox1: TDBComboBox;
    btAdicionar: TBitBtn;
    btEditar: TBitBtn;
    btExcluir: TBitBtn;
    btLocalizar: TBitBtn;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    GridFuncionario: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure dsFuncionarioDataChange(Sender: TObject; Field: TField);
    procedure dsFuncionarioStateChange(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btLocalizarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure GridFuncionarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeNMFUNCExit(Sender: TObject);
    procedure dbeNRIDENExit(Sender: TObject);
    procedure dbeTiluloExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadFuncionario: TfrmCadFuncionario;

implementation

uses udmInfoADM,uFuncoes, uPrincipal, uLocFunc;

{$R *.dfm}

procedure TfrmCadFuncionario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     dmInfoADM.tbFuncionarios.Close;
     //
     uFuncoes.Limpar_Status;
     frmPrincipal.mnuNavegacao.Enabled := False;
     //
     Action := caFree;
end;

procedure TfrmCadFuncionario.FormActivate(Sender: TObject);
begin
     If (dmInfoADM.tbFuncionarios.Active = False) Then
         dmInfoADM.tbFuncionarios.Open;
         dmInfoADM.tbFuncionarios.IndexFieldNames := 'FUN_NMFUNC';
         dmInfoADM.tbFuncionarios.First; 
     //
     frmPrincipal.mnuNavegacao.Enabled := True;
     GridFuncionario.Align := alClient;
end;

procedure TfrmCadFuncionario.dsFuncionarioDataChange(Sender: TObject;
  Field: TField);
begin
     frmPrincipal.StatusBar1.Panels[2].Text := ' Registro: ' + IntToStr(dsFuncionario.DataSet.RecNo) +
                          ' de ' + IntToStr(dsFuncionario.DataSet.RecordCount);
end;

procedure TfrmCadFuncionario.dsFuncionarioStateChange(Sender: TObject);
begin
    btAdicionar.Enabled := dsFuncionario.State in [dsBrowse];
    btEditar.Enabled    := dsFuncionario.State in [dsBrowse];
    btExcluir.Enabled   := dsFuncionario.State in [dsBrowse];
    btLocalizar.Enabled := dsFuncionario.State in [dsBrowse];
    //
    btGravar.Enabled   := dsFuncionario.State in [dsInsert,dsEdit];
    btCancelar.Enabled := dsFuncionario.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuPrimeiroItem .Enabled  := dsFuncionario.State in [dsBrowse];
    frmPrincipal.mnuAnteriorItem.Enabled   := dsFuncionario.State in [dsBrowse];
    frmPrincipal.mnuProximoItem.Enabled    := dsFuncionario.State in [dsBrowse];
    frmPrincipal.mnuUltimo.Enabled         := dsFuncionario.State in [dsBrowse];
    //
    frmPrincipal.mnuAdicionarItem.Enabled := dsFuncionario.State in [dsBrowse];
    frmPrincipal.mnuEditarItem.Enabled    := dsFuncionario.State in [dsBrowse];
    frmPrincipal.mnuExcluirItem.Enabled   := dsFuncionario.State in [dsBrowse];
    ///
    frmPrincipal.mnuGravarItem.Enabled   := dsFuncionario.State in [dsInsert,dsEdit];
    frmPrincipal.mnuCancelarItem.Enabled := dsFuncionario.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuLocalizarItem.Enabled   := dsFuncionario.State in [dsBrowse];
    GridFuncionario.Visible := dsFuncionario.State in [dsBrowse];
end;

procedure TfrmCadFuncionario.btEditarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbFuncionarios.Edit;
          dbeNMFUNC.SetFocus;
     Except
          Application.MessageBox('Este registro não pode ser alterado agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbFuncionarios.Cancel;
     End;
end;

procedure TfrmCadFuncionario.btExcluirClick(Sender: TObject);
begin
    Try
        If Application.MessageBox('Deseja eliminar este registro?', 'Exclusão de registro',
                    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = ID_YES Then
           dmInfoADM.tbFuncionarios.delete;             // Apagar o regitro atual.
    Except
          Application.MessageBox('Este registro não pode ser excluido agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
    End;
end;

procedure TfrmCadFuncionario.btLocalizarClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmLocFunc, frmLocFunc);
      frmLocFunc.ShowModal;
  Finally
      frmLocFunc.Free;
  End;
end;

procedure TfrmCadFuncionario.btGravarClick(Sender: TObject);
begin
     Try
         If (dsFuncionario.State in [dsInsert,dsEdit]) Then
         begin
               If uFuncoes.Empty(dbeNMFUNC.Text) Then
               begin
                    Application.MessageBox('Digite o nome do funcionário!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeNMFUNC.SetFocus;
                    Exit;
               End;
               //
               If uFuncoes.Empty(dbeENDFUN.Text) Then
               begin
                    Application.MessageBox('Digite o endereço do funcionário!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeENDFUN.SetFocus;
                    Exit;
               End;
         End;
         //
         If (dsFuncionario.State in [dsInsert]) Then
         begin
              If (dmInfoADM.tbParametros.Active = False) Then
                  dmInfoADM.tbParametros.Open;
              //
              dmInfoADM.tbParametros.Edit;
              dmInfoADM.tbParametros.FieldByName('PAR_CDFUNC').AsFloat :=
                dmInfoADM.tbParametros.FieldByName('PAR_CDFUNC').AsFloat+1;
              dmInfoADM.tbParametros.Post;
              //
              dmInfoADM.tbFuncionarios.FieldByName('FUN_CDFUNC').AsString :=
                 uFuncoes.StrZero(dmInfoADM.tbParametros.FieldByName('PAR_CDFUNC').AsString,5);
         End;
         //
         dmInfoADM.tbFuncionarios.Post;
     Except
          Application.MessageBox('Error ao tentar gravar registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbFuncionarios.Cancel;
     End;
end;

procedure TfrmCadFuncionario.btCancelarClick(Sender: TObject);
begin
     dmInfoADM.tbFuncionarios.Cancel;
end;

procedure TfrmCadFuncionario.btAdicionarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbFuncionarios.Append;
          dmInfoADM.tbFuncionarios.FieldByName('FUN_DTADMI').AsDateTime :=  Date();
          dbeNMFUNC.SetFocus;
     Except
          Application.MessageBox('Error ao tentar incluir registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbFuncionarios.Cancel;
     End;
end;

procedure TfrmCadFuncionario.GridFuncionarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmCadFuncionario.dbeNMFUNCExit(Sender: TObject);
begin
     If (dsFuncionario.State in [dsInsert]) and
       (not uFuncoes.Empty(dbeNMFUNC.Text)) Then
     begin
          If (dmInfoADM.ValidaCampo(dmInfoADM.tbFuncionarios ,'FUN_NMFUNC',dbeNMFUNC.Text)) Then
          begin
               Application.MessageBox('Funcionário(a) já cadastrado(a).',
                               'ATENÇÃO', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dmInfoADM.tbFuncionarios.FieldByName('FUN_NMFUNC').AsString := ' ';                  
               dbeNMFUNC.SetFocus;
               dbeNMFUNC.Clear;
               Exit;
          End;
     End;
end;

procedure TfrmCadFuncionario.dbeNRIDENExit(Sender: TObject);
begin
     If (dsFuncionario.State in [dsInsert]) and
       (not uFuncoes.Empty(dbeNRIDEN.Text)) Then
     begin
          If (dmInfoADM.ValidaCampo(dmInfoADM.tbFuncionarios ,'FUN_NRIDEN',dbeNRIDEN.Text)) Then
          begin
               Application.MessageBox('Identidade já cadastrada.',
                               'ATENÇÃO', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dbeNRIDEN.Clear;
               dbeNRIDEN.SetFocus;
               Exit;
          End;
     End;
end;

procedure TfrmCadFuncionario.dbeTiluloExit(Sender: TObject);
begin
     If (dsFuncionario.State in [dsInsert]) and
       (not uFuncoes.Empty(dbeTilulo.Text)) Then
     begin
          If (dmInfoADM.ValidaCampo(dmInfoADM.tbFuncionarios ,'FUN_NRTITU',dbeTilulo.Text)) Then
          begin
               Application.MessageBox('Titulo já cadastrado.',
                               'ATENÇÃO', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dbeTilulo.Clear;
               dbeTilulo.SetFocus;
               Exit;
          End;
     End;
end;

end.
