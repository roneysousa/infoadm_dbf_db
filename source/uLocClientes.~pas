unit uLocClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, StdCtrls, ExtCtrls, DB;

type
  TfrmLocClientes = class(TForm)
    edtPROCURA: TLabeledEdit;
    BtnConfirmar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    GridDados: TDBGrid;
    dsClientes: TDataSource;
    rdCODIGO: TRadioButton;
    rbNOME: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPROCURAKeyPress(Sender: TObject; var Key: Char);
    procedure edtPROCURAChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure rbNOMEClick(Sender: TObject);
    procedure rdCODIGOClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocClientes: TfrmLocClientes;

implementation

Uses udmInfoADM,uFuncoes;

{$R *.dfm}

procedure TfrmLocClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Action := caFree;
end;

procedure TfrmLocClientes.edtPROCURAKeyPress(Sender: TObject;
  var Key: Char);
begin
    if key = #13 then btnconfirmar.Click;
    if key = #13 then btncancelar.Click;
end;

procedure TfrmLocClientes.edtPROCURAChange(Sender: TObject);
begin
     If not uFuncoes.Empty(edtPROCURA.Text) Then
     begin
           If (rdCODIGO.Checked = True) Then
           begin
                // Procura pelo codigo
                With dmInfoADM.qryClientes do
                begin
                     SQL.Clear;
                     Sql.add('select * from ADMCLI where CLI_CDCLIE like '
                        + quotedstr(uFuncoes.StrZero(edtPROCURA.Text,7)+'%') + ' order by CLI_CDCLIE');
                     ExecSQL;
                     Open;
                End;
            End;
            //
            If (rbNOME.Checked = True) Then
            begin
                // Procura pelo nome
                With dmInfoADM.qryClientes do
                begin
                     SQL.Clear;
                     Sql.add('select * from ADMCLI where CLI_NMCLIE like ' + quotedstr(edtPROCURA.Text+'%') + ' order by CLI_NMCLIE');
                     ExecSQL;
                     Open;
                End;
            End;
    End;
end;

procedure TfrmLocClientes.FormShow(Sender: TObject);
begin
   With dmInfoADM.qryClientes do
   begin
         sql.clear;
         sql.add('select * from ADMCLI order by CLI_NMCLIE');
         execsql;
         open;
   End;
end;

procedure TfrmLocClientes.BtnConfirmarClick(Sender: TObject);
Var
    M_CDCLIE : String;
begin
     M_CDCLIE := dmInfoADM.qryClientes.fieldByName('CLI_CDCLIE').AsString;
     //
     dmInfoADM.tbClientes.Locate('CLI_CDCLIE',M_CDCLIE,[]);
     // Fechar janela de localizar
     close;
end;

procedure TfrmLocClientes.rbNOMEClick(Sender: TObject);
begin
     edtPROCURA.SetFocus; 
end;

procedure TfrmLocClientes.rdCODIGOClick(Sender: TObject);
begin
      edtPROCURA.SetFocus;
end;

procedure TfrmLocClientes.BtnCancelarClick(Sender: TObject);
begin
     Close;
end;

end.
