
{***********************************************************************************************************************************************************************}
{                                                                                                                                                                       }
{                                                                           XML-Datenbindung                                                                            }
{                                                                                                                                                                       }
{         Generiert am: 11.08.2023 16:23:38                                                                                                                             }
{       Generiert von: D:\Benutzer\Vladimir\Documents\Embarcadero\Studio\Projekte\Zeugnis_LL26_FireDAC\Schuler\Klasse 2b_Jusufi Elez Bericht GesprGrdl.xml              }
{   Einstellungen gespeichert in: D:\Benutzer\Vladimir\Documents\Embarcadero\Studio\Projekte\Zeugnis_LL26_FireDAC\Schuler\Klasse 2b_Jusufi Elez Bericht GesprGrdl.xdb   }
{                                                                                                                                                                       }
{***********************************************************************************************************************************************************************}

unit ZeugnisXML;

interface

uses Xml.xmldom, Xml.XMLDoc, Xml.XMLIntf;

type

{ Forward-Deklarationen }

  IXMLZeugnisType = interface;
  IXMLPersonalDatenType = interface;
  IXMLZeugnisInhaltType = interface;
  IXMLFachType = interface;
  IXMLTextFachType = interface;
  IXMLRTFTextType = interface;
  IXMLPLATZHALTERType = interface;
  IXMLNUMMERType = interface;
  IXMLBemerkungType = interface;
  IXMLPunktType = interface;
  IXMLPunktTypeList = interface;
  IXMLFontType = interface;
  IXMLFachZusatzType = interface;
  IXMLPLATZHALTERType2 = interface;

{ IXMLZeugnisType }

  IXMLZeugnisType = interface(IXMLNode)
    ['{7C9A2097-8131-4CF1-857A-7DE3C8F3142B}']
    { Eigenschaftszugriff }
    function Get_Klasse: UnicodeString;
    function Get_Version: Integer;
    function Get_Bericht: Boolean;
    function Get_GesprGrdl: Boolean;
    function Get_Foerderschwerpunkt: Boolean;
    function Get_Nachname: UnicodeString;
    function Get_Vorname: UnicodeString;
    function Get_LastChange: TDateTime;
    function Get_PersonalDaten: IXMLPersonalDatenType;
    function Get_ZeugnisInhalt: IXMLZeugnisInhaltType;
    function Get_ZeugnisInhaltGGL: IXMLZeugnisInhaltType;
    procedure Set_Klasse(const Value: UnicodeString);
    procedure Set_Version(const Value: Integer);
    procedure Set_Bericht(const Value: Boolean);
    procedure Set_GesprGrdl(const Value: Boolean);
    procedure Set_Foerderschwerpunkt(const Value: Boolean);
    procedure Set_Nachname(const Value: UnicodeString);
    procedure Set_Vorname(const Value: UnicodeString);
    procedure Set_LastChange(const Value: TDateTime);
    { Methoden & Eigenschaften }
    property Klasse: UnicodeString read Get_Klasse write Set_Klasse;
    property Version: Integer read Get_Version write Set_Version;
    property Bericht: Boolean read Get_Bericht write Set_Bericht;
    property GesprGrdl: Boolean read Get_GesprGrdl write Set_GesprGrdl;
    property Foerderschwerpunkt: Boolean read Get_Foerderschwerpunkt write Set_Foerderschwerpunkt;
    property Nachname: UnicodeString read Get_Nachname write Set_Nachname;
    property Vorname: UnicodeString read Get_Vorname write Set_Vorname;
    property LastChange: TDateTime read Get_LastChange write Set_LastChange;
    property PersonalDaten: IXMLPersonalDatenType read Get_PersonalDaten;
    property ZeugnisInhalt: IXMLZeugnisInhaltType read Get_ZeugnisInhalt;
    property ZeugnisInhaltGGL: IXMLZeugnisInhaltType read Get_ZeugnisInhaltGGL;
  end;

{ IXMLPersonalDatenType }

  IXMLPersonalDatenType = interface(IXMLNode)
    ['{7BB35723-9C19-4BC1-9C90-D7CCA64DC3D8}']
    { Eigenschaftszugriff }
    function Get_Nachname: UnicodeString;
    function Get_Vorname: UnicodeString;
    function Get_KlasseZiffer: Integer;
    function Get_KlasseBuchstabe: UnicodeString;
    function Get_Schuljahr: UnicodeString;
    function Get_Halbjahr: Integer;
    function Get_Konferenz: TDateTime;
    function Get_Ausstellungsdatum: TDateTime;
    function Get_Versaeumnisse2: UnicodeString;
    function Get_Foerderschwerpunkt: UnicodeString;
    procedure Set_Nachname(const Value: UnicodeString);
    procedure Set_Vorname(const Value: UnicodeString);
    procedure Set_KlasseZiffer(const Value: Integer);
    procedure Set_KlasseBuchstabe(const Value: UnicodeString);
    procedure Set_Schuljahr(const Value: UnicodeString);
    procedure Set_Halbjahr(const Value: Integer);
    procedure Set_Konferenz(const Value: TDateTime);
    procedure Set_Ausstellungsdatum(const Value: TDateTime);
    procedure Set_Versaeumnisse2(const Value: UnicodeString);
    procedure Set_Foerderschwerpunkt(const Value: UnicodeString);
    { Methoden & Eigenschaften }
    property Nachname: UnicodeString read Get_Nachname write Set_Nachname;
    property Vorname: UnicodeString read Get_Vorname write Set_Vorname;
    property KlasseZiffer: Integer read Get_KlasseZiffer write Set_KlasseZiffer;
    property KlasseBuchstabe: UnicodeString read Get_KlasseBuchstabe write Set_KlasseBuchstabe;
    property Schuljahr: UnicodeString read Get_Schuljahr write Set_Schuljahr;
    property Halbjahr: Integer read Get_Halbjahr write Set_Halbjahr;
    property Konferenz: TDateTime read Get_Konferenz write Set_Konferenz;
    property Ausstellungsdatum: TDateTime read Get_Ausstellungsdatum write Set_Ausstellungsdatum;
    property Versaeumnisse2: UnicodeString read Get_Versaeumnisse2 write Set_Versaeumnisse2;
    property Foerderschwerpunkt: UnicodeString read Get_Foerderschwerpunkt write Set_Foerderschwerpunkt;
  end;

