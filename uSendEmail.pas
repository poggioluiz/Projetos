unit uSendEmail;

interface

uses
  IniFiles, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdBaseComponent, IdMessage, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdAttachmentFile, IdText,
  System.Classes, System.SysUtils, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TSendEmail = class(TObject)
  private
    sFrom       :String;
    sHost       :String;
    sUserName   :String;
    sPassword   :String;
    sTo         :String;
    sAttachment :String;
    iPort       :Integer;

    procedure ReadIniFile;
    function EnviarEmail:Boolean;
  public
    function enviaXML(sNome, sIdentidade, sCPF, sTelefone, sEmail,
                             sEndereco, sCep, sNumero, sComplemento, sBairro,
                             sCidade, sEstado, sPais:String): Boolean;
  end;

implementation

{ TSendEmail }

procedure TSendEmail.ReadIniFile;
var
  IniFile :TIniFile;
begin
  IniFile     := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  sFrom       := IniFile.ReadString('Email' , 'From'      , sFrom);
  sHost       := IniFile.ReadString('Email' , 'Host'      , sHost);
  iPort       := IniFile.ReadInteger('Email', 'Port'      , iPort);
  sUserName   := IniFile.ReadString('Email' , 'UserName'  , sUserName);
  sPassword   := IniFile.ReadString('Email' , 'Password'  , sPassword);

  IniFile.Free;
end;

function TSendEmail.EnviarEmail:Boolean;
var
  IdMsg                : TIdMessage;
  IdText               : TIdText;
  IdSMTP               : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
  ReadIniFile;

  IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create();
  IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocket.SSLOptions.Mode   := sslmClient;

  idMsg              := TIdMessage.Create();
  idMsg.CharSet      := 'utf-8';
  idMsg.Encoding     := meMIME;
  idMsg.From.Name    := 'Cadastro de Cliente';
  idMsg.From.Address := sFrom;
  idMsg.Priority     := mpNormal;
  idMsg.Subject      := 'Informações do cliente';

  idMsg.Recipients.Add;
  idMsg.Recipients.EMailAddresses  := sTo;

  idText := TIdText.Create(idMsg.MessageParts);
  idText.Body.Add('Segue arquivo XML em anexo.');

  if not(sAttachment = EmptyStr) then
    if FileExists(sAttachment) then
      TIdAttachmentFile.Create(idMsg.MessageParts, sAttachment);

  IdSMTP           := TIdSMTP.Create();
  IdSMTP.IOHandler := IdSSLIOHandlerSocket;
  IdSMTP.UseTLS    := utUseImplicitTLS;
  IdSMTP.AuthType  := satDefault;
  IdSMTP.Host      := sHost;
  IdSMTP.AuthType  := satDefault;
  IdSMTP.Port      := iPort;
  IdSMTP.Username  := sUserName;
  IdSMTP.Password  := sPassword;

  try
    IdSMTP.Connect;
    IdSMTP.Authenticate;
  except
    begin
      Result := False;
      Exit;
    end;
  end;

  if IdSMTP.Connected then
  begin
    try
      IdSMTP.Send(idMsg);
    except
      begin
        Result := False;
        Exit;
      end;
    end;
  end;

  if IdSMTP.Connected then
    IdSMTP.Disconnect;

  Result := True;

  UnLoadOpenSSLLibrary;

  FreeAndNil(idMsg);
  FreeAndNil(IdSSLIOHandlerSocket);
  FreeAndNil(idSMTP);
end;

function TSendEmail.enviaXML(sNome, sIdentidade, sCPF, sTelefone, sEmail,
                             sEndereco, sCep, sNumero, sComplemento, sBairro,
                             sCidade, sEstado, sPais:String): Boolean;
Var
  blocoCliente   :IXMLNode;
  cliNome        :IXMLNode;
  cliIdentidade  :IXMLNode;
  cliCPF         :IXMLNode;
  cliTelefone    :IXMLNode;
  cliEmail       :IXMLNode;
  cliEndereco    :IXMLNode;
  cliCEP         :IXMLNode;
  cliNumero      :IXMLNode;
  cliComplemento :IXMLNode;
  cliBairro      :IXMLNode;
  cliCidade      :IXMLNode;
  cliEstado      :IXMLNode;
  cliPais        :IXMLNode;
  Xml            :TXMLDocument;
begin
  Xml := TXMLDocument.Create(nil);

  Xml.FileName := '';
  Xml.XML.Text := '';
  Xml.Active := False;
  Xml.Active := True;
  Xml.Version := '1.0';
  Xml.Encoding := 'UTF-8';

  blocoCliente := Xml.AddChild('CLIENTE');

  cliNome      := Xml.CreateNode('CliNome', ntElement);
  cliNome.Text := sNome;
  blocoCliente.ChildNodes.Add(cliNome);

  cliIdentidade      := Xml.CreateNode('CliIdentidade', ntElement);
  cliIdentidade.Text := sIdentidade;
  blocoCliente.ChildNodes.Add(cliIdentidade);

  cliCPF      := Xml.CreateNode('CliCPF', ntElement);
  cliCPF.Text := sCPF;
  blocoCliente.ChildNodes.Add(cliCPF);

  cliTelefone      := Xml.CreateNode('CliTelefone', ntElement);
  cliTelefone.Text := sTelefone;
  blocoCliente.ChildNodes.Add(cliTelefone);

  cliEmail      := Xml.CreateNode('CliEmail', ntElement);
  cliEmail.Text := sEmail;
  blocoCliente.ChildNodes.Add(cliEmail);

  cliEndereco      := Xml.CreateNode('CliEndereco', ntElement);
  cliEndereco.Text := sEndereco;
  blocoCliente.ChildNodes.Add(cliEndereco);

  cliCEP      := Xml.CreateNode('CliCEP', ntElement);
  cliCEP.Text := sCep;
  blocoCliente.ChildNodes.Add(cliCEP);

  cliNumero      := Xml.CreateNode('CliNumero', ntElement);
  cliNumero.Text := sNumero;
  blocoCliente.ChildNodes.Add(cliNumero);

  cliComplemento      := Xml.CreateNode('CliComplemento', ntElement);
  cliComplemento.Text := sComplemento;
  blocoCliente.ChildNodes.Add(cliComplemento);

  cliBairro      := Xml.CreateNode('CliBairro', ntElement);
  cliBairro.Text := sBairro;
  blocoCliente.ChildNodes.Add(cliBairro);

  cliCidade      := Xml.CreateNode('CliCidade', ntElement);
  cliCidade.Text := sCidade;
  blocoCliente.ChildNodes.Add(cliCidade);

  cliEstado      := Xml.CreateNode('CliEstado', ntElement);
  cliEstado.Text := sEstado;
  blocoCliente.ChildNodes.Add(cliEstado);

  cliPais      := Xml.CreateNode('CliPais', ntElement);
  cliPais.Text := sPais;
  blocoCliente.ChildNodes.Add(cliPais);

  sTo         := sEmail;
  sAttachment := ExtractFileDir(GetCurrentDir)+'\CadCli'+sNome+'.xml';
  Xml.SaveToFile(sAttachment);
  Xml.Active := False;

  if(EnviarEmail)then
    Result := True
  else
    Result := False;
end;

end.
