unit uCadContrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, DB, Mask, Buttons, Grids, DBGrids;

type
  TfrmCadContrato = class(TForm)
    pnlSuperior: TPanel;
    DBText2: TDBText;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsContrato: TDataSource;
    Label3: TLabel;
    cmbNMCLIE: TDBLookupComboBox;
    Label4: TLabel;
    dbeDTCONT: TDBEdit;
    Label5: TLabel;
    dbeDTVENC: TDBEdit;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    dbeDIFATU: TDBEdit;
    Label9: TLabel;
    dbeVLCONT: TDBEdit;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    Label11: TLabel;
    DBEdit10: TDBEdit;
    Label13: TLabel;
    DBEdit12: TDBEdit;
    btAdicionar: TBitBtn;
    btEditar: TBitBtn;
    btExcluir: TBitBtn;
    btGravar: TBitBtn;
    btCancelar: TBitBtn;
    Label2: TLabel;
    btLocalizar: TBitBtn;
    GridContratos: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure DBEdit12KeyPress(Sender: TObject; var Key: Char);
    procedure dsContratoDataChange(Sender: TObject; Field: TField);
    procedure dsContratoStateChange(Sender: TObject);
    procedure GridContratosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btCancelarClick(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btLocalizarClick(Sender: TObject);
    procedure dbeDTVENCExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadContrato: TfrmCadContrato;

implementation

uses udmInfoADM, uPrincipal,uFuncoes, uLocContratoClie;

{$R *.dfm}

procedure TfrmCadContrato.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      dmInfoADM.tbContratos.Close;
      dmInfoADM.tbClientes.Close;
      //       
      uFuncoes.Limpar_Status;
      //
      frmPrincipal.mnuNavegacao.Enabled := False;
      //
      Action := caFree;
end;

procedure TfrmCadContrato.FormActivate(Sender: TObject);
begin
     If (dmInfoADM.tbContratos.Active = False) Then
         dmInfoADM.tbContratos.Open;
     dmInfoADM.tbContratos.IndexFieldNames := 'CON_NMCLIE';
     dmInfoADM.tbContratos.First; 
     //
     If (dmInfoADM.tbClientes.Active = False) Then
         dmInfoADM.tbClientes.Open;
     dmInfoADM.tbClientes.IndexFieldNames := 'CLI_NMCLIE';
     //
     GridContratos.Align := alClient;
     frmPrincipal.mnuNavegacao.Enabled := True;
end;

procedure TfrmCadContrato.DBEdit12KeyPress(Sender: TObject; var Key: Char);
begin
     If not( key in['S','N','s','n',#8] ) then
          key:=#0;
end;

procedure TfrmCadContrato.dsContratoDataChange(Sender: TObject;
  Field: TField);
begin
     frmPrincipal.StatusBar1.Panels[2].Text := ' Registro: ' + IntToStr(dsContrato.DataSet.RecNo) +
                          ' de ' + IntToStr(dsContrato.DataSet.RecordCount);
end;

procedure TfrmCadContrato.dsContratoStateChange(Sender: TObject);
begin
    btAdicionar.Enabled := dsContrato.State in [dsBrowse];
    btEditar.Enabled    := dsContrato.State in [dsBrowse];
    btExcluir.Enabled   := dsContrato.State in [dsBrowse];
    btLocalizar.Enabled := dsContrato.State in [dsBrowse];
    //
    btGravar.Enabled   := dsContrato.State in [dsInsert,dsEdit];
    btCancelar.Enabled := dsContrato.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuPrimeiroItem .Enabled  := dsContrato.State in [dsBrowse];
    frmPrincipal.mnuAnteriorItem.Enabled   := dsContrato.State in [dsBrowse];
    frmPrincipal.mnuProximoItem.Enabled    := dsContrato.State in [dsBrowse];
    frmPrincipal.mnuUltimo.Enabled         := dsContrato.State in [dsBrowse];
    //
    frmPrincipal.mnuAdicionarItem.Enabled := dsContrato.State in [dsBrowse];
    frmPrincipal.mnuEditarItem.Enabled    := dsContrato.State in [dsBrowse];
    frmPrincipal.mnuExcluirItem.Enabled   := dsContrato.State in [dsBrowse];
    ///
    frmPrincipal.mnuGravarItem.Enabled   := dsContrato.State in [dsInsert,dsEdit];
    frmPrincipal.mnuCancelarItem.Enabled := dsContrato.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuLocalizarItem.Enabled  := dsContrato.State in [dsBrowse];
    GridContratos.Visible                  := dsContrato.State in [dsBrowse];
end;

procedure TfrmCadContrato.GridContratosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmCadContrato.btCancelarClick(Sender: TObject);
begin
     dmInfoADM.tbContratos.Cancel;  
end;

procedure TfrmCadContrato.btAdicionarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbContratos.Append;
          dmInfoADM.tbContratos.FieldByName('CON_DTCONT').AsDateTime :=  Date();
          cmbNMCLIE.SetFocus;
     Except
          Application.MessageBox('Error ao tentar incluir registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbContratos.Cancel;
     End;
end;

procedure TfrmCadContrato.btExcluirClick(Sender: TObject);
begin
    Try
        If Application.MessageBox('Deseja eliminar este registro?', 'Exclusão de registro',
                    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = ID_YES Then
           dmInfoADM.tbContratos.delete;             // Apagar o regitro atual.
    Except
          Application.MessageBox('Este registro não pode ser excluido agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
    End;
end;

procedure TfrmCadContrato.btEditarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbContratos.Edit;
          cmbNMCLIE.SetFocus;
     Except
          Application.MessageBox('Este registro não pode ser alterado agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbContratos.Cancel;
     End;
end;

procedure TfrmCadContrato.btGravarClick(Sender: TObject);
begin
     Try
         If (dsContrato.State in [dsInsert,dsEdit]) Then
         begin
               If uFuncoes.Empty(cmbNMCLIE.Text) Then
               begin
                    Application.MessageBox('Selecione o cliente!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    cmbNMCLIE.SetFocus;
                    Exit;
               End;
               //
               If uFuncoes.Empty(dbeDTVENC.Text) Then
               begin
                    Application.MessageBox('Digite a data de vencimento!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeDTVENC.SetFocus;
                    Exit;
               End;
               //
               If uFuncoes.Empty(dbeDIFATU.Text) Then
               begin
                    Application.MessageBox('Digite o dia da Fatura!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeDIFATU.SetFocus;
                    Exit;
               End;
               //
               If uFuncoes.Empty(dbeVLCONT.Text) Then
               begin
                    Application.MessageBox('Digite o valor contrato!!!','ATENÇÃO',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeVLCONT.SetFocus;
                    Exit;
               End;
         End;
         //
         If (dsContrato.State in [dsInsert]) Then
         begin
              If (dmInfoADM.tbParametros.Active = False) Then
                  dmInfoADM.tbParametros.Open;
              //
              dmInfoADM.tbParametros.Edit;
              dmInfoADM.tbParametros.FieldByName('PAR_NRCONT').AsFloat :=
                dmInfoADM.tbParametros.FieldByName('PAR_NRCONT').AsFloat+1;
              dmInfoADM.tbParametros.Post;
              //
              dmInfoADM.tbContratos.FieldByName('CON_NRCONT').AsString :=
                 uFuncoes.StrZero(dmInfoADM.tbParametros.FieldByName('PAR_NRCONT').AsString,5)
                 +Copy(DatetoStr(Date()),7,4);
         End;
         //
         dmInfoADM.tbContratos.FieldByName('CON_NMCLIE').AsString :=
             dmInfoADM.tbContratos.FieldByName('CON_NMCLIE2').AsString;
         //
         dmInfoADM.tbContratos.Post;
     Except
          Application.MessageBox('Error ao tentar gravar registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbContratos.Cancel;
     End;
end;

procedure TfrmCadContrato.btLocalizarClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmLocContratoClie, frmLocContratoClie);
      frmLocContratoClie.ShowModal;
  Finally
      frmLocContratoClie.Free;
  End;
end;

procedure TfrmCadContrato.dbeDTVENCExit(Sender: TObject);
begin
     If (StrtoDate(dbeDTVENC.Text) < StrtoDate(dbeDTCONT.Text)) Then
       dbeDTVENC.SetFocus; 
end;

end.