{ IXMLZeugnisInhaltType }

  IXMLZeugnisInhaltType = interface(IXMLNodeCollection)
    ['{A4781FDB-980A-412E-8429-672A5534072E}']
    { Eigenschaftszugriff }
    function Get_Bezeichnung: UnicodeString;
    function Get_Fach(const Index: Integer): IXMLFachType;
    procedure Set_Bezeichnung(const Value: UnicodeString);
    { Methoden & Eigenschaften }
    function Add: IXMLFachType;
    function Insert(const Index: Integer): IXMLFachType;
    property Bezeichnung: UnicodeString read Get_Bezeichnung write Set_Bezeichnung;
    property Fach[const Index: Integer]: IXMLFachType read Get_Fach; default;
  end;

{ IXMLFachType }

  IXMLFachType = interface(IXMLNode)
    ['{FC08D5DA-C499-4B87-846D-D314AD575B10}']
    { Eigenschaftszugriff }
    function Get_Name: UnicodeString;
    function Get_Bezeichnung: UnicodeString;
    function Get_Seitenumbruch: Boolean;
    function Get_Torten: Boolean;
    function Get_Kompetenz: Boolean;
    function Get_Aktiv: Boolean;
    function Get_TextFach: IXMLTextFachType;
    function Get_Bemerkung: IXMLBemerkungType;
    function Get_Punkt: IXMLPunktTypeList;
    function Get_FachZusatz: IXMLFachZusatzType;
    procedure Set_Name(const Value: UnicodeString);
    procedure Set_Bezeichnung(const Value: UnicodeString);
    procedure Set_Seitenumbruch(const Value: Boolean);
    procedure Set_Torten(const Value: Boolean);
    procedure Set_Kompetenz(const Value: Boolean);
    procedure Set_Aktiv(const Value: Boolean);
    { Methoden & Eigenschaften }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Bezeichnung: UnicodeString read Get_Bezeichnung write Set_Bezeichnung;
    property Seitenumbruch: Boolean read Get_Seitenumbruch write Set_Seitenumbruch;
    property Torten: Boolean read Get_Torten write Set_Torten;
    property Kompetenz: Boolean read Get_Kompetenz write Set_Kompetenz;
    property Aktiv: Boolean read Get_Aktiv write Set_Aktiv;
    property TextFach: IXMLTextFachType read Get_TextFach;
    property Bemerkung: IXMLBemerkungType read Get_Bemerkung;
    property Punkt: IXMLPunktTypeList read Get_Punkt;
    property FachZusatz: IXMLFachZusatzType read Get_FachZusatz;
  end;

{ IXMLTextFachType }

  IXMLTextFachType = interface(IXMLNode)
    ['{97ADB763-B8DC-4428-AA42-0D830123B5EF}']
    { Eigenschaftszugriff }
    function Get_RTFText: IXMLRTFTextType;
    function Get_PLATZHALTER: IXMLPLATZHALTERType;
    { Methoden & Eigenschaften }
    property RTFText: IXMLRTFTextType read Get_RTFText;
    property PLATZHALTER: IXMLPLATZHALTERType read Get_PLATZHALTER;
  end;

{ IXMLRTFTextType }

  IXMLRTFTextType = interface(IXMLNode)
    ['{231CE221-8C93-46BC-9BC6-DA662550474C}']
    { Eigenschaftszugriff }
    function Get_Schriftgrad: Integer;
    procedure Set_Schriftgrad(const Value: Integer);
    { Methoden & Eigenschaften }
    property Schriftgrad: Integer read Get_Schriftgrad write Set_Schriftgrad;
  end;

{ IXMLPLATZHALTERType }

  IXMLPLATZHALTERType = interface(IXMLNodeCollection)
    ['{5E3872BD-204B-4C10-9880-CDAA5C3FB5C6}']
    { Eigenschaftszugriff }
    function Get_NUMMER(const Index: Integer): IXMLNUMMERType;
    { Methoden & Eigenschaften }
    function Add: IXMLNUMMERType;
    function Insert(const Index: Integer): IXMLNUMMERType;
    property NUMMER[const Index: Integer]: IXMLNUMMERType read Get_NUMMER; default;
  end;

