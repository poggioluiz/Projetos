unit uPesqEnd;

interface

uses
  Data.DBXJSON, DBXJSONReflect,  idHTTP, IdSSLOpenSSL,
  System.JSON, System.Classes, System.SysUtils;

type
  TPesqEnd = class(TObject)
  private
    FCep         :String;
    FUf          :String;
    FLocalidade  :String;
    FBairro      :String;
    FLogradouro  :String;
    FComplemento :String;
  public
    procedure ConsultaCEP(CEP:String);

    function validCEP(CEP:String):Boolean;

    function GetCep:String;
    function GetUf:String;
    function GetLocalidade:String;
    function GetBairro:String;
    function GetLogradouro:String;
    function GetComplemento:String;
  end;

implementation

procedure TPesqEnd.ConsultaCEP(CEP: string);
var
  HTTP    : TIdHTTP;
  Handler : TIdSSLIOHandlerSocketOpenSSL;
  Response: TStringStream;
  JsonObj : TJSONObject;
begin
  try
    HTTP           := TIdHTTP.Create;
    Handler        := TIdSSLIOHandlerSocketOpenSSL.Create;
    HTTP.IOHandler := Handler;
    Response       := TStringStream.Create('');
    HTTP.Get('https://viacep.com.br/ws/' + CEP + '/json', Response);

    if (HTTP.ResponseCode = 200) and
    not(Utf8ToAnsi(Response.DataString) = '{'#$A'  "erro": true'#$A'}') then
    begin
      JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes( Utf8ToAnsi(Response.DataString)), 0) as TJSONObject;
      FCep         := UpperCase(JsonObj.Get('cep').JsonValue.Value);
      FUf          := UpperCase(JsonObj.Get('uf').JsonValue.Value);
      FLocalidade  := UpperCase(JsonObj.Get('localidade').JsonValue.Value);
      FBairro      := UpperCase(JsonObj.Get('bairro').JsonValue.Value);
      FLogradouro  := UpperCase(JsonObj.Get('logradouro').JsonValue.Value);
      FComplemento := UpperCase(JsonObj.Get('complemento').JsonValue.Value);
    end;
    finally
      FreeAndNil(HTTP);
      FreeAndNil(Handler);
      Response.Destroy;
  end;
end;

function TPesqEnd.validCEP(CEP: String): Boolean;
begin
  Result := False;

  if(length(CEP) = 8 )then
  begin
    try
      StrToInt(CEP);
      Result := True;
    Except
    end;
  end;
end;

function TPesqEnd.GetBairro: String;
begin
  Result := FBairro;
end;

function TPesqEnd.GetCep: String;
begin
  Result := FCep;
end;

function TPesqEnd.GetComplemento: String;
begin
  Result := FComplemento;
end;

function TPesqEnd.GetLocalidade: String;
begin
  Result := FLocalidade;
end;

function TPesqEnd.GetLogradouro: String;
begin
  Result := FLogradouro;
end;

function TPesqEnd.GetUf: String;
begin
  Result := FUf;
end;

end.
