unit uCadContato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, DB, Mask, Grids, DBGrids, Buttons;

type
  TfrmCadContato = class(TForm)
    pnlSuperior: TPanel;
    DBText2: TDBText;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    dbeNMCONT: TDBEdit;
    dsContato: TDataSource;
    Label2: TLabel;
    dbeNMEMPR: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBComboBox1: TDBComboBox;
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
    GridContatos: TDBGrid;
    procedure GridContatosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dsContatoDataChange(Sender: TObject; Field: TField);
    procedure dsContatoStateChange(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btLocalizarClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btGravarClick(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure dbeNMCONTExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadContato: TfrmCadContato;

implementation

uses udmInfoADM, uPrincipal,uFuncoes, uLocContatoCliente;

{$R *.dfm}

procedure TfrmCadContato.GridContatosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmCadContato.dsContatoDataChange(Sender: TObject;
  Field: TField);
begin
     frmPrincipal.StatusBar1.Panels[2].Text := ' Registro: ' + IntToStr(dsContato.DataSet.RecNo) +
                          ' de ' + IntToStr(dsContato.DataSet.RecordCount);
end;

procedure TfrmCadContato.dsContatoStateChange(Sender: TObject);
begin
    btAdicionar.Enabled := dsContato.State in [dsBrowse];
    btEditar.Enabled    := dsContato.State in [dsBrowse];
    btExcluir.Enabled   := dsContato.State in [dsBrowse];
    btLocalizar.Enabled := dsContato.State in [dsBrowse];
    //
    btGravar.Enabled   := dsContato.State in [dsInsert,dsEdit];
    btCancelar.Enabled := dsContato.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuPrimeiroItem .Enabled  := dsContato.State in [dsBrowse];
    frmPrincipal.mnuAnteriorItem.Enabled   := dsContato.State in [dsBrowse];
    frmPrincipal.mnuProximoItem.Enabled    := dsContato.State in [dsBrowse];
    frmPrincipal.mnuUltimo.Enabled         := dsContato.State in [dsBrowse];
    //
    frmPrincipal.mnuAdicionarItem.Enabled := dsContato.State in [dsBrowse];
    frmPrincipal.mnuEditarItem.Enabled    := dsContato.State in [dsBrowse];
    frmPrincipal.mnuExcluirItem.Enabled   := dsContato.State in [dsBrowse];
    ///
    frmPrincipal.mnuGravarItem.Enabled   := dsContato.State in [dsInsert,dsEdit];
    frmPrincipal.mnuCancelarItem.Enabled := dsContato.State in [dsInsert,dsEdit];
    //
    frmPrincipal.mnuLocalizarItem.Enabled := dsContato.State in [dsBrowse];
    GridContatos.Visible                  := dsContato.State in [dsBrowse];
end;

procedure TfrmCadContato.btExcluirClick(Sender: TObject);
begin
    Try
        If Application.MessageBox('Deseja eliminar este registro?', 'Exclus�o de registro',
                    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL) = ID_YES Then
           dmInfoADM.tbContato.delete;             // Apagar o regitro atual.
    Except
          Application.MessageBox('Este registro n�o pode ser excluido agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
    End;
end;

procedure TfrmCadContato.btCancelarClick(Sender: TObject);
begin
     dmInfoADM.tbContato.Cancel;
end;

procedure TfrmCadContato.btLocalizarClick(Sender: TObject);
begin
  Try
      Application.CreateForm(TfrmLocContato , frmLocContato);
      frmLocContato.ShowModal;
  Finally
      frmLocContato.Free;
  End;
end;

procedure TfrmCadContato.btEditarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbContato.Edit;
          dbeNMCONT.SetFocus;
     Except
          Application.MessageBox('Este registro n�o pode ser alterado agora?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbContato.Cancel;
     End;
end;

procedure TfrmCadContato.FormActivate(Sender: TObject);
begin
     If (dmInfoADM.tbContato.Active = False) Then
         dmInfoADM.tbContato.Open;
     dmInfoADM.tbContato.First;
     //
     GridContatos.Align := alClient;
     frmPrincipal.mnuNavegacao.Enabled := True;
end;

procedure TfrmCadContato.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     dmInfoADM.tbContato.Close;
     //
     uFuncoes.Limpar_Status;
     frmPrincipal.mnuNavegacao.Enabled := False;
     //
     Action := caFree;
end;

procedure TfrmCadContato.btGravarClick(Sender: TObject);
begin
     Try
         If (dsContato.State in [dsInsert,dsEdit]) Then
         begin
               If uFuncoes.Empty(dbeNMCONT.Text) Then
               begin
                    Application.MessageBox('Digite o nome do contato!!!','ATEN��O',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeNMCONT.SetFocus;
                    Exit;
               End;
               //
               If uFuncoes.Empty(dbeNMEMPR.Text) Then
               begin
                    Application.MessageBox('Digite o nome da empresa!!!','ATEN��O',
                       MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
                    dbeNMEMPR.SetFocus;
                    Exit;
               End;
         End;
         //
         {If (dsContato.State in [dsInsert]) Then
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
         End;}
         //
         dmInfoADM.tbContato.Post;
     Except
          Application.MessageBox('Error ao tentar gravar registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbContratos.Cancel;
     End;
end;

procedure TfrmCadContato.btAdicionarClick(Sender: TObject);
begin
     Try
          dmInfoADM.tbContato.Append;
          dbeNMCONT.SetFocus;
     Except
          Application.MessageBox('Error ao tentar incluir registro?', 'Erro',
                    MB_OK+MB_ICONQUESTION+MB_APPLMODAL);
          dmInfoADM.tbContato.Cancel;
     End;
end;

procedure TfrmCadContato.dbeNMCONTExit(Sender: TObject);
begin
     If (dsContato.State in [dsInsert]) Then
     begin
          If (dmInfoADM.ValidaCampo(dmInfoADM.tbContato ,'FON_NMCONT',dbeNMCONT.Text)) Then
          begin
               Application.MessageBox('Contato j� cadastrado.',
                               'ATEN��O', MB_OK+MB_ICONINFORMATION+MB_APPLMODAL);
               dmInfoADM.tbContato.FieldByName('FON_NMCONT').AsString := ' '; 
               dbeNMCONT.SetFocus;
               dbeNMCONT.Clear;
               Exit;
          End;
     End;
end;

end.