{ IXMLNUMMERType }

  IXMLNUMMERType = interface(IXMLNode)
    ['{D213B428-D231-4CDF-AC0E-AF332B04C82A}']
    { Eigenschaftszugriff }
    function Get_NAME: UnicodeString;
    function Get_VALUE01: Integer;
    function Get_VALUE02: Integer;
    function Get_VALUE03: Integer;
    function Get_VALUE04: Integer;
    function Get_VALUE05: Integer;
    function Get_VALUE06: Integer;
    procedure Set_NAME(const Value: UnicodeString);
    procedure Set_VALUE01(const Value: Integer);
    procedure Set_VALUE02(const Value: Integer);
    procedure Set_VALUE03(const Value: Integer);
    procedure Set_VALUE04(const Value: Integer);
    procedure Set_VALUE05(const Value: Integer);
    procedure Set_VALUE06(const Value: Integer);
    { Methoden & Eigenschaften }
    property NAME: UnicodeString read Get_NAME write Set_NAME;
    property VALUE01: Integer read Get_VALUE01 write Set_VALUE01;
    property VALUE02: Integer read Get_VALUE02 write Set_VALUE02;
    property VALUE03: Integer read Get_VALUE03 write Set_VALUE03;
    property VALUE04: Integer read Get_VALUE04 write Set_VALUE04;
    property VALUE05: Integer read Get_VALUE05 write Set_VALUE05;
    property VALUE06: Integer read Get_VALUE06 write Set_VALUE06;
  end;

{ IXMLBemerkungType }

  IXMLBemerkungType = interface(IXMLNode)
    ['{ECC1F0C8-ECF9-42C0-91E8-24B7DE867A01}']
    { Eigenschaftszugriff }
    function Get_SortNr: Integer;
    function Get_Text: UnicodeString;
    function Get_Schriftgrad: Integer;
    procedure Set_SortNr(const Value: Integer);
    procedure Set_Text(const Value: UnicodeString);
    procedure Set_Schriftgrad(const Value: Integer);
    { Methoden & Eigenschaften }
    property SortNr: Integer read Get_SortNr write Set_SortNr;
    property Text: UnicodeString read Get_Text write Set_Text;
    property Schriftgrad: Integer read Get_Schriftgrad write Set_Schriftgrad;
  end;

{ IXMLPunktType }

  IXMLPunktType = interface(IXMLNode)
    ['{0F52C7C5-3BFC-4465-AC1C-BD1E4B01B399}']
    { Eigenschaftszugriff }
    function Get_SortNr: Integer;
    function Get_Text: UnicodeString;
    function Get_Farbe: UnicodeString;
    function Get_Font: IXMLFontType;
    function Get_Wert: Integer;
    procedure Set_SortNr(const Value: Integer);
    procedure Set_Text(const Value: UnicodeString);
    procedure Set_Farbe(const Value: UnicodeString);
    procedure Set_Wert(const Value: Integer);
    { Methoden & Eigenschaften }
    property SortNr: Integer read Get_SortNr write Set_SortNr;
    property Text: UnicodeString read Get_Text write Set_Text;
    property Farbe: UnicodeString read Get_Farbe write Set_Farbe;
    property Font: IXMLFontType read Get_Font;
    property Wert: Integer read Get_Wert write Set_Wert;
  end;

{ IXMLPunktTypeList }

  IXMLPunktTypeList = interface(IXMLNodeCollection)
    ['{1AE0EBB2-3C15-46F9-8B36-8B7E9ECB32C1}']
    { Methoden & Eigenschaften }
    function Add: IXMLPunktType;
    function Insert(const Index: Integer): IXMLPunktType;

    function Get_Item(const Index: Integer): IXMLPunktType;
    property Items[const Index: Integer]: IXMLPunktType read Get_Item; default;
  end;

{ IXMLFontType }

  IXMLFontType = interface(IXMLNode)
    ['{97356341-7C66-439C-B21B-071926675723}']
    { Eigenschaftszugriff }
    function Get_FontStyle: UnicodeString;
    procedure Set_FontStyle(const Value: UnicodeString);
    { Methoden & Eigenschaften }
    property FontStyle: UnicodeString read Get_FontStyle write Set_FontStyle;
  end;

{ IXMLFachZusatzType }

  IXMLFachZusatzType = interface(IXMLNode)
    ['{EF513CD4-BFD0-491F-AD1C-4DF90CF76B81}']
    { Eigenschaftszugriff }
    function Get_LabelText1: UnicodeString;
    function Get_Text: UnicodeString;
    function Get_LabelText2: UnicodeString;
    procedure Set_LabelText1(const Value: UnicodeString);
    procedure Set_Text(const Value: UnicodeString);
    procedure Set_LabelText2(const Value: UnicodeString);
    { Methoden & Eigenschaften }
    property LabelText1: UnicodeString read Get_LabelText1 write Set_LabelText1;
    property Text: UnicodeString read Get_Text write Set_Text;
    property LabelText2: UnicodeString read Get_LabelText2 write Set_LabelText2;
  end;

{ IXMLPLATZHALTERType2 }

  IXMLPLATZHALTERType2 = interface(IXMLNode)
    ['{96522735-6692-4D0C-8E36-67A65FC76D8C}']
  end;

{ Forward-Deklarationen }

  TXMLZeugnisType = class;
  TXMLPersonalDatenType = class;
  TXMLZeugnisInhaltType = class;
  TXMLFachType = class;
  TXMLTextFachType = class;
  TXMLRTFTextType = class;
  TXMLPLATZHALTERType = class;
  TXMLNUMMERType = class;
  TXMLBemerkungType = class;
  TXMLPunktType = class;
  TXMLPunktTypeList = class;
  TXMLFontType = class;
  TXMLFachZusatzType = class;
  TXMLPLATZHALTERType2 = class;

