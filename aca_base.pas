unit aca_base;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Variants,Graphics,Math, XMLRead, XMLWrite, Dom,aca_types;
type

 { TColorEngine }

 TColorEngine = class(TProfiles)
  public
    procedure LoadFromFile(aFileName: string);
    procedure SaveToFile(aFileName: string);
    //procedure GenerateScript(var st: TStringList;FunctionType,AreaType,CTSType: integer;Checker: TCheckType);
  end;
implementation
 uses aca_utils;
{ TColorEngine }

procedure TColorEngine.LoadFromFile(aFileName: string);
   procedure DoLoadColors(aParentNode: TDOMNode; CurrProfile: TColorProfile);
   var
     I: Integer;
     oColor: TColorItem;
     oNode,oNode1: TDOMNode;
   begin
     for I := 0 to aParentNode.ChildNodes.Count - 1 do
     begin
       oColor:=CurrProfile.ColorList.AddItem;

       oNode:=aParentNode.ChildNodes[i];

       oColor.aColor:=ColourRec(StrToInt(VarToStr(oNode.Attributes.GetNamedItem('color').NodeValue)));
     end;
   end;
   procedure DoLoadProfiles(aParentNode: TDOMNode);
   var
     I: Integer;
     oNode: TDOMNode;
     Profile: TColorProfile;
   begin
     for I := 0 to aParentNode.ChildNodes.Count - 1 do
     begin
       Profile:=AddItem;
       oNode:=aParentNode.ChildNodes[i];
       Profile.Name:= oNode.Attributes.GetNamedItem('name').NodeValue;
       Profile.CTS:= StrToInt(oNode.Attributes.GetNamedItem('cts').NodeValue);
       DoLoadColors(oNode, Profile);
     end;
   end;

 var
   oXmlDocument: TXmlDocument;
 begin
   ReadXMLFile(oXmlDocument,aFileName);

   DoLoadProfiles (oXmlDocument.DocumentElement);

   FreeAndNil(oXmlDocument);
 end;

procedure TColorEngine.SaveToFile(aFileName: string);
var
  oXmlDocument: TXmlDocument;
  vRoot,ProfileNode,ColorListNode: TDOMNode;
  i,d: integer;
  oColor: TColorItem;
begin
  oXmlDocument:=TXmlDocument.Create;
  oXmlDocument.Encoding:='UTF-8';
  vRoot:=oXmlDocument.CreateElement('acaprofile');
  oXmlDocument.AppendChild(vroot);
  vRoot:=oXMLDocument.DocumentElement;
  for i:=0 to count - 1 do
     begin
       ProfileNode:=oXmlDocument.CreateElement('profile');
       TDOMElement(ProfileNode).SetAttribute('name',Items[i].Name);
       TDOMElement(ProfileNode).SetAttribute('cts',IntToStr(Items[i].CTS));
         for d:=0 to Items[i].ColorList.Count - 1 do
            begin
              oColor:=Items[i].ColorList.Items[d];
              ColorListNode:=oXMLDocument.CreateElement('colordata');
              TDOMElement(colorListNode).SetAttribute('color',IntToStr(oColor.aColor.Colour));
              ProfileNode.AppendChild(ColorListNode);
            end;
       vRoot.AppendChild(ProfileNode);
     end;
  WriteXMLFile (oXmlDocument,aFileName);
  FreeAndNil(oXmlDocument);
end;

end.

