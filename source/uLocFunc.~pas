unit uLocFunc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, StdCtrls, ExtCtrls, DB;

type
  TfrmLocFunc = class(TForm)
    rbNOME: TRadioButton;
    rdCODIGO: TRadioButton;
    Edit1: TLabeledEdit;
    BtnConfirmar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    GridDados: TDBGrid;
    dsFuncionario: TDataSource;
    procedure rdCODIGOClick(Sender: TObject);
    procedure rbNOMEClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure GridDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocFunc: TfrmLocFunc;

implementation

Uses udmInfoADM, uFuncoes;

{$R *.dfm}

procedure TfrmLocFunc.rdCODIGOClick(Sender: TObject);
begin
     Edit1.SetFocus; 
end;

procedure TfrmLocFunc.rbNOMEClick(Sender: TObject);
begin
      Edit1.SetFocus;
end;

procedure TfrmLocFunc.BtnCancelarClick(Sender: TObject);
begin
      Close;
end;

procedure TfrmLocFunc.BtnConfirmarClick(Sender: TObject);
Var
    M_CDFUNC : String;
begin
     M_CDFUNC := dmInfoADM.qryFuncionario.fieldByName('FUN_CDFUNC').AsString;
     //
     dmInfoADM.tbFuncionarios.Locate('FUN_CDFUNC',M_CDFUNC,[]);
     // Fechar janela de localizar
     close;
end;

procedure TfrmLocFunc.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    if key = #13 then btnconfirmar.Click;
    if key = #13 then btncancelar.Click;
end;

procedure TfrmLocFunc.GridDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if (Shift = [ssCtrl]) and (Key = 46) Then
          KEY := 0;
end;

procedure TfrmLocFunc.Edit1Change(Sender: TObject);
begin
   If not uFuncoes.Empty(Edit1.Text) Then
   begin
     If (rdCODIGO.Checked = True) Then
     begin
         With dmInfoADM.qryFuncionario do
         begin
              SQL.Clear;
              Sql.add('select * from ADMFUN where FUN_CDFUNC like '
                 + quotedstr(uFuncoes.StrZero(edit1.Text,5)+'%') + ' order by FUN_NMFUNC');
              ExecSQL;
              Open;
          End;
     End;
     //
     If (rbNOME.Checked = True) Then
     begin
           With dmInfoADM.qryFuncionario do
           begin
                SQL.Clear;
                Sql.add('select * from ADMFUN where FUN_NMFUNC like '
                      + quotedstr(edit1.Text+'%') + ' order by FUN_NMFUNC');
                ExecSQL;
                Open;
           End;
     End;
  End;
end;

procedure TfrmLocFunc.FormShow(Sender: TObject);
begin
   With dmInfoADM.qryFuncionario do
   begin
         sql.clear;
         sql.add('select * from ADMFUN order by FUN_NMFUNC');
         execsql;
         open;
   End;
   //
   Edit1.SetFocus; 
end;

end.
