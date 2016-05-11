unit uLocContatoCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, StdCtrls, ExtCtrls, DB;

type
  TfrmLocContato = class(TForm)
    rdNMCONT: TRadioButton;
    rbNMEMPR: TRadioButton;
    Edit1: TLabeledEdit;
    GridDados: TDBGrid;
    BtnConfirmar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    dsContatos: TDataSource;
    procedure rdNMCONTClick(Sender: TObject);
    procedure rbNMEMPRClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BtnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocContato: TfrmLocContato;

implementation

Uses udmInfoADM, uFuncoes;

{$R *.dfm}

procedure TfrmLocContato.rdNMCONTClick(Sender: TObject);
begin
     Edit1.SetFocus;
end;

procedure TfrmLocContato.rbNMEMPRClick(Sender: TObject);
begin
     Edit1.SetFocus;
end;

procedure TfrmLocContato.BtnCancelarClick(Sender: TObject);
begin
      Close;
end;

procedure TfrmLocContato.FormShow(Sender: TObject);
begin
   With dmInfoADM.qryContatos do
   begin
         sql.clear;
         sql.add('select * from ADMFON order by FON_NMCONT');
         execsql;
         open;
   End;
   //
   Edit1.SetFocus;
end;

procedure TfrmLocContato.Edit1Change(Sender: TObject);
begin
   If not uFuncoes.Empty(Edit1.Text) Then
   begin
     If (rdNMCONT.Checked = True) Then
     begin
         With dmInfoADM.qryContatos do
         begin
              SQL.Clear;
              Sql.add('select * from ADMFON where FON_NMCONT like '
                 + quotedstr(edit1.Text+'%') + ' order by FON_NMCONT');
              ExecSQL;
              Open;
          End;
     End;
     //
     If (rbNMEMPR.Checked = True) Then
     begin
           With dmInfoADM.qryContatos do
           begin
                SQL.Clear;
                Sql.add('select * from ADMFON where FON_NMEMPR like '
                      + quotedstr(edit1.Text+'%') + ' order by FON_NMCONT');
                ExecSQL;
                Open;
           End;
     End;
  End;
end;

procedure TfrmLocContato.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    if key = #13 then btnconfirmar.Click;
    if key = #13 then btncancelar.Click;
end;

procedure TfrmLocContato.BtnConfirmarClick(Sender: TObject);
Var
    M_NMCONT : String;
begin
     M_NMCONT := dmInfoADM.qryContatos.fieldByName('FON_NMCONT').AsString;
     //
     dmInfoADM.tbContato.Locate('FON_NMCONT',M_NMCONT,[]);
     // Fechar janela de localizar
     close;
end;

end.
