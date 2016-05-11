unit uLocContratoClie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, StdCtrls, ExtCtrls, DB;

type
  TfrmLocContratoClie = class(TForm)
    edtPROCURA: TLabeledEdit;
    BtnConfirmar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    GridDados: TDBGrid;
    dsClientes: TDataSource;
    rdCODIGO: TRadioButton;
    rbNOME: TRadioButton;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPROCURAChange(Sender: TObject);
    procedure edtPROCURAKeyPress(Sender: TObject; var Key: Char);
    procedure rdCODIGOClick(Sender: TObject);
    procedure rbNOMEClick(Sender: TObject);
    procedure GridDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocContratoClie: TfrmLocContratoClie;

implementation

Uses udmInfoADM, uFuncoes;

{$R *.dfm}

procedure TfrmLocContratoClie.BtnCancelarClick(Sender: TObject);
begin
      Close;
end;

procedure TfrmLocContratoClie.BtnConfirmarClick(Sender: TObject);
Var
    M_NRCLIE : String;
begin
     M_NRCLIE := dmInfoADM.qryContratos.fieldByName('CON_NRCONT').AsString;
     //
     dmInfoADM.tbContratos.Locate('CON_NRCONT',M_NRCLIE,[]);
     // Fechar janela de localizar
     close;
end;

procedure TfrmLocContratoClie.FormShow(Sender: TObject);
begin
   With dmInfoADM.qryContratos do
   begin
         sql.clear;
         sql.add('select * from ADMCON order by CON_NMCLIE');
         execsql;
         open;
         First;
   End;
end;

procedure TfrmLocContratoClie.edtPROCURAChange(Sender: TObject);
begin
     If not uFuncoes.Empty(edtPROCURA.Text) Then
     begin
         If (rdCODIGO.Checked = True) Then
         begin
             // Procura pelo nome
             With dmInfoADM.qryContratos do
             begin
                  SQL.Clear;
                  Sql.add('select * from ADMCON where CON_NRCONT like '
                       + quotedstr(uFuncoes.StrZero(edtPROCURA.Text,5)+'%') + ' order by CON_NMCLIE');
                  ExecSQL;
                  Open;
             End;
         End;
         //
         If (rbNOME.Checked = True) Then
         begin
             // Procura pelo nome
             With dmInfoADM.qryContratos do
             begin
                  SQL.Clear;
                  Sql.add('select * from ADMCON where CON_NMCLIE like '
                       + quotedstr(edtPROCURA.Text+'%') + ' order by CON_NMCLIE');
                  ExecSQL;
                  Open;
             End;
         End;
     End;
end;

procedure TfrmLocContratoClie.edtPROCURAKeyPress(Sender: TObject;
  var Key: Char);
begin
    if key = #13 then btnconfirmar.Click;
    if key = #13 then btncancelar.Click;
end;

procedure TfrmLocContratoClie.rdCODIGOClick(Sender: TObject);
begin
   edtPROCURA.SetFocus;
end;

procedure TfrmLocContratoClie.rbNOMEClick(Sender: TObject);
begin
   edtPROCURA.SetFocus;
end;

procedure TfrmLocContratoClie.GridDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

end.