{ TXMLZeugnisType }

  TXMLZeugnisType = class(TXMLNode, IXMLZeugnisType)
  protected
    { IXMLZeugnisType }
    function Get_Klasse: UnicodeString;
    function Get_Version: Integer;
    function Get_Bericht: Boolean;
    function Get_GesprGrdl: Boolean;
    function Get_Foerderschwerpunkt: Boolean;
    function Get_Nachname: UnicodeString;
    function Get_Vorname: UnicodeString;
    function Get_LastChange: TDateTime;
    function Get_PersonalDaten: IXMLPersonalDatenType;
    function Get_ZeugnisInhalt: IXMLZeugnisInhaltType;
    function Get_ZeugnisInhaltGGL: IXMLZeugnisInhaltType;
    procedure Set_Klasse(const Value: UnicodeString);
    procedure Set_Version(const Value: Integer);
    procedure Set_Bericht(const Value: Boolean);
    procedure Set_GesprGrdl(const Value: Boolean);
    procedure Set_Foerderschwerpunkt(const Value: Boolean);
    procedure Set_Nachname(const Value: UnicodeString);
    procedure Set_Vorname(const Value: UnicodeString);
    procedure Set_LastChange(const Value: TDateTime);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPersonalDatenType }

  TXMLPersonalDatenType = class(TXMLNode, IXMLPersonalDatenType)
  protected
    { IXMLPersonalDatenType }
    function Get_Nachname: UnicodeString;
    function Get_Vorname: UnicodeString;
    function Get_KlasseZiffer: Integer;
    function Get_KlasseBuchstabe: UnicodeString;
    function Get_Schuljahr: UnicodeString;
    function Get_Halbjahr: Integer;
    function Get_Konferenz: TDateTime;
    function Get_Ausstellungsdatum: TDateTime;
    function Get_Versaeumnisse2: UnicodeString;
    function Get_Foerderschwerpunkt: UnicodeString;
    procedure Set_Nachname(const Value: UnicodeString);
    procedure Set_Vorname(const Value: UnicodeString);
    procedure Set_KlasseZiffer(const Value: Integer);
    procedure Set_KlasseBuchstabe(const Value: UnicodeString);
    procedure Set_Schuljahr(const Value: UnicodeString);
    procedure Set_Halbjahr(const Value: Integer);
    procedure Set_Konferenz(const Value: TDateTime);
    procedure Set_Ausstellungsdatum(const Value: TDateTime);
    procedure Set_Versaeumnisse2(const Value: UnicodeString);
    procedure Set_Foerderschwerpunkt(const Value: UnicodeString);
  end;

{ TXMLZeugnisInhaltType }

  TXMLZeugnisInhaltType = class(TXMLNodeCollection, IXMLZeugnisInhaltType)
  protected
    { IXMLZeugnisInhaltType }
    function Get_Bezeichnung: UnicodeString;
    function Get_Fach(const Index: Integer): IXMLFachType;
    procedure Set_Bezeichnung(const Value: UnicodeString);
    function Add: IXMLFachType;
    function Insert(const Index: Integer): IXMLFachType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFachType }

  TXMLFachType = class(TXMLNode, IXMLFachType)
  private
    FPunkt: IXMLPunktTypeList;
  protected
    { IXMLFachType }
    function Get_Name: UnicodeString;
    function Get_Bezeichnung: UnicodeString;
    function Get_Seitenumbruch: Boolean;
    function Get_Torten: Boolean;
    function Get_Kompetenz: Boolean;
    function Get_Aktiv: Boolean;
    function Get_TextFach: IXMLTextFachType;
    function Get_Bemerkung: IXMLBemerkungType;
    function Get_Punkt: IXMLPunktTypeList;
    function Get_FachZusatz: IXMLFachZusatzType;
    procedure Set_Name(const Value: UnicodeString);
    procedure Set_Bezeichnung(const Value: UnicodeString);
    procedure Set_Seitenumbruch(const Value: Boolean);
    procedure Set_Torten(const Value: Boolean);
    procedure Set_Kompetenz(const Value: Boolean);
    procedure Set_Aktiv(const Value: Boolean);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTextFachType }

  TXMLTextFachType = class(TXMLNode, IXMLTextFachType)
  protected
    { IXMLTextFachType }
    function Get_RTFText: IXMLRTFTextType;
    function Get_PLATZHALTER: IXMLPLATZHALTERType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRTFTextType }

  TXMLRTFTextType = class(TXMLNode, IXMLRTFTextType)
  protected
    { IXMLRTFTextType }
    function Get_Schriftgrad: Integer;
    procedure Set_Schriftgrad(const Value: Integer);
  end;

{ TXMLPLATZHALTERType }

  TXMLPLATZHALTERType = class(TXMLNodeCollection, IXMLPLATZHALTERType)
  protected
    { IXMLPLATZHALTERType }
    function Get_NUMMER(const Index: Integer): IXMLNUMMERType;
    function Add: IXMLNUMMERType;
    function Insert(const Index: Integer): IXMLNUMMERType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNUMMERType }

  TXMLNUMMERType = class(TXMLNode, IXMLNUMMERType)
  protected
    { IXMLNUMMERType }
    function Get_NAME: UnicodeString;
    function Get_VALUE01: Integer;
    function Get_VALUE02: Integer;
    function Get_VALUE03: Integer;
    function Get_VALUE04: Integer;
    function Get_VALUE05: Integer;
    function Get_VALUE06: Integer;
    procedure Set_NAME(const Value: UnicodeString);
    procedure Set_VALUE01(const Value: Integer);
    procedure Set_VALUE02(const Value: Integer);
    procedure Set_VALUE03(const Value: Integer);
    procedure Set_VALUE04(const Value: Integer);
    procedure Set_VALUE05(const Value: Integer);
    procedure Set_VALUE06(const Value: Integer);
  end;

