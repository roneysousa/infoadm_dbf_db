unit uCadVendedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Buttons, DB, Mask, Grids, DBGrids;

type
  TfrmCadVendedor = class(TForm)
    pnlSuperior: TPanel;
    DBText2: TDBText;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsVendedores: TDataSource;
    Label2: TLabel;
    dbeNMVEND: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBComboBox1: TDBComboBox;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    btAdicionar: TBitBtn;
    btEditar: TBitBtn;
    btExcluir: TBitBtn;
    btLocalizar: TBitBtn;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    GridVendedores: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure dsVendedoresDataChange(Sender: TObject; Field: TField);
    procedure dsVendedoresStateChange(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btLocalizarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure GridVendedoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeNMVENDExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadVendedor: TfrmCadVendedor;

implementation

uses udmInfoADM, uPrincipal,uFuncoes, uLocVendedor;

{$R *.dfm}

procedure TfrmCadVendedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     dmInfoADM.tbVendedores.Close;
     //
     uFuncoes.Limpar_Status;
     frmPrincipal.mnuNavegacao.Enabled := False;
     //
     Action := caFree;
end;

procedure TfrmCadVendedor.FormActivate(Sender: TObject);
begin
     If (dmInfoADM.tbVendedores.Active = False) Then
         dmInfoADM.tbVendedores.Open;
         dmInfoADM.tbVendedores.IndexFieldNames := 'VEN_NMVEND';
         dmInfoADM.tbVendedores.First;
     //
     frmPrincipal.mnuNavegacao.Enabled := True;
     GridVendedores.Align := alClient;
end;

procedure TfrmCadVendedor.dsVendedoresDataChange(Sender: TObject;
  Field: TField);
begin
     frmPrincipal.StatusBar1.Panels[2].Text := ' Registro: ' + IntToStr(dsVendedores.DataSet.RecNo) +
                          ' de ' + IntToStr(dsVendedores.DataSet.RecordCount);
end;

procedure TfrmCadVendedor.dsVendedoresStateChange(Sender: TObject);
begin
    btAdicionar.Enabled := dsVendedores.State in [dsBrowse];
    btEditar.Enabled    := dsVendedores.State in [dsBrowse];
    btExcluir.Enabled   := dsVendedores.State in [dsBrowse];
    btLocalizar.Enabled := dsVendedores.State in [dsBrowse];
    //
    btGravar.Enabled   := dsVendedores.State in [dsInsert,dsEdit];
    btCancelar.Enabled := dsVendedores.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuPrimeiroItem .Enabled  := dsVendedores.State in [dsBrowse];
    frmPrincipal.mnuAnteriorItem.Enabled   := dsVendedores.State in [dsBrowse];
    frmPrincipal.mnuProximoItem.Enabled    := dsVendedores.State in [dsBrowse];
    frmPrincipal.mnuUltimo.Enabled         := dsVendedores.State in [dsBrowse];
    //
    frmPrincipal.mnuAdicionarItem.Enabled := dsVendedores.State in [dsBrowse];
    frmPrincipal.mnuEditarItem.Enabled    := dsVendedores.State in [dsBrowse];
    frmPrincipal.mnuExcluirItem.Enabled   := dsVendedores.State in [dsBrowse];
    ///
    frmPrincipal.mnuGravarItem.Enabled   := dsVendedores.State in [dsInsert,dsEdit];
    frmPrincipal.mnuCancelarItem.Enabled := dsVendedores.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuLocalizarItem.Enabled   := dsVendedores.State in [dsBrowse];
    GridVendedores.Visible := dsVendedores.State in [dsBrowse];
end;

procedure TfrmCadVendedor.btAdicionarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbVendedores.Append;
          dbeNMVEND.SetFocus;
     Except
          Application.MessageBox('Error ao tentar incluir registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbVendedores.Cancel;
     End;
end;

procedure TfrmCadVendedor.btEditarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbVendedores.Edit;
          dbeNMVEND.SetFocus;
     Except
          Application.MessageBox('Este registro n�o pode ser alterado agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbVendedores.Cancel;
     End;
end;

procedure TfrmCadVendedor.btExcluirClick(Sender: TObject);
begin
    Try
        If Application.MessageBox('Deseja eliminar este registro?', 'Exclus�o de registro',
                    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = ID_YES Then
           dmInfoADM.tbVendedores.delete;             // Apagar o regitro atual.
    Except
          Application.MessageBox('Este registro n�o pode ser excluido agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
    End;
end;

procedure TfrmCadVendedor.btLocalizarClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmLocVendedor, frmLocVendedor);
      frmLocVendedor.ShowModal;
  Finally
      frmLocVendedor.Free;
  End;
end;

procedure TfrmCadVendedor.btGravarClick(Sender: TObject);
begin
     Try
         If (dsVendedores.State in [dsInsert,dsEdit]) Then
         begin
               If uFuncoes.Empty(dbeNMVEND.Text) Then
               begin
                    Application.MessageBox('Digite o nome do vendedor!!!','ATEN��O',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeNMVEND.SetFocus;
                    Exit;
               End;
         End;
         //
         If (dsVendedores.State in [dsInsert]) Then
         begin
              If (dmInfoADM.tbParametros.Active = False) Then
                  dmInfoADM.tbParametros.Open;
              //
              dmInfoADM.tbParametros.Edit;
              dmInfoADM.tbParametros.FieldByName('PAR_CDVEND').AsFloat :=
                dmInfoADM.tbParametros.FieldByName('PAR_CDVEND').AsFloat+1;
              dmInfoADM.tbParametros.Post;
              //
              dmInfoADM.tbVendedores.FieldByName('VEN_CDVEND').AsString :=
                 uFuncoes.StrZero(dmInfoADM.tbParametros.FieldByName('PAR_CDVEND').AsString,6);
         End;
         //
         dmInfoADM.tbVendedores.Post;
     Except
          Application.MessageBox('Error ao tentar gravar registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbVendedores.Cancel;
     End;
end;

procedure TfrmCadVendedor.btCancelarClick(Sender: TObject);
begin
     dmInfoADM.tbVendedores.Cancel;
end;

procedure TfrmCadVendedor.GridVendedoresKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmCadVendedor.dbeNMVENDExit(Sender: TObject);
begin
     If (dsVendedores.State in [dsInsert]) and
       (not uFuncoes.Empty(dbeNMVEND.Text)) Then
     begin
          If (dmInfoADM.ValidaCampo(dmInfoADM.tbVendedores ,'VEN_NMVEND',dbeNMVEND.Text)) Then
          begin
               Application.MessageBox('Vendedor(a) j� cadastrado(a).',
                               'ATEN��O', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dmInfoADM.tbVendedores.FieldByName('VEN_NMVEND').AsString := ' ';
               dbeNMVEND.SetFocus;
               dbeNMVEND.Clear;
               Exit;
          End;
     End;
end;

end.
