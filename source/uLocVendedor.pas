unit uLocVendedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, StdCtrls, ExtCtrls, DB;

type
  TfrmLocVendedor = class(TForm)
    rdCODIGO: TRadioButton;
    rbNOME: TRadioButton;
    Edit1: TLabeledEdit;
    BtnConfirmar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    GridDados: TDBGrid;
    dsVendedor: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdCODIGOClick(Sender: TObject);
    procedure rbNOMEClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocVendedor: TfrmLocVendedor;

implementation

Uses udmInfoADM, uFuncoes;

{$R *.dfm}

procedure TfrmLocVendedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Action := caFree;
end;

procedure TfrmLocVendedor.rdCODIGOClick(Sender: TObject);
begin
     Edit1.SetFocus; 
end;

procedure TfrmLocVendedor.rbNOMEClick(Sender: TObject);
begin
     Edit1.SetFocus;
end;

procedure TfrmLocVendedor.FormShow(Sender: TObject);
begin
   With dmInfoADM.qryVendedor  do
   begin
         sql.clear;
         sql.add('select * from ADMVEN order by VEN_NMVEND');
         execsql;
         open;
   End;
   //
   Edit1.SetFocus;
end;

procedure TfrmLocVendedor.BtnCancelarClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmLocVendedor.Edit1Change(Sender: TObject);
begin
   If not uFuncoes.Empty(Edit1.Text) Then
   begin
     If (rdCODIGO.Checked = True) Then
     begin
         With dmInfoADM.qryVendedor do
         begin
              SQL.Clear;
              Sql.add('select * from ADMVEN where VEN_CDVEND like '
                 + quotedstr(uFuncoes.StrZero(edit1.Text,6)+'%') + ' order by VEN_NMVEND');
              ExecSQL;
              Open;
          End;
     End;
     //
     If (rbNOME.Checked = True) Then
     begin
           With dmInfoADM.qryVendedor do
           begin
                SQL.Clear;
                Sql.add('select * from ADMVEN where VEN_NMVEND like '
                      + quotedstr(edit1.Text+'%') + ' order by VEN_NMVEND');
                ExecSQL;
                Open;
           End;
     End;
  End;
end;

procedure TfrmLocVendedor.BtnConfirmarClick(Sender: TObject);
Var
    M_CDVEND : String;
begin
     M_CDVEND := dmInfoADM.qryVendedor.fieldByName('VEN_CDVEND').AsString;
     //
     dmInfoADM.tbVendedores.Locate('VEN_CDVEND',M_CDVEND,[]);
     // Fechar janela de localizar
     close;
end;

procedure TfrmLocVendedor.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    if key = #13 then btnconfirmar.Click;
    if key = #13 then btncancelar.Click;
end;

end.