{ TXMLBemerkungType }

  TXMLBemerkungType = class(TXMLNode, IXMLBemerkungType)
  protected
    { IXMLBemerkungType }
    function Get_SortNr: Integer;
    function Get_Text: UnicodeString;
    function Get_Schriftgrad: Integer;
    procedure Set_SortNr(const Value: Integer);
    procedure Set_Text(const Value: UnicodeString);
    procedure Set_Schriftgrad(const Value: Integer);
  end;

{ TXMLPunktType }

  TXMLPunktType = class(TXMLNode, IXMLPunktType)
  protected
    { IXMLPunktType }
    function Get_SortNr: Integer;
    function Get_Text: UnicodeString;
    function Get_Farbe: UnicodeString;
    function Get_Font: IXMLFontType;
    function Get_Wert: Integer;
    procedure Set_SortNr(const Value: Integer);
    procedure Set_Text(const Value: UnicodeString);
    procedure Set_Farbe(const Value: UnicodeString);
    procedure Set_Wert(const Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPunktTypeList }

  TXMLPunktTypeList = class(TXMLNodeCollection, IXMLPunktTypeList)
  protected
    { IXMLPunktTypeList }
    function Add: IXMLPunktType;
    function Insert(const Index: Integer): IXMLPunktType;

    function Get_Item(const Index: Integer): IXMLPunktType;
  end;

{ TXMLFontType }

  TXMLFontType = class(TXMLNode, IXMLFontType)
  protected
    { IXMLFontType }
    function Get_FontStyle: UnicodeString;
    procedure Set_FontStyle(const Value: UnicodeString);
  end;

{ TXMLFachZusatzType }

  TXMLFachZusatzType = class(TXMLNode, IXMLFachZusatzType)
  protected
    { IXMLFachZusatzType }
    function Get_LabelText1: UnicodeString;
    function Get_Text: UnicodeString;
    function Get_LabelText2: UnicodeString;
    procedure Set_LabelText1(const Value: UnicodeString);
    procedure Set_Text(const Value: UnicodeString);
    procedure Set_LabelText2(const Value: UnicodeString);
  end;

{ TXMLPLATZHALTERType2 }

  TXMLPLATZHALTERType2 = class(TXMLNode, IXMLPLATZHALTERType2)
  protected
    { IXMLPLATZHALTERType2 }
  end;

{ Globale Funktionen }

function GetZeugnis(Doc: IXMLDocument): IXMLZeugnisType;
function LoadZeugnis(const FileName: string): IXMLZeugnisType;
function NewZeugnis: IXMLZeugnisType;

const
  TargetNamespace = '';

implementation

uses System.Variants, System.SysUtils, Xml.xmlutil;

{ Globale Funktionen }

function GetZeugnis(Doc: IXMLDocument): IXMLZeugnisType;
begin
  Result := Doc.GetDocBinding('Zeugnis', TXMLZeugnisType, TargetNamespace) as IXMLZeugnisType;
end;

function LoadZeugnis(const FileName: string): IXMLZeugnisType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Zeugnis', TXMLZeugnisType, TargetNamespace) as IXMLZeugnisType;
end;

function NewZeugnis: IXMLZeugnisType;
begin
  Result := NewXMLDocument.GetDocBinding('Zeugnis', TXMLZeugnisType, TargetNamespace) as IXMLZeugnisType;
end;

{ TXMLZeugnisType }

procedure TXMLZeugnisType.AfterConstruction;
begin
  RegisterChildNode('PersonalDaten', TXMLPersonalDatenType);
  RegisterChildNode('ZeugnisInhalt', TXMLZeugnisInhaltType);
  RegisterChildNode('ZeugnisInhaltGGL', TXMLZeugnisInhaltType);
  inherited;
end;

function TXMLZeugnisType.Get_Klasse: UnicodeString;
begin
  Result := AttributeNodes['Klasse'].Text;
end;

procedure TXMLZeugnisType.Set_Klasse(const Value: UnicodeString);
begin
  SetAttribute('Klasse', Value);
end;

function TXMLZeugnisType.Get_Version: Integer;
begin
  Result := XmlStrToInt(AttributeNodes['Version'].Text);
end;

