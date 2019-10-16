unit uCadCli;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uPesqEnd, uSendEmail,
  Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB, Vcl.Mask, Datasnap.DBClient;

type
  TfrmCadCli = class(TForm)
    lblNome: TLabel;
    lblRG: TLabel;
    lblCPF: TLabel;
    lblTelefone: TLabel;
    lblEmail: TLabel;
    lblCEP: TLabel;
    lblUF: TLabel;
    lblPais: TLabel;
    lblCidade: TLabel;
    lblBairro: TLabel;
    lblComplemento: TLabel;
    lblNumero: TLabel;
    Label3: TLabel;
    btnFinalizar: TButton;
    cdsCliente: TClientDataSet;
    cdsClientevdNome: TStringField;
    cdsClientevdRG: TStringField;
    cdsClientevdCPF: TStringField;
    cdsClientevdTelefone: TStringField;
    cdsClientevdEmail: TStringField;
    cdsClientevdCEP: TStringField;
    cdsClientevdPais: TStringField;
    cdsClientevdUF: TStringField;
    cdsClientevdCidade: TStringField;
    cdsClientevdBairro: TStringField;
    cdsClientevdLogradouro: TStringField;
    cdsClientevdComplemento: TStringField;
    cdsClientevdNumero: TStringField;
    edtNome: TDBEdit;
    dsCliente: TDataSource;
    edtRG: TDBEdit;
    edtCPF: TDBEdit;
    edtTelefone: TDBEdit;
    edtEmail: TDBEdit;
    edtCEP: TDBEdit;
    edtPais: TDBEdit;
    edtUF: TDBEdit;
    edtCidade: TDBEdit;
    edtBairro: TDBEdit;
    edtLogradouro: TDBEdit;
    edtComplemento: TDBEdit;
    Label14: TLabel;
    DBEdit13: TDBEdit;
    edtNumero: TDBEdit;
    btnInserir: TButton;
    btnEditar: TButton;
    DBNavigator1: TDBNavigator;
    btnCancelar: TButton;
    btnDeletar: TButton;
    procedure edtCEPExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
  private
    procedure TrataBtn;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCli: TfrmCadCli;
  pesqEnd: TPesqEnd;
  sendEmail: TSendEmail;

implementation

{$R *.dfm}

procedure TfrmCadCli.TrataBtn;
begin
  btnFinalizar.Enabled := cdsCliente.State IN [dsEdit,dsInsert];
  btnInserir.Enabled   := cdsCliente.State IN [dsBrowse];
  btnEditar.Enabled    := (cdsCliente.State IN [dsBrowse]) AND (not(cdsCliente.IsEmpty));
  btnCancelar.Enabled  := cdsCliente.State IN [dsEdit,dsInsert];
  btnDeletar.Enabled   := (cdsCliente.State IN [dsBrowse]) AND (not(cdsCliente.IsEmpty));
end;

procedure TfrmCadCli.FormCreate(Sender: TObject);
begin
  pesqEnd   := TPesqEnd.Create;
  sendEmail := TSendEmail.Create;
  cdsCliente.CreateDataSet;
  TrataBtn;
end;

procedure TfrmCadCli.edtCEPExit(Sender: TObject);
begin
  if(pesqEnd.validCEP(edtCEP.Text))then
  begin
    pesqEnd.ConsultaCEP(edtCEP.Text);

    edtUF.Text          := pesqEnd.GetUf;
    edtCidade.Text      := pesqEnd.GetLocalidade;
    edtComplemento.Text := pesqEnd.GetComplemento;
    edtLogradouro.Text  := pesqEnd.GetLogradouro;
    edtBairro.Text      := pesqEnd.GetBairro;
  end
  else
  begin
    ShowMessage('O CEP informado é inválido');
    edtCEP.SetFocus;
  end;
end;

procedure TfrmCadCli.btnFinalizarClick(Sender: TObject);
begin
  if(sendEmail.enviaXML(edtNome.text,
                        edtRG.Text,
                        edtCPF.Text,
                        edtTelefone.Text,
                        edtEmail.Text,
                        edtLogradouro.Text,
                        edtCEP.Text,
                        edtNumero.Text,
                        edtComplemento.Text,
                        edtBairro.Text,
                        edtCidade.Text,
                        edtUF.Text,
                        edtPais.Text))then
  begin
    ShowMessage('Finalizado com sucesso!');
    cdsCliente.Post;
  end
  else
    ShowMessage('Houve um erro na finalização, não foi possivel concluir esta ação!');
  TrataBtn;
end;

procedure TfrmCadCli.btnInserirClick(Sender: TObject);
begin
  cdsCliente.Insert;
  TrataBtn;
end;

procedure TfrmCadCli.btnEditarClick(Sender: TObject);
begin
  cdsCliente.Edit;
  TrataBtn;
end;

procedure TfrmCadCli.btnCancelarClick(Sender: TObject);
begin
  cdsCliente.Cancel;
  TrataBtn;
end;

procedure TfrmCadCli.btnDeletarClick(Sender: TObject);
begin
  cdsCliente.Delete;
  TrataBtn;
end;

end.
