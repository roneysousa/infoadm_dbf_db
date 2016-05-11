unit uLocFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, StdCtrls, ExtCtrls, DB;

type
  TfrmLocFornecedor = class(TForm)
    Edit1: TLabeledEdit;
    BtnConfirmar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    GridDados: TDBGrid;
    dsFornecedor: TDataSource;
    rdCODIGO: TRadioButton;
    rbNOME: TRadioButton;
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
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
  frmLocFornecedor: TfrmLocFornecedor;

implementation

uses udmInfoADM,uFuncoes;

{$R *.dfm}

procedure TfrmLocFornecedor.Edit1Change(Sender: TObject);
begin
   If not uFuncoes.Empty(Edit1.Text) Then
   begin
     If (rdCODIGO.Checked = True) Then
     begin
         With dmInfoADM.qryFornecedor do
         begin
              SQL.Clear;
              Sql.add('select * from ADMFOR where FOR_CDFORN like '
                 + quotedstr(uFuncoes.StrZero(edit1.Text,5)+'%') + ' order by FOR_NMFORN');
              ExecSQL;
              Open;
          End;
     End;
     //
     If (rbNOME.Checked = True) Then
     begin
           With dmInfoADM.qryFornecedor do
           begin
                SQL.Clear;
                Sql.add('select * from ADMFOR where FOR_NMFORN like ' + quotedstr(edit1.Text+'%') + ' order by FOR_NMFORN');
                ExecSQL;
                Open;
           End;
     End;
  End;
end;

procedure TfrmLocFornecedor.FormShow(Sender: TObject);
begin
   With dmInfoADM.qryFornecedor do
   begin
         sql.clear;
         sql.add('select * from ADMFOR order by FOR_NMFORN');
         execsql;
         open;
   End;
end;

procedure TfrmLocFornecedor.BtnConfirmarClick(Sender: TObject);
Var
    M_CDFORN : String;
begin
     M_CDFORN := dmInfoADM.qryFornecedor.fieldByName('FOR_CDFORN').AsString;
     //
     dmInfoADM.tbFornedores.Locate('FOR_CDFORN',M_CDFORN,[]);
     // Fechar janela de localizar
     close;
end;

procedure TfrmLocFornecedor.BtnCancelarClick(Sender: TObject);
begin
      Close;
end;

procedure TfrmLocFornecedor.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    if key = #13 then btnconfirmar.Click;
    if key = #13 then btncancelar.Click;
end;

procedure TfrmLocFornecedor.rdCODIGOClick(Sender: TObject);
begin
    Edit1.SetFocus;
end;

procedure TfrmLocFornecedor.rbNOMEClick(Sender: TObject);
begin
      Edit1.SetFocus;
end;

procedure TfrmLocFornecedor.GridDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

end.