procedure TXMLZeugnisType.Set_Version(const Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLZeugnisType.Get_Bericht: Boolean;
begin
  Result := XmlStrToBool(AttributeNodes['Bericht'].Text);
end;

procedure TXMLZeugnisType.Set_Bericht(const Value: Boolean);
begin
  SetAttribute('Bericht', Value);
end;

function TXMLZeugnisType.Get_GesprGrdl: Boolean;
begin
  Result := XmlStrToBool(AttributeNodes['GesprGrdl'].Text);
end;

procedure TXMLZeugnisType.Set_GesprGrdl(const Value: Boolean);
begin
  SetAttribute('GesprGrdl', Value);
end;

function TXMLZeugnisType.Get_Foerderschwerpunkt: Boolean;
begin
  Result := XmlStrToBool(AttributeNodes['Foerderschwerpunkt'].Text);
end;

procedure TXMLZeugnisType.Set_Foerderschwerpunkt(const Value: Boolean);
begin
  SetAttribute('Foerderschwerpunkt', Value);
end;

function TXMLZeugnisType.Get_Nachname: UnicodeString;
begin
  Result := AttributeNodes['Nachname'].Text;
end;

procedure TXMLZeugnisType.Set_Nachname(const Value: UnicodeString);
begin
  SetAttribute('Nachname', Value);
end;

function TXMLZeugnisType.Get_Vorname: UnicodeString;
begin
  Result := AttributeNodes['Vorname'].Text;
end;

procedure TXMLZeugnisType.Set_Vorname(const Value: UnicodeString);
begin
  SetAttribute('Vorname', Value);
end;

function TXMLZeugnisType.Get_LastChange: TDateTime;
begin
  Result := XmlStrToDateTime(AttributeNodes['LastChange'].Text);
end;

procedure TXMLZeugnisType.Set_LastChange(const Value: TDateTime);
begin
  SetAttribute('LastChange', Value);
end;

function TXMLZeugnisType.Get_PersonalDaten: IXMLPersonalDatenType;
begin
  Result := ChildNodes['PersonalDaten'] as IXMLPersonalDatenType;
end;

function TXMLZeugnisType.Get_ZeugnisInhalt: IXMLZeugnisInhaltType;
begin
  Result := ChildNodes['ZeugnisInhalt'] as IXMLZeugnisInhaltType;
end;

function TXMLZeugnisType.Get_ZeugnisInhaltGGL: IXMLZeugnisInhaltType;
begin
  Result := ChildNodes['ZeugnisInhaltGGL'] as IXMLZeugnisInhaltType;
end;

{ TXMLPersonalDatenType }

function TXMLPersonalDatenType.Get_Nachname: UnicodeString;
begin
  Result := ChildNodes['Nachname'].Text;
end;

procedure TXMLPersonalDatenType.Set_Nachname(const Value: UnicodeString);
begin
  ChildNodes['Nachname'].NodeValue := Value;
end;

function TXMLPersonalDatenType.Get_Vorname: UnicodeString;
begin
  Result := ChildNodes['Vorname'].Text;
end;

procedure TXMLPersonalDatenType.Set_Vorname(const Value: UnicodeString);
begin
  ChildNodes['Vorname'].NodeValue := Value;
end;

function TXMLPersonalDatenType.Get_KlasseZiffer: Integer;
begin
  Result := XmlStrToInt(ChildNodes['KlasseZiffer'].Text);
end;

procedure TXMLPersonalDatenType.Set_KlasseZiffer(const Value: Integer);
begin
  ChildNodes['KlasseZiffer'].NodeValue := Value;
end;

function TXMLPersonalDatenType.Get_KlasseBuchstabe: UnicodeString;
begin
  Result := ChildNodes['KlasseBuchstabe'].Text;
end;

procedure TXMLPersonalDatenType.Set_KlasseBuchstabe(const Value: UnicodeString);
begin
  ChildNodes['KlasseBuchstabe'].NodeValue := Value;
end;

function TXMLPersonalDatenType.Get_Schuljahr: UnicodeString;
begin
  Result := ChildNodes['Schuljahr'].Text;
end;

procedure TXMLPersonalDatenType.Set_Schuljahr(const Value: UnicodeString);
begin
  ChildNodes['Schuljahr'].NodeValue := Value;
end;

function TXMLPersonalDatenType.Get_Halbjahr: Integer;
begin
  Result := XmlStrToInt(ChildNodes['Halbjahr'].Text);
end;

procedure TXMLPersonalDatenType.Set_Halbjahr(const Value: Integer);
begin
  ChildNodes['Halbjahr'].NodeValue := Value;
end;

function TXMLPersonalDatenType.Get_Konferenz: TDateTime;
begin
  Result := XmlStrToDateTime(ChildNodes['Konferenz'].Text);
end;

procedure TXMLPersonalDatenType.Set_Konferenz(const Value: TDateTime);
begin
  ChildNodes['Konferenz'].NodeValue := Value;
end;

function TXMLPersonalDatenType.Get_Ausstellungsdatum: TDateTime;
begin
  Result := XmlStrToDateTime(ChildNodes['Ausstellungsdatum'].Text);
end;

procedure TXMLPersonalDatenType.Set_Ausstellungsdatum(const Value: TDateTime);
begin
  ChildNodes['Ausstellungsdatum'].NodeValue := Value;
end;

function TXMLPersonalDatenType.Get_Versaeumnisse2: UnicodeString;
begin
  Result := ChildNodes['Versaeumnisse2'].Text;
end;

procedure TXMLPersonalDatenType.Set_Versaeumnisse2(const Value: UnicodeString);
begin
  ChildNodes['Versaeumnisse2'].NodeValue := Value;
end;

function TXMLPersonalDatenType.Get_Foerderschwerpunkt: UnicodeString;
begin
  Result := ChildNodes['Foerderschwerpunkt'].Text;
end;

procedure TXMLPersonalDatenType.Set_Foerderschwerpunkt(const Value: UnicodeString);
begin
  ChildNodes['Foerderschwerpunkt'].NodeValue := Value;
end;

{ TXMLZeugnisInhaltType }

procedure TXMLZeugnisInhaltType.AfterConstruction;
begin
  RegisterChildNode('Fach', TXMLFachType);
  ItemTag := 'Fach';
  ItemInterface := IXMLFachType;
  inherited;
end;

function TXMLZeugnisInhaltType.Get_Bezeichnung: UnicodeString;
begin
  Result := AttributeNodes['Bezeichnung'].Text;
end;

procedure TXMLZeugnisInhaltType.Set_Bezeichnung(const Value: UnicodeString);
begin
  SetAttribute('Bezeichnung', Value);
end;

function TXMLZeugnisInhaltType.Get_Fach(const Index: Integer): IXMLFachType;
begin
  Result := List[Index] as IXMLFachType;
end;

function TXMLZeugnisInhaltType.Add: IXMLFachType;
begin
  Result := AddItem(-1) as IXMLFachType;
end;

function TXMLZeugnisInhaltType.Insert(const Index: Integer): IXMLFachType;
begin
  Result := AddItem(Index) as IXMLFachType;
end;

{ TXMLFachType }

procedure TXMLFachType.AfterConstruction;
begin
  RegisterChildNode('TextFach', TXMLTextFachType);
  RegisterChildNode('Bemerkung', TXMLBemerkungType);
  RegisterChildNode('Punkt', TXMLPunktType);
  RegisterChildNode('FachZusatz', TXMLFachZusatzType);
  FPunkt := CreateCollection(TXMLPunktTypeList, IXMLPunktType, 'Punkt') as IXMLPunktTypeList;
  inherited;
end;

function TXMLFachType.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['Name'].Text;
end;

procedure TXMLFachType.Set_Name(const Value: UnicodeString);
begin
  SetAttribute('Name', Value);
end;

function TXMLFachType.Get_Bezeichnung: UnicodeString;
begin
  Result := AttributeNodes['Bezeichnung'].Text;
end;

procedure TXMLFachType.Set_Bezeichnung(const Value: UnicodeString);
begin
  SetAttribute('Bezeichnung', Value);
end;

function TXMLFachType.Get_Seitenumbruch: Boolean;
begin
  Result := XmlStrToBool(AttributeNodes['Seitenumbruch'].Text);
end;

procedure TXMLFachType.Set_Seitenumbruch(const Value: Boolean);
begin
  SetAttribute('Seitenumbruch', Value);
end;

function TXMLFachType.Get_Torten: Boolean;
begin
  Result := XmlStrToBool(AttributeNodes['Torten'].Text);
end;

procedure TXMLFachType.Set_Torten(const Value: Boolean);
begin
  SetAttribute('Torten', Value);
end;

function TXMLFachType.Get_Kompetenz: Boolean;
begin
  Result := XmlStrToBool(AttributeNodes['Kompetenz'].Text);
end;

procedure TXMLFachType.Set_Kompetenz(const Value: Boolean);
begin
  SetAttribute('Kompetenz', Value);
end;

function TXMLFachType.Get_Aktiv: Boolean;
begin
  Result := XmlStrToBool(AttributeNodes['Aktiv'].Text);
end;

procedure TXMLFachType.Set_Aktiv(const Value: Boolean);
begin
  SetAttribute('Aktiv', Value);
end;

function TXMLFachType.Get_TextFach: IXMLTextFachType;
begin
  Result := ChildNodes['TextFach'] as IXMLTextFachType;
end;

function TXMLFachType.Get_Bemerkung: IXMLBemerkungType;
begin
  Result := ChildNodes['Bemerkung'] as IXMLBemerkungType;
end;

function TXMLFachType.Get_Punkt: IXMLPunktTypeList;
begin
  Result := FPunkt;
end;

function TXMLFachType.Get_FachZusatz: IXMLFachZusatzType;
begin
  Result := ChildNodes['FachZusatz'] as IXMLFachZusatzType;
end;

{ TXMLTextFachType }

procedure TXMLTextFachType.AfterConstruction;
begin
  RegisterChildNode('RTFText', TXMLRTFTextType);
  RegisterChildNode('PLATZHALTER', TXMLPLATZHALTERType);
  inherited;
end;

function TXMLTextFachType.Get_RTFText: IXMLRTFTextType;
begin
  Result := ChildNodes['RTFText'] as IXMLRTFTextType;
end;

function TXMLTextFachType.Get_PLATZHALTER: IXMLPLATZHALTERType;
begin
  Result := ChildNodes['PLATZHALTER'] as IXMLPLATZHALTERType;
end;

{ TXMLRTFTextType }

function TXMLRTFTextType.Get_Schriftgrad: Integer;
begin
  Result := XmlStrToInt(AttributeNodes['Schriftgrad'].Text);
end;

procedure TXMLRTFTextType.Set_Schriftgrad(const Value: Integer);
begin
  SetAttribute('Schriftgrad', Value);
end;

{ TXMLPLATZHALTERType }

procedure TXMLPLATZHALTERType.AfterConstruction;
begin
  RegisterChildNode('NUMMER', TXMLNUMMERType);
  ItemTag := 'NUMMER';
  ItemInterface := IXMLNUMMERType;
  inherited;
end;

function TXMLPLATZHALTERType.Get_NUMMER(const Index: Integer): IXMLNUMMERType;
begin
  Result := List[Index] as IXMLNUMMERType;
end;

function TXMLPLATZHALTERType.Add: IXMLNUMMERType;
begin
  Result := AddItem(-1) as IXMLNUMMERType;
end;

function TXMLPLATZHALTERType.Insert(const Index: Integer): IXMLNUMMERType;
begin
  Result := AddItem(Index) as IXMLNUMMERType;
end;

{ TXMLNUMMERType }

function TXMLNUMMERType.Get_NAME: UnicodeString;
begin
  Result := AttributeNodes['NAME'].Text;
end;

procedure TXMLNUMMERType.Set_NAME(const Value: UnicodeString);
begin
  SetAttribute('NAME', Value);
end;

function TXMLNUMMERType.Get_VALUE01: Integer;
begin
  Result := XmlStrToInt(ChildNodes['VALUE01'].Text);
end;

procedure TXMLNUMMERType.Set_VALUE01(const Value: Integer);
begin
  ChildNodes['VALUE01'].NodeValue := Value;
end;

function TXMLNUMMERType.Get_VALUE02: Integer;
begin
  Result := XmlStrToInt(ChildNodes['VALUE02'].Text);
end;

procedure TXMLNUMMERType.Set_VALUE02(const Value: Integer);
begin
  ChildNodes['VALUE02'].NodeValue := Value;
end;

function TXMLNUMMERType.Get_VALUE03: Integer;
begin
  Result := XmlStrToInt(ChildNodes['VALUE03'].Text);
end;

procedure TXMLNUMMERType.Set_VALUE03(const Value: Integer);
begin
  ChildNodes['VALUE03'].NodeValue := Value;
end;

function TXMLNUMMERType.Get_VALUE04: Integer;
begin
  Result := XmlStrToInt(ChildNodes['VALUE04'].Text);
end;

procedure TXMLNUMMERType.Set_VALUE04(const Value: Integer);
begin
  ChildNodes['VALUE04'].NodeValue := Value;
end;

function TXMLNUMMERType.Get_VALUE05: Integer;
begin
  Result := XmlStrToInt(ChildNodes['VALUE05'].Text);
end;

procedure TXMLNUMMERType.Set_VALUE05(const Value: Integer);
begin
  ChildNodes['VALUE05'].NodeValue := Value;
end;

function TXMLNUMMERType.Get_VALUE06: Integer;
begin
  Result := XmlStrToInt(ChildNodes['VALUE06'].Text);
end;

procedure TXMLNUMMERType.Set_VALUE06(const Value: Integer);
begin
  ChildNodes['VALUE06'].NodeValue := Value;
end;

{ TXMLBemerkungType }

function TXMLBemerkungType.Get_SortNr: Integer;
begin
  Result := XmlStrToInt(ChildNodes['SortNr'].Text);
end;

procedure TXMLBemerkungType.Set_SortNr(const Value: Integer);
begin
  ChildNodes['SortNr'].NodeValue := Value;
end;

function TXMLBemerkungType.Get_Text: UnicodeString;
begin
  Result := ChildNodes['Text'].Text;
end;

procedure TXMLBemerkungType.Set_Text(const Value: UnicodeString);
begin
  ChildNodes['Text'].NodeValue := Value;
end;

function TXMLBemerkungType.Get_Schriftgrad: Integer;
begin
  Result := XmlStrToInt(ChildNodes['Schriftgrad'].Text);
end;

procedure TXMLBemerkungType.Set_Schriftgrad(const Value: Integer);
begin
  ChildNodes['Schriftgrad'].NodeValue := Value;
end;

{ TXMLPunktType }

procedure TXMLPunktType.AfterConstruction;
begin
  RegisterChildNode('Font', TXMLFontType);
  inherited;
end;

function TXMLPunktType.Get_SortNr: Integer;
begin
  Result := XmlStrToInt(ChildNodes['SortNr'].Text);
end;

procedure TXMLPunktType.Set_SortNr(const Value: Integer);
begin
  ChildNodes['SortNr'].NodeValue := Value;
end;

function TXMLPunktType.Get_Text: UnicodeString;
begin
  Result := ChildNodes['Text'].Text;
end;

procedure TXMLPunktType.Set_Text(const Value: UnicodeString);
begin
  ChildNodes['Text'].NodeValue := Value;
end;

function TXMLPunktType.Get_Farbe: UnicodeString;
begin
  Result := ChildNodes['Farbe'].Text;
end;

procedure TXMLPunktType.Set_Farbe(const Value: UnicodeString);
begin
  ChildNodes['Farbe'].NodeValue := Value;
end;

function TXMLPunktType.Get_Font: IXMLFontType;
begin
  Result := ChildNodes['Font'] as IXMLFontType;
end;

function TXMLPunktType.Get_Wert: Integer;
begin
  Result := XmlStrToInt(ChildNodes['Wert'].Text);
end;

procedure TXMLPunktType.Set_Wert(const Value: Integer);
begin
  ChildNodes['Wert'].NodeValue := Value;
end;

{ TXMLPunktTypeList }

function TXMLPunktTypeList.Add: IXMLPunktType;
begin
  Result := AddItem(-1) as IXMLPunktType;
end;

function TXMLPunktTypeList.Insert(const Index: Integer): IXMLPunktType;
begin
  Result := AddItem(Index) as IXMLPunktType;
end;

function TXMLPunktTypeList.Get_Item(const Index: Integer): IXMLPunktType;
begin
  Result := List[Index] as IXMLPunktType;
end;

{ TXMLFontType }

function TXMLFontType.Get_FontStyle: UnicodeString;
begin
  Result := AttributeNodes['FontStyle'].Text;
end;

procedure TXMLFontType.Set_FontStyle(const Value: UnicodeString);
begin
  SetAttribute('FontStyle', Value);
end;

{ TXMLFachZusatzType }

function TXMLFachZusatzType.Get_LabelText1: UnicodeString;
begin
  Result := ChildNodes['LabelText1'].Text;
end;

procedure TXMLFachZusatzType.Set_LabelText1(const Value: UnicodeString);
begin
  ChildNodes['LabelText1'].NodeValue := Value;
end;

function TXMLFachZusatzType.Get_Text: UnicodeString;
begin
  Result := ChildNodes['Text'].Text;
end;

procedure TXMLFachZusatzType.Set_Text(const Value: UnicodeString);
begin
  ChildNodes['Text'].NodeValue := Value;
end;

function TXMLFachZusatzType.Get_LabelText2: UnicodeString;
begin
  Result := ChildNodes['LabelText2'].Text;
end;

procedure TXMLFachZusatzType.Set_LabelText2(const Value: UnicodeString);
begin
  ChildNodes['LabelText2'].NodeValue := Value;
end;

{ TXMLPLATZHALTERType2 }

end.