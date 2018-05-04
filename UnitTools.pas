unit UnitTools;

interface
uses
    Classes, Windows, ShellApi, Controls, Graphics, Forms, ComCtrls, ExtCtrls,
    jpeg, Contnrs, TlHelp32;

type
    TStringArray= array of string;
    TCharSet= Set of Char;
    TStringProc= procedure(aStr: string);
    TStringProcConst= procedure(const aStr: string);
    TStringFunc= function(aStr: string): string;
    TStringFuncConst= function(const aStr: string): string;
    TObjectProc= procedure(aObj: TObject);
    TObjectFunc= function(aObj: TObject): string;
    TObjectFuncBoolean= function(aObj: TObject): Boolean;
    TStringMethod=  procedure(const aStr: string) of object;
    TObjectMethod=  procedure(aObj: TObject) of object;
    TStringCheck= function(aStr: string): Boolean of object;
    TStringCheckFunc= function(aStr: string): Boolean;
    TStringCheckFuncConst= function(const aStr: string): Boolean;


//----------------------------------------------------
// ������
//----------------------------------------------------
function MemPosEx(aSubStr: string; aMem: Pointer; aFrom, aTo: integer): Integer;
procedure SaveBufferToFile(aBuffer: Pointer; aLen: integer; aFileName: string);
procedure SaveBufferToFileNew(aBuffer: Pointer; aFrom, aLen: integer; aFileName: string);
//----------------------------------------------------
// �ַ�����
//----------------------------------------------------
// �ַ�תСд�ĺ���
function LowerChar(aChar: Char): Char;
function UpperChar(aChar: Char): Char;
// ��Сд�����е�pos����
function ciPos(aSubStr, aText: string): integer;
function ciPosEx(aSubStr, aText: string; var aPos: integer): integer;
//
function PartSame(aStr1, aStr2: string; aLen: integer): Boolean;
function trimLastComma(aText: string): string;
function trimLastAny(aText: string; aChar: Char): string;
function getNameOfString(aStr: string): string;
function ManyChar(aChar: Char; aNum: integer): string;
function getLine(aStr: string): string;
function RemoveLast(aStr: string): string;
function TrimAny(aChar: Char; aText: string): string;
function ReplaceAny(aChar1, aChar2: Char; aText: string): string;
function InnerTrim(aText: string): string;
// ����C���ԵĶ�\n��֧��
function CStyleText(aText: string): string;
function CStyleMake(aText: string): string;
// ���ȫ�ǵĴ�ԲȦ������
function GetCircleNumber(aId: integer): string;
// ���õ�ȫ�ǰ��ת��
function full2half(aTag, aText: string): string;
function half2full(aTag, aText: string): string;
function SpaceList2Comma(aText: string): string;
function IsNumber(aStr: string): Boolean;
Function DecodeIp(aIp: string; var a1, a2, a3, a4: integer): boolean;
function GetRandomNo(aLen: integer): string;
function WordWrap(aText: string; aWrapLength: integer): string;
function PosFromSide(aSubStr, aText: string; aSide, aNum: integer): integer;   // ��ǰ���Ѱ�ҵ�aNum���Ӵ�
// �жϳ����ַ�������ʡ�Ժű�ʾ
Function CutStr(aStr: string; aLength: integer): string;
// ��λ����
function MakeLenthNum(aNum, aLen: integer): string;
function LengthStr(aStr: string; aLength: integer; aFront: Boolean): string;
function Space(aLength: integer): string;
// �滻
function ReplaceStr(aText, aFrom, aTo: string): string;
// ���ַ����������ȡ
function GetItemFromList(aStrList: string; aId: integer): string;
function GetItemFromListDelima(aStrList: string; aId: integer; aDelima: Char): string;
function GetDelimaTextCount(aText: string; aDelima: Char): integer;
// �����๤��
function ChineseDateTime(aDate: TDateTime): string;
function ChineseDayOfWeek(aDate: TDateTime): string;
function ChineseDate(aDate: TDateTime): string;
function ChineseDateSimple(aDate: TDateTime): string;
function ChineseDateSimplest(aDate: TDateTime): string;
function ChineseTime(aDate: TDateTime): string;
function ChineseTimeSimple(aDate: TDateTime): string;
function IncludeHz(aStr: string): Boolean;
// ���ֱȽ�
function FindPartial(aList: TStringList; aKey: string): integer;
// Tag������
function FindTag(aTag, aText: string): boolean;
function GetSubStrFrom(aText, aTag1, aTag2: string): string;
function GetTagged(aTag, aValue: string): string;
function GetTagValue(aTag, aText: string): string;
function SetTagValue(aTag, aValue, aText: string): string;
function RemoveTagged(aTag, aText: string): string;
// ���ַ���ת��Ϊ16���Ʊ�ʾ
function StrToHex(aStr: string; aIn: string): string;
// ��16���Ʊ�ʾת��Ϊ�ַ���
function HexToStr(aStr: string; aIn: string): string;
// ������ת��������2λС��
function FloatToStrEx(aNum: double; aDig: integer=2): string;
// ���ʶ�ȡ
function ReadWord(aText: string; aSpace: TCharSet; var aPos: integer): string;
// ���ӣ������ŵ�֧�֣��Կղ�����֧��
function ReadCodeWord(aText: string; aSpace: TCharSet; var aPos: integer): string;
// ��ȡ�����ŵ���ס�Ĵ�
function ReadBetween(aText: string; aFc, aTc: Char; var aPos: integer): string;
function ReadBetweenTag(aText: string; aFromTag, aToTag: string; var aPos: integer): string;
// �޳������е�����
function filterBranck(aStr: string): string;
// ����������ʽ�Ĺ��ˣ���aFc��aTc������ͬ���������
function filterAny(aStr: string; aFc, aTc: Char): string;
//----------------------------------------------------
// �б����������ͷ���β
function getFirst(aList: string): string;
function getTail(aList: string): string;
function CutLast(aList: TStringArray): TStringArray;
// ����������aLink����������������","������ʡ�ԣ�������"and"
function LinkTable(aList, aLink: string): string; overload;
function LinkTable(aList: TStringArray; aLink: string): string; overload;
// �Ѷ��Ŵ�ת��Ϊ�����б�
function MakeList(aList: string): TStringArray; overload;
function MakeList(aList: array of string): TStringArray; overload;
function ToList(aItem: string): TStringArray; overload;
// ����ÿ�����ݣ���aModel����Ľṹ���д�����@����ԭ��������
function ChangeTable(aList, aModel: string): string; overload;
function ChangeTable(aList: TStringArray; aModel: string): TStringArray; overload;
//
function ConcatTable(aList1, aList2: TStringArray): TStringArray; overload;
function ConcatTable(aList1, aList2: string): string; overload;
// ���ϵļ���
function SubTable(aList1, aList2: TStringArray): TStringArray;
// �Ƿ����ڼ���
function InTable(aItem: string; aList: TStringArray): boolean;
//
function AddToTable(aList1: TStringArray; aItem: string): TStringArray; overload;
// ͨ���ַ��������ߣ����ַ����е�һ���Ӵ��滻Ϊָ���Ӵ�
function replaceAll(aText, aSub, aDst: string): string;
//----------------------------------------------------
// ��չ�������� key1,key2,key3=value
function checkKey(aText, aKey: string): boolean;
function GetKeyValue(aText, aKey: string): string;
function setKeyValue(aText, aKey, aValue: string): string;
function getKeyFileList(aText: string): string;  // ���ŷֿ����ļ����б�
//----------------------------------------------------
// ����ʽ��̣��������
//----------------------------------------------------
procedure manObject(aObject: TObject);
procedure ClearObject;
//----------------------------------------------------------------
// forEach��
//----------------------------------------------------------------
function getCommaList(aStrList: TStringList; aTrans: TStringFunc): string;
procedure ForEach(aList: TStrings; aProc: TStringProc); overload;
procedure ForEach(aListStr: string; aProc: TStringProc); overload;
procedure ForEach(aList: TStrings; aProc: TStringProcConst); overload;
procedure ForEach(aList: TObjectList; aProc: TObjectProc); overload;
procedure ForEach(aList: TObjectList; aProc: TObjectMethod); overload;
function ForEachLink(aList: TObjectList; aFunc: TObjectFunc): string;
function Filter(aList: TObjectList; aProc: TObjectFuncBoolean): TObjectList; overload;
function Filter(aList: TStrings; aProc: TStringCheckFunc): TStrings; overload;
function Filter(aList: TStrings; aProc: TStringCheckFuncConst): TStrings; overload;
function CrForEachChange(aList: TStrings; aProc: TStringFunc): TStringList;
//----------------------------------------------------------------
// ifTest��
//----------------------------------------------------
function ifTest(aTest: Boolean; aTrueValue, aFalseValue: string): string;
//----------------------------------------------------
// �ļ���
//----------------------------------------------------
procedure SaveTextToFile(aText: string; aFileName: string);
function GetTextFromFile(aFileName: string): string;
procedure SaveTextToUTF8File(AContent:string;AFileName: string);
function GetTextUTF8File(AFileName: string): string;
// ȡ��װ·��������
function GetInstallPath: string;
function GetFullExeName: string;
// ��ȡ�ļ�ʱ�� 0:����ʱ�䣬1���ϴ��޸�ʱ�䣻2���ϴη���ʱ��
function FGetFileTime(sFileName:string; TimeType:Integer): TDateTime;
function GetFileDate(aFileName: string): TDateTime;
//��ȡ�汾��
function GetBuildInfo: string;
function GetExeVersion(aFileName: string): string;
// ��������
procedure UpdateSelfAndStartAgain(aFileName: string);
// �ļ���Ŀ¼���������
function CopyDir(sDirName:String; sToDirName:String):Boolean;
// ��δʵ��
//function UpdateDir(sDirName:String; sToDirName:String):Boolean;
//���ļ�����
procedure CopyFiles(aFileNames, aDestNames: TStrings; aDir: string); overload;
procedure CopyFiles(aFileNames: TStrings; aDir: string); overload;
procedure CopyFiles(aFrom, aDir: string); overload;
procedure UpdateFiles(aFileNames: TStrings; aDir: string);
// ���ļ�����
procedure copyfile(sourcefilename, targetfilename: string);
// ����ļ��������������ϱ�֤���ظ�
function GetRandomName: string;
// �ļ����Զ�+1���Ա����ظ�
procedure FileNamePlus1(aFromName: string);
function NewFileNameFrom(aFromName: string): string;
function GetBackUpFileName(aFromName: string): string;
// �ļ��б�
function CrGetFileList(aDesc: string): TStringList;
procedure GetFileList(aDesc: string; asl: TStrings);
procedure GetFileListNoSub(aDesc: string; asl: TStrings);
procedure GetFileListNoSub2(aDesc: string; asl: TStrings);
procedure GetDirListNoSub(aDesc: string; asl: TStrings);
//ȡ����ʱ·��
function PathGetTempPath: string;
//·�������'/'��ȥ'/'
function PathWithoutSlash(const Path: string): string;
//·�����û��'/'���'/'
function PathWithSlash(const Path: string): string;
// sTmpName��ԭ�ļ�·�������֣�sPath�ǲο�·��
function GetFullFileName(sPath, sTmpName: string): string;
function GetRelaFileName(sPath, sTmpName: string): string;
// ��õ�һ������
function ExePath: string;
// �������Ŀ¼
function EmptyDirectory(TheDirectory: String; Recursive: Boolean): Boolean;
// ͨ����ļ�ɾ��
procedure DeleteFileEx(aFileName: string);
// �ļ�������
procedure FindSameFile(aList1, aRetList: TStrings; aFileFunc: TStringFunc);
//----------------------------------------------------
// �����࣬������׼�ύ����
//----------------------------------------------------
function NetPostData(aURL: string; aParm: TStrings): string;
function NetGetData(aURL: string; aParm: TStrings): string;
function NetPostFile(aURL: string; afilename: TStringList; aParm: TStrings): string;

//----------------------------------------------------
// ͼ��ͼ��
//----------------------------------------------------
procedure MakeTextPic(aPic: TJpegImage; aText: TStrings; aW, aH, aFontSize: integer);
function RotateBMP90(aBmp: TBitmap): TBitmap;
function JPG2BMP(ajpg: TJpegImage): TBitmap;
procedure CalcMaxRectWithIn(aRect: TRect; aW, aH: integer; var DestRect: TRect);
//   ��ɫ
function GetBeautifulColor(aId: integer): TColor;
procedure LoadJpgToImage(aImage: TImage; aJpgFile: string);
procedure DrawStrCenter(aCanvas: TCanvas; ax, ay, aw, ah: integer; aStr: string);
//----------------------------------------------------
// �ؼ���
//----------------------------------------------------
procedure RemoveAllComponents(aComp: TComponent);
procedure SetFormMonitor(Form:TCustomForm; MonitorIndex:integer);
function GetDPI(var ax, ay: integer): integer;
procedure ShineForm(aForm: TForm);
// ��׼ȷ�Ĵ��ڴ�С
function ScreenSize(var x, y: integer): boolean;
//��ȡͼ����
function GetFileIconIndex(FileName:string):integer;
//��ȡͼ��ImageList
function GetIconImageList: TImageList;
function GetIconImageListSmall: TImageList;
// ���οؼ���
procedure DrawAnyShapeControl(ControlHandle:THandle;Canvas:TCanvas;MaskColor:TColor; aw: integer= 0; ah: integer= 0);
procedure SaveRgn(aRgn: hrgn);
procedure LoadRgn(ControlHandle:THandle; aFileName: string);
// �ؼ����л�
function ComponentToString(Component: TComponent): string;
// ���ݵ���
procedure ListToCSV(alv: TListView; aFileName: string);
//----------------------------------------------------
// ϵͳ��
//----------------------------------------------------
function RunAndWait(FileName: string; Visibility: Integer): THandle;
function WinExecAndWait32(FileName: string; Visibility: integer): Dword;
Function WinExecExW(CMD:Pchar; Visiable:integer):DWORD;
// notepad��
procedure OpenFileEdit(aFileName: string);
// ��ȡUSB����
procedure GetUSBCOMNames(var AResult: TStringList);
procedure GetComList(slPort: TStrings);
function GetComPortList: TStrings;
// �����ļ��Ĵ�
function HtmlHelpA(hwndcaller:Longint; lpHelpFile:string; wCommand:Longint;dwData:string): HWND;stdcall; external 'hhctrl.ocx';
// �������Ƿ����
function CheckProcessExist(const aPureFileName: string): Boolean;
// ��������
function EndProcess(aPureFileName: string): integer;
//----------------------------------------------------
// λ����������Nλ�����
//----------------------------------------------------
function CheckBit(aNum, aBit: integer): integer;
//----------------------------------------------------
// �����룬��ǿ��
// �÷�
//     if Lock(1) then begin
//        exit;
//     end;
//----------------------------------------------------
function Lock(aId: integer): Boolean;
function CheckLock(aId: integer): Boolean;
procedure UnLock(aId: integer);

//----------------------------------------------------
// ###################################################
//----------------------------------------------------
implementation
uses
    SysUtils, StrUtils, Registry, idhttp, IdMultipartFormData;

var
    ShFileInfo: TSHFILEINFO;
    InnerObjList: TObjectList;


//----------------------------------------------------
function MemPosEx(aSubStr: string; aMem: Pointer; aFrom, aTo: integer): Integer;
var
   iPos: Integer;
   TmpStr:string;
   i,j,len: Integer;
   PCharS,PCharSub:PChar;
begin
     PCharS:=PChar(aMem); //���ַ���ת��ΪPChar��ʽ
     PCharSub:=PChar(aSubStr);
     Result:=0;
     len:=length(aSubStr);
     for i:=aFrom to aTo-1 do begin
         for j:=0 to len-1 do begin
             if PCharS[i+j]<>PCharSub[j] then break;
         end;
         if j=len then begin
            result:= i;
            break;
            //Result:=i+1;
         end;
     end;
end;
//----------------------------------------------------
procedure FindSameFile(aList1, aRetList: TStrings; aFileFunc: TStringFunc);
var
   sl: TStringList;
   i, a: integer;
   str1: string;
begin
     sl:= TStringList.Create;
     for i:= 0 to aList1.Count- 1 do begin
         str1:= trim(aList1[i]);
         if str1= '' then begin
            continue;
         end;
         str1:= aFileFunc(str1);
         a:= sl.IndexOf(str1);
         if a< 0 then begin
            sl.Add(str1);
         end else begin
             sl.Add('###');
             aRetList.Add(aList1[a]);
             aRetList.Add(aList1[i]);
         end;
     end;
     sl.Free;
end;

//----------------------------------------------------
function IncludeHz(aStr: string): Boolean;
var
   i: integer;
begin
     //���ж�Ҫ��ȡ���ַ������һ���ֽڵ�����
     //���Ϊ���ֵĵ�һ���ֽ����(��)һλ
     result:= false;
     for i:=0 to length(aStr) do begin
         if ByteType(aStr,i) = mbLeadByte then begin
            result:=true;
            break;
         end;
     end;
end;

//----------------------------------------------------
function checkKey(aText, aKey: string): boolean;
var
   sl: TStringList;
begin
     aText:= UpperCase(aText);
     aKey:= UpperCase(aKey);
     sl:= TStringList.Create;
     sl.CommaText:= aText;
     result:= (sl.IndexOf(aKey)>= 0) or (sl.IndexOfName(aKey)>= 0);
     sl.Free;
end;

function GetKeyValue(aText, aKey: string): string;
var
   sl: TStringList;
begin
     sl:= TStringList.Create;
     sl.CommaText:= aText;
     result:= sl.Values[aKey];
     sl.Free;
end;

function getKeyFileList(aText: string): string;
var
   sl: TStringList;
   i: integer;
   str1: string;
begin
     sl:= TStringList.Create;
     sl.CommaText:= aText;
     for i:= 0 to sl.Count- 1 do begin
         str1:= trim(sl[i]);
         if str1= '' then begin
            continue;
         end;
         if str1[1]= '#' then begin
            if result<> '' then begin
               result:= result+ ',';
            end;
            result:= result+ copy(str1, 2, length(str1));
         end;
     end;
     sl.Free;
end;

//----------------------------------------------------
function setKeyValue(aText, aKey, aValue: string): string;  // ���ŷֿ����ļ����б�
var
   sl: TStringList;
begin
     sl:= TStringList.Create;
     sl.CommaText:= aText;
     sl.Values[aKey]:= aValue;
     result:= sl.CommaText;
     sl.Free;
end;

//----------------------------------------------------
function ToList(aItem: string): TStringArray; overload;
var
   sl: TStringList;
   i, a: integer;
   str1: string;
begin
     setLength(result, 1);
     result[0]:= aItem;
end;

//----------------------------------------------------
// �Ѷ��Ŵ�ת��Ϊ�����б�
function MakeList(aList: string): TStringArray;
var
   sl: TStringList;
   i, a: integer;
   str1: string;
begin
     sl:= TStringList.Create;
     sl.CommaText:= aList;

     a:= sl.Count;
     setLength(result, a);
     for i:= 0 to sl.Count- 1 do begin
         str1:= trim(sl[i]);
         if str1= '' then begin
            continue;
         end;
         result[i]:= str1;
     end;
     sl.Free;
end;

function MakeList(aList: array of string): TStringArray; overload;
var
   i, a: integer;
   str1: string;
begin
     a:= Length(aList);
     setLength(result, a);
     for i:= low(aList) to high(aList) do begin
         str1:= trim(aList[i]);
         if str1= '' then begin
            continue;
         end;
         result[i]:= str1;
     end;
end;
//----------------------------------------------------
function CutLast(aList: TStringArray): TStringArray;
var
   i, a: integer;
   str1: string;
begin
     a:= Length(aList)- 1;
     if a< 0 then begin
        a:= 0;
     end;
     setLength(result, a);
     for i:= low(aList) to a- 1 do begin
         str1:= trim(aList[i]);
         if str1= '' then begin
            continue;
         end;
         result[i]:= str1;
     end;
end;

//----------------------------------------------------
// ����������aLink����������������","������"and"
function LinkTable(aList, aLink: string): string;
var
   sl: TStringList;
   i: integer;
   str1: string;
begin
     sl:= TStringList.Create;
     sl.CommaText:= aList;
     result:= '';
     for i:= 0 to sl.Count- 1 do begin
         str1:= trim(sl[i]);
         if str1= '' then begin
            continue;
         end;
         if result<> '' then begin
            result:= result+ aLink+ str1;
         end else begin
             result:= str1;
         end;
     end;
     sl.Free;
end;

function LinkTable(aList: TStringArray; aLink: string): string; overload;
var
   i: integer;
   str1: string;
begin
     result:= '';
     for i:= low(aList) to high(aList) do begin
         str1:= aList[i];
         if str1= '' then begin
            continue;
         end;
         if result<> '' then begin
            result:= result+ aLink+ str1;
         end else begin
             result:= str1;
         end;
     end;
end;

//----------------------------------------------------
// ͨ���ַ��������ߣ����ַ����е�һ���Ӵ��滻Ϊָ���Ӵ�
function replaceAll(aText, aSub, aDst: string): string;
var
   a, b: integer;
begin
     b:= Length(aSub);
     repeat
         a:= pos(UpperCase(aSub), UpperCase(aText));
         if a> 0 then begin
            Delete(aText, a, b);
            insert(aDst, aText, a);
         end;
     until a<= 0;
     result:= aText;
end;

//----------------------------------------------------
function AddToTable(aList1: TStringArray; aItem: string): TStringArray; overload;
var
   a, b, i, n: integer;
   str1: string;
begin
     a:= Length(aList1);
     setLength(result, a+ 1);
     for i:= low(aList1) to high(aList1) do begin
         str1:= trim(aList1[i]);
         if str1= '' then begin
            continue;
         end;
         result[i]:= str1;
     end;
     result[a]:= aItem;
end;

//----------------------------------------------------
function InTable(aItem: string; aList: TStringArray): boolean;
var
   i: integer;
   str1: string;
begin
     result:= false;
     for i:= low(aList) to high(aList) do begin
         str1:= trim(aList[i]);
         if sameText(aItem, str1) then begin
            result:=true;
            break;
         end;
     end;
end;

//----------------------------------------------------
function SubTable(aList1, aList2: TStringArray): TStringArray;
var
   i, cc: integer;
   str1: string;
begin
     cc:= 0;
     for i:= low(aList1) to high(aList1) do begin
         str1:= trim(aList1[i]);
         if str1= '' then begin
            continue;
         end;
         if not InTable(str1, aList2) then begin
            setLength(result, cc);
            result[cc- 1]:= str1;
         end;
     end;
end;

//----------------------------------------------------
function ConcatTable(aList1, aList2: TStringArray): TStringArray; overload;
var
   i, a, b: integer;
   str1: string;
begin
     a:= Length(aList1);
     b:= Length(aList2);
     setLength(result, a+ b);
     for i:= low(aList1) to high(aList1) do begin
         str1:= trim(aList1[i]);
         if str1= '' then begin
            continue;
         end;
         result[i]:= str1;
     end;
     for i:= low(aList2) to high(aList2) do begin
         str1:= trim(aList2[i]);
         if str1= '' then begin
            continue;
         end;
         result[i+ a]:= str1;
     end;
end;

//----------------------------------------------------
function ConcatTable(aList1, aList2: string): string; overload;
begin
     if trim(aList1)= '' then begin
        result:= aList2;
     end else if trim(aList2)= '' then begin
         result:= aList1;
     end else begin
         result:= aList1+ ','+ aList2;
     end;
end;

//----------------------------------------------------
// ����ÿ�����ݣ���aModel����Ľṹ���д�����@����ԭ��������
function ChangeTable(aList, aModel: string): string;
var
   sl: TStringList;
   i, a: integer;
   str1, str2: string;
begin
     sl:= TStringList.Create;
     sl.CommaText:= aList;
     result:= '';
     for i:= 0 to sl.Count- 1 do begin
         str1:= trim(sl[i]);
         if str1= '' then begin
            continue;
         end;
         str2:= aModel;
         str2:= replaceAll(str2, '@', str1);
         if result<> '' then begin
            result:= result+ ','+ str2;
         end else begin
             result:= str2;
         end;
     end;
     sl.Free;
end;

function ChangeTable(aList: TStringArray; aModel: string): TStringArray; overload;
var
   i, a: integer;
   str1, str2: string;
begin
     a:= Length(aList);
     setLength(result, a);
     for i:= low(aList) to high(aList) do begin
         str1:= aList[i];
         if str1= '' then begin
            continue;
         end;
         str2:= aModel;
         str2:= replaceAll(str2, '@', str1);
         result[i]:= str2;
     end;
end;

//----------------------------------------------------
procedure OpenFileEdit(aFileName: string);
begin
     WinExec(PAnsiChar('Notepad.exe '+ aFileName), SW_SHOW);
end;

//----------------------------------------------------
function getFirst(aList: string): string;
begin
     result:= getitemfromlist(aList, 0);
end;
//----------------------------------------------------
function getTail(aList: string): string;
var
   str1: string;
begin
     str1:= getFirst(aList);
     result:= Copy(aList, Length(str1)+ 2, Length(aList));
end;
//----------------------------------------------------
function ciPosEx(aSubStr, aText: string; var aPos: integer): integer;
begin
     result:= posEx(UpperCase(aSubStr), UpperCase(aText), aPos);
     aPos:= aPos+ length(aSubStr);
end;

//----------------------------------------------------
function UpperChar(aChar: Char): Char;
begin
     result:= Char(CharUpper(PChar(aChar)));
end;

//----------------------------------------------------
function LowerChar(aChar: Char): Char;
begin
     result:= Char(CharLower(PChar(aChar)));
end;

//----------------------------------------------------
function ciPos(aSubStr, aText: string): integer;
begin
     result:= pos(UpperCase(aSubStr), UpperCase(aText));
end;

//----------------------------------------------------
function NetGetData(aURL: string; aParm: TStrings): string;
var
   h: TIdhttp;
   str1, str2, strURL: string;
   i: integer;
begin
     result:= '';
     try
        h := Tidhttp.Create(nil);
        strURL:= aURL;
        for i:= 0 to aParm.Count- 1 do begin
            str1:= trim(aParm.Names[i]);
            str2:= trim(aParm.ValueFromIndex[i]);
            if str1= '' then begin
               continue;
            end;
            if i= 0 then begin
               strURL:= strURL+ '?'+ str1+ '='+ str2;
            end else begin
                strURL:= strURL+ '&'+ str1+ '='+ str2;
            end;
        end;
        try
          result:= h.Get(strURL);
        except
        end;
     finally
        h.Destroy;
     end;
end;

//----------------------------------------------------
function NetPostData(aURL: string; aParm: TStrings): string;
var
   h: TIdhttp;
begin
     result:= '';
     try
        h := Tidhttp.Create(nil);
        try
          result:= h.Post(aURL, aParm);
        except
        end;
     finally
        h.Destroy;
     end;
end;

//----------------------------------------------------------------
function NetPostFile(aURL: string; afilename: TStringList; aParm: TStrings): string;
var
   h: TIdhttp;
   FS: TIdMultiPartFormDataStream;
   i: integer;
   str1, str2: string;
begin
     h := Tidhttp.Create(nil);
     FS := TIdMultiPartFormDataStream.Create;
     for i:= 0 to afilename.Count- 1 do begin
         str1:= aFileName.Names[i];
         str2:= aFileName.ValueFromIndex[i];
         FS.AddFile(str1, str2, '');
     end;
     for i:= 0 to aParm.Count- 1 do begin
         FS.AddFormField(aParm.Names[i], aParm.ValueFromIndex[i]);
     end;
     try
        try
          result:= h.Post(aURL, FS);
        except
        end;
     finally
        FS.Destroy;
        h.Destroy;
     end;
end;

//----------------------------------------------------
function EndProcess(aPureFileName: string): integer;
const   
  PROCESS_TERMINATE = $0001;  
var   
  ContinueLoop: BOOLean;  
  FSnapshotHandle: THandle;  
  FProcessEntry32:TProcessEntry32;  
begin  
     Result := 0;
     FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
     FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
     ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

     while Integer(ContinueLoop) <> 0 do begin
           if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(aPureFileName)) or
              (UpperCase(FProcessEntry32.szExeFile) = UpperCase(aPureFileName))) then begin
              //
              Result:= Integer(
                     TerminateProcess(OpenProcess(PROCESS_TERMINATE,
                     BOOL(0),FProcessEntry32.th32ProcessID),0)
                     );
           end;
           ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
     end;
     CloseHandle(FSnapshotHandle);
end;

//----------------------------------------------------
function CheckProcessExist(const aPureFileName: string): Boolean;
var
  //���ڻ�ý����б�
  hSnapshot: THandle;
  //���ڲ��ҽ���
  lppe: TProcessEntry32;
  //�����жϽ��̱����Ƿ����
  Found: Boolean;
begin
     Result := False;
     //���ϵͳ�����б�
     hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
     //�ڵ���Process32FirstAPI֮ǰ����Ҫ��ʼ��lppe��¼�Ĵ�С
     lppe.dwSize := SizeOf(TProcessEntry32);
     //�������б�ĵ�һ��������Ϣ����ppe��¼��
     Found := Process32First(hSnapshot, lppe);
     while Found do begin
       if ((UpperCase(ExtractFileName(lppe.szExeFile)) = UpperCase(aPureFileName)) or (UpperCase(lppe.szExeFile) = UpperCase(aPureFileName))) then begin
          Result := True;
       end;
       //�������б����һ��������Ϣ����lppe��¼��
       Found := Process32Next(hSnapshot, lppe);
     end;
end;

//----------------------------------------------------
function PartSame(aStr1, aStr2: string; aLen: integer): Boolean;
begin
     if StrLiComp(PAnsiChar(aStr1), PAnsiChar(aStr2), aLen)= 0 then begin
        result:= true;
     end else begin
         result:= false;
     end;
end;

//----------------------------------------------------
procedure MakeTextPic(aPic: TJpegImage; aText: TStrings; aW, aH, aFontSize: integer);
var
   bmp: tBitmap;
   a, i: integer;
   str1: string;
begin
     bmp:= tBitmap.Create;
     a:= aText.Count;
     for i:= 0 to a- 1 do begin
         str1:= aText[i];
     end;
     aPic.Assign(bmp);
     bmp.Free;
end;

//----------------------------------------------------
function trimLastAny(aText: string; aChar: Char): string;
begin
     if (Length(aText) > 0) and (aText[Length(aText)] = aChar) then Result := Copy(aText, 1, Length(aText) - 1)
     else Result := aText;
end;

//----------------------------------------------------
function trimLastComma(aText: string): string;
begin
     result:= trimLastAny(trim(aText), ',');
end;

//----------------------------------------------------
// ����ʽ��̣��������
//----------------------------------------------------
procedure manObject(aObject: TObject);
begin
     InnerObjList.Add(aObject);
end;

procedure ClearObject;
begin
     InnerObjList.Clear;
end;

//----------------------------------------------------------------
function RotateBMP90(aBmp: TBitmap): TBitmap;
type
    TRGBColor= record
       r, g, b, a: byte;
    end;
var
   RowList: array of PByteArray;
   ColList: array of PByteArray;
   NumByte: integer;

procedure setColor(aBmp: TBitmap; ax, ay: integer; aColor: TRGBColor);
var
   rowIn :  Pointer;
begin
     if ColList[ay]= nil then begin
        ColList[ay]:= aBmp.ScanLine[ay];
     end;
     if NumByte>= 3 then begin
        ColList[ay][ax* NumByte]:= aColor.r;
        ColList[ay][ax* NumByte+ 1]:= aColor.g;
        ColList[ay][ax* NumByte+ 2]:= aColor.b;
     end;
     if NumByte>= 4 then begin
        ColList[ay][ax* NumByte+ 3]:= aColor.a;
     end;
end;

function getColor(aBmp: TBitmap; ax, ay: integer): TRGBColor;
begin
     if RowList[ay]= nil then begin
        RowList[ay]:= aBmp.ScanLine[ay];
     end;
     if NumByte>= 3 then begin
        result.r:= RowList[ay][ax* NumByte];
        result.g:= RowList[ay][ax* NumByte+ 1];
        result.b:= RowList[ay][ax* NumByte+ 2];
     end;
     if NumByte>= 4 then begin
        result.b:= RowList[ay][ax* NumByte+ 3];
     end;
end;

procedure InitColRow(aW, aH: integer);
var
   i: integer;
begin
     setLength(RowList, aH);
     setLength(ColList, aW);
     for i:=0 to aH- 1 do begin
         RowList[i]:= nil;
     end;
     for i:=0 to aW- 1 do begin
         ColList[i]:= nil;
     end;
     if aBmp.PixelFormat= pf24bit then begin
        NumByte:= 3;
     end else if aBmp.PixelFormat= pf24bit then begin
         NumByte:= 4;
     end;
end;

procedure FreeColRow;
begin
     setLength(RowList, 0);
     setLength(ColList, 0);
end;

var
   w, h, i, j, cc: integer;
begin
     if not assigned(aBmp) then begin
        result:= nil;
     end else begin
         aBmp.PixelFormat:= pf24bit;
         result:= TBitmap.Create;
         result.Width:= aBmp.Height;
         result.Height:= aBmp.Width;
         result.PixelFormat:= pf24bit;
         InitColRow(aBmp.Width, aBmp.Height);
         for i:= 0 to result.Width- 1 do begin
             for j:= 0 to result.Height- 1 do begin
                 SetColor(result, i, j, getColor(aBmp, j, result.Width- 1- i));
             end;
         end;
         FreeColRow;
         manObject(result);
     end;
end;

//----------------------------------------------------------------
function JPG2BMP(ajpg: TJpegImage): TBitmap;
begin
     if not assigned(aJpg) then begin
        result:= nil;
     end else begin
         result:= TBitmap.Create;
         result.Width:= ajpg.Width;
         result.Height:= ajpg.Height;
         result.Canvas.Draw(0, 0, ajpg);
         manObject(result);
     end;
end;

//----------------------------------------------------------------
procedure CalcMaxRectWithIn(aRect: TRect; aW, aH: integer; var DestRect: TRect);
var
   f1, f2: double;
   w1, h1, w2, h2: integer;
begin
     h1:= aRect.Bottom- aRect.Top;
     w1:= aRect.Right- aRect.Left;
     f1:= h1/ w1;
     f2:= aH/ aW;
     if f1= f2 then begin
        DestRect:= aRect;
     end else begin
         if f1> f2 then begin
             // ��ʾ��խ
             w2:= w1;
             h2:= round(w2* f2);
             DestRect.Top:= aRect.Top+ (h1- h2) div 2;
             DestRect.Bottom:= DestRect.Top+ h2;
             DestRect.Left:= aRect.Left;
             DestRect.Right:= aRect.Right;
         end else if f1< f2 then begin
             // ��ʾ����
             h2:= h1;
             w2:= round(h2/ f2);
             DestRect.Left:= aRect.Left+ (w1- w2) div 2;
             DestRect.Right:= DestRect.Left+ w2;
             DestRect.Top:= aRect.Top;
             DestRect.Bottom:= aRect.Bottom;
         end;
     end;
end;

//----------------------------------------------------------------
procedure RemoveAllComponents(aComp: TComponent);
var
   i: integer;
begin
     for i:= aComp.ComponentCount- 1 downto 0 do begin
         aComp.RemoveComponent(aComp.Components[i]);
     end;
end;

//----------------------------------------------------------------
// ����Ļ֧��
//----------------------------------------------------------------
procedure SetFormMonitor(Form: TCustomForm; MonitorIndex: integer);
begin
     if (MonitorIndex>-1) and (MonitorIndex<Screen.MonitorCount) then begin
        //�Զ�����
        {
        Form.SetBounds(Screen.Monitors[MonitorIndex].Left + ((Screen.Monitors[MonitorIndex].Width - Form.Width) div 2),
        Screen.Monitors[MonitorIndex].Top + ((Screen.Monitors[MonitorIndex].Height - Form.Height) div 2),
        Form.Width, Form.Height);
        //}
        // �Զ�ȫ��
        if MonitorIndex= 0 then begin
           // ���л�
           Form.SetBounds(Screen.Monitors[0].Left+ Screen.Monitors[0].Width div 2,
           Screen.Monitors[0].Top,
           Screen.Monitors[0].Width div 5* 2, Screen.Monitors[0].Height div 5* 2);
        end else begin
            Form.SetBounds( Screen.Monitors[MonitorIndex].Left,
                            Screen.Monitors[MonitorIndex].Top,
                            Screen.Monitors[MonitorIndex].Width,
                            Screen.Monitors[MonitorIndex].Height);
        end;
     end;
end;

//----------------------------------------------------------------
function GetDPI(var ax, ay: integer): integer;
var
  DC: HDC;
begin
     DC := GetDC(0);
     ax:= GetDeviceCaps(DC, logpixelsx);
     ay:= GetDeviceCaps(DC, logpixelsy);
     ReleaseDC(0, DC);
     result:= ax;
end;

//----------------------------------------------------------------
function CStyleText(aText: string): string;
var
   i, n: integer;
   c: Char;
begin
     n:= length(aText);
     i:= 1;
     result:= '';
     while i<= n do begin
         c:= aText[i];
         if c= '\' then begin
            // ת������
            i:= i+ 1;
            c:= aText[i];
            case c of
                 '\': result:= result+ '\';
                 'n': result:= result+ #$d#$a;
                 't': result:= result+ #9;
                 'p': result:= result+ '''';
                 'q': result:= result+ '"';
                 'c': result:= result+ ',';
                 'd': result:= result+ '.';
                 else result:= result+ c;
            end;
         end else begin
             result:= result+ c;
         end;
         i:= i+ 1;
     end;
end;

//----------------------------------------------------------------
function CStyleMake(aText: string): string;
var
   i, j, a: integer;
   str1, str2: string;
const
     ChangeText: array[1..7, 1..2] of string=(('\', '\\'), (#$d#$a, '\n'), (',', '\c'), (#9, '\t'), ('''', '\p'), ('"', '\q'), ('.', '\d'));
begin
     // �õ��߼��Ǽ��滻
     result:= aText;
     for j:= 1 to 7 do begin
         str1:= ChangeText[j, 1];
         str2:= ChangeText[j, 2];
         a:= 1;
         repeat
             i:= posex(str1, result, a);
             if i> 0 then begin
                delete(result, i, length(str1));
                insert(str2, result, i);
                a:= i+ length(str2);
             end;
         until i<= 0;
     end;
end;

//----------------------------------------------------------------
function GetCircleNumber(aId: integer): string;
const
     circle_number: array[1..9] of string= ('��', '��', '��', '��', '��', '��', '��', '��', '��');
begin
     if (aId>= 1) and (aId<= 9) then begin
        result:= circle_number[aId];
     end else begin
         result:= '';
     end;
end;

//----------------------------------------------------------------
function ChangeIt(aChar: Char): string;
begin
     if aChar= '<' then begin
        result:= '��';
     end else if aChar= '>' then begin
        result:= '��';
     end else if aChar= '=' then begin
        result:= '��';
     end else if aChar= ',' then begin
        result:= '��';
     end;
end;

//----------------------------------------------------------------
function ChangeIt2(aWord: string): Char;
begin
     if aWord= '��' then begin
        result:= ',';
     end;
end;

//----------------------------------------------------------------
function full2half(aTag, aText: string): string;
var
   i, j, a, b, c: integer;
   find: boolean;
   s1, s2: string;
begin
     result:= aText;
     a:= length(aText);
     b:= Length(aTag) div 2;
     i:= 0;
     while i< b do begin
         s1:= copy(aTag, i* 2+ 1, 2);
         c:= pos(s1, result);
         if c> 0 then begin
            s2:= ChangeIt2(s1);
            delete(result, c, 2);
            insert(s2, result, c);
         end else begin
             inc(i);
         end;
     end;
end;

//----------------------------------------------------------------
function half2full(aTag, aText: string): string;
var
   i, j, a, b: integer;
   find: boolean;
   c1, c2: Char;
begin
     result:= '';
     a:= length(aText);
     b:= Length(aTag);
     for i:= 1 to a do begin
         find:= false;
         C1:= aText[i];
         for j:= 1 to b do begin
             C2:= aTag[j];
             if C1= C2 then begin
                result:= result+ changeIt(c1);
                find:= true;
             end;
         end;
         if not find then begin
            result:= result+ c1;
         end;
     end;
end;

//----------------------------------------------------------------
function ScreenSize(var x, y: integer): boolean;
const
  ENUM_CURRENT_SETTINGS =  -1;
  ENUM_REGISTRY_SETTINGS = -2;
var
  dm: TDevMode;
begin
  Result := False;
  x := 0;
  y := 0;
  ZeroMemory(@dm, sizeof(dm));
  if EnumDisplaySettings(nil, Cardinal(ENUM_CURRENT_SETTINGS), dm) then
  begin
    Result := True;
    x := dm.dmPelsWidth;
    y := dm.dmPelsHeight;
  end else
  begin
    x := GetSystemMetrics(SM_CXSCREEN);
    y := GetSystemMetrics(SM_CYSCREEN);
  end;
end;

//----------------------------------------------------------------
function RunAndWait(FileName: string; Visibility: Integer): THandle;
var
    zAppName: array[0..512] of Char;
    zCurDir: array[0..255] of Char;  
    WorkDir: string;  
    StartupInfo: TStartupInfo;  
    ProcessInfo: TProcessInformation;  
begin  
    try  
      StrPCopy(zAppName, FileName);  
      GetDir(0, WorkDir);  
      StrPCopy(zCurDir, WorkDir);  
      FillChar(StartupInfo, SizeOf(StartupInfo), #0);  
      StartupInfo.cb := SizeOf(StartupInfo);  
      StartupInfo.dwFlags := STARTF_USESHOWWINDOW;  
      StartupInfo.wShowWindow := Visibility;  
      if not CreateProcess(nil, zAppName, nil, nil, false, Create_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then  
      begin  
        result := 0;  
        Exit;  
      end  
      else  
      begin  
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);  
        GetExitCodeProcess(ProcessInfo.hProcess, result);  
      end;  
    finally  
    end;  
end;

//----------------------------------------------------------------
function GetFullExeName: string;
var
   s1, s2: string;
   RegTmp: TRegistry;
begin
     RegTmp:= TRegistry.Create;//��ע���
     result:= '';
     try
        RegTmp.RootKey:=HKEY_LOCAL_MACHINE;
        RegTmp.Access:= KEY_QUERY_VALUE;
        if RegTmp.OpenKey('software\songbo', true) then begin
          s1:=RegTmp.ReadString('InstallPath');
          s2:=RegTmp.ReadString('exeName');
        end;
        //showmessage(RegTmp.CurrentPath);
        if s1= '' then begin
           //RegTmp.WriteString('SillyTag', 'I''m here.');
        end;
     finally
        RegTmp.CloseKey;
        RegTmp.Free;
     end;
     result:= s1+ '\'+ s2;
end;

//----------------------------------------------------------------
function GetInstallPath: string;
var
   s1: string;
   RegTmp: TRegistry;
begin
     RegTmp:= TRegistry.Create;//��ע���
     result:= '';
     try
        RegTmp.RootKey:=HKEY_LOCAL_MACHINE;
        RegTmp.Access:= KEY_QUERY_VALUE;
        if RegTmp.OpenKey('software\songbo', true) then begin
           s1:=RegTmp.ReadString('InstallPath');
        end;
        //showmessage(RegTmp.CurrentPath);
        if s1= '' then begin
        end;
     finally
        RegTmp.CloseKey;
        RegTmp.Free;
     end;
     result:= s1;
     if s1= '' then begin
        result:= exepath;
     end;
     result:= PathWithSlash(result);
end;

//----------------------------------------------------------------
function CheckBit(aNum, aBit: integer): integer;
begin
     if aBit<= 0 then begin
        result:= 0;
     end else begin
         result:= (aNum shr (aBit- 1)) mod 2;
     end;
end;

//----------------------------------------------------------------
function ChineseDateSimplest(aDate: TDateTime): string;
var
   yy, mm, dd: word;
begin
     decodeDate(aDate, yy, mm, dd);
     result:= MakeLenthNum(yy, 4)+ MakeLenthNum(mm, 2)+ MakeLenthNum(dd, 2);
end;

//----------------------------------------------------------------
function ChineseDateSimple(aDate: TDateTime): string;
var
   yy, mm, dd: word;
begin
     decodeDate(aDate, yy, mm, dd);
     result:= MakeLenthNum(yy, 4)+ '-'+ MakeLenthNum(mm, 2)+ '-'+ MakeLenthNum(dd, 2);
end;

//----------------------------------------------------------------
function ChineseDateTime(aDate: TDateTime): string;
begin
     result:= ChineseDateSimple(aDate)+ ' '+ ChineseTime(aDate);
end;

//----------------------------------------------------------------
function ChineseDate(aDate: TDateTime): string;
var
   yy, mm, dd: word;
begin
     decodeDate(aDate, yy, mm, dd);
     result:= MakeLenthNum(yy, 4)+ '��'+ MakeLenthNum(mm, 2)+ '��'+ MakeLenthNum(dd, 2)+ '��';
end;

//----------------------------------------------------------------
function ChineseTime(aDate: TDateTime): string;
var
   hh, mm, ss, msec: word;
begin
     decodeTime(aDate, hh, mm, ss, msec);
     result:= copy(inttostr(100+ hh), 2, 2)+ ':'+ copy(inttostr(100+ mm), 2, 2)+ ':'+ copy(inttostr(100+ ss), 2, 2);
end;

//----------------------------------------------------------------
function ChineseTimeSimple(aDate: TDateTime): string;
var
   hh, mm, ss, msec: word;
begin
     decodeTime(aDate, hh, mm, ss, msec);
     result:= copy(inttostr(100+ hh), 2, 2)+ copy(inttostr(100+ mm), 2, 2)+ copy(inttostr(100+ ss), 2, 2);
end;

//----------------------------------------------------------------
function GetBeautifulColor(aId: integer): TColor;
const
     ColorDefine: array[1..7,1..3] of integer= ((191,59,55),(209,128,37), (60,117,187), (142,179,68), (119,85,162), (51,163,196), (55,191,123));
begin
     if (aId> 7) or (aId< 1) then begin
        aId:= (aId- 1) mod 7+ 1;
     end;
     result:= rgb(ColorDefine[aId, 1], ColorDefine[aId, 2], ColorDefine[aId, 3]);
end;

//----------------------------------------------------------------
function filterAny(aStr: string; aFc, aTc: Char): string;
var
   i, a, st: integer;
   cc: Char;
begin
     a:= length(aStr);
     result:= '';
     st:= 0;
     for i:= 1 to a do begin
         cc:= aStr[i];
         if cc= aFc then begin
            st:= st+ 1;
         end else if cc= aTc then begin
             st:= st- 1;
         end else begin
             if st= 0 then begin
                result:= result+ cc;
             end;
         end;
     end;
end;
//----------------------------------------------------------------
function filterBranck(aStr: string): string;
begin
     result:= FilterAny(aStr, '(', ')');
end;

//----------------------------------------------------
// ����ʽ��̣��ַ�������
//----------------------------------------------------
Var getCommaList_result: string;
var getCommaList_aTrans: TStringFunc;
procedure getCommaList_AddItem(aStr: string);
begin
     if getCommaList_result= '' then begin
        getCommaList_result:= getCommaList_aTrans(aStr);
     end else begin
         getCommaList_result:= getCommaList_result+ ','+ getCommaList_aTrans(aStr);
     end;
end;

function getCommaList(aStrList: TStringList; aTrans: TStringFunc): string;
begin
     getCommaList_result:= '';
     getCommaList_aTrans:= aTrans;
     foreach(aStrList, getCommaList_AddItem);
     result:= getCommaList_result;
end;

//----------------------------------------------------
// ����ʽ��̣��ַ�������
//----------------------------------------------------
function getNameOfString(aStr: string): string;
var
   i: integer;
begin
     i:= pos('=', aStr);
     if i> 0 then begin
        result:= copy(aStr, 1, i- 1);
     end else begin
         result:= aStr;
     end;
end;

//----------------------------------------------------
// ����ʽ��̣��ļ����б��ȡ
//----------------------------------------------------
function CrGetFileList(aDesc: string): TStringList;
begin
     result:= TStringList.Create;
     manObject(result);
     GetFileList(aDesc, result);
end;

//----------------------------------------------------
function GetTextFromFile(aFileName: string): string;
var
   sl: TStringList;
begin
     if FileExists(aFileName) then begin
        sl:= TStringList.Create;
        sl.LoadFromFile(aFileName);
        result:= sl.Text;
        sl.Free;
     end else begin
         result:= '';
     end;
end;

//----------------------------------------------------
procedure SaveTextToUTF8File(AContent:string;AFileName: string);
var
  ffileStream:TFileStream;
  futf8Bytes: string;
  S: string;
begin
  ffileStream:=TFileStream.Create(AFileName,fmCreate);
  futf8Bytes:= UTF8Encode(AContent);
  S:=#$EF#$BB#$BF;
  ffileStream.Write(S[1],Length(S));
  ffileStream.Write(futf8Bytes[1],Length(futf8Bytes));
  ffileStream.Free;
end;

//----------------------------------------------------
function GetTextUTF8File(AFileName: string): string;
var
  ffileStream:TFileStream;
  fAnsiBytes: string;
  S: string;
begin
  ffileStream:=TFileStream.Create(AFileName,fmOpenRead);
  SetLength(S,ffileStream.Size);
  ffileStream.Read(S[1],Length(S));
  fAnsiBytes:= UTF8Decode(Copy(S,4,length(s)));
  Result:= fAnsiBytes;
  ffileStream.Free;
end;

//----------------------------------------------------
procedure SaveTextToFile(aText: string; aFileName: string);
var
   sl: TStringList;
begin
     sl:= TStringList.Create;
     sl.Text:= aText;
     sl.SaveToFile(aFileName);
     sl.Free;
end;

//----------------------------------------------------
procedure SaveBufferToFileNew(aBuffer: Pointer; aFrom, aLen: integer; aFileName: string);
var
   stream: TMemoryStream;
   p1, p2: integer;
   pt1: Pointer;
begin
     stream := TMemoryStream.Create;
     try
       try
          p1:= integer(aBuffer);
          p2:= p1+ aFrom;
          pt1:= pointer(p2);
          stream.Write(pt1^, ALen);
          stream.SaveToFile(AFileName);
       except
       end;
     finally
       stream.Free;
     end;
end;

//----------------------------------------------------
procedure SaveBufferToFile(aBuffer: Pointer; aLen: integer; aFileName: string);
var
   stream: TMemoryStream;
begin
     stream := TMemoryStream.Create;
     try
       try
         stream.Write(aBuffer^, ALen);
         stream.SaveToFile(AFileName);
       except
       end;
     finally
       stream.Free;
     end;
end;

//----------------------------------------------------
// ����ʽ��̣������ַ����б�
//----------------------------------------------------
{#Code#Tools_ForEach}
//----------------------------------------------------
procedure ForEach(aList: {#Tig#Class}TStrings{#Tag#Class}; aProc: {#Tig#Func}TStringProc{#Tag#Func});
var
   i: integer;
   str1: string;
begin
     for i:= 0 to aList.Count- 1 do begin
         aProc(aList[i]);
     end;
end;
{#EndCode#Tools_ForEach}

//----------------------------------------------------
procedure ForEach(aListStr: string; aProc: TStringProc); overload;
var
   sl: TStringList;
begin
     sl:= TStringList.Create;
     sl.CommaText:= aListStr;
     foreach(sl, aProc);
     sl.Free;
end;

//----------------------------------------------------
var
   InnerStringProcConst: TStringProcConst;
procedure innerStringProc(aStr: string);
begin
     InnerStringProcConst(aStr);
end;

procedure ForEach(aList: TStrings; aProc: TStringProcConst); overload;
begin
     InnerStringProcConst:= aProc;
     forEach(aList, innerStringProc);
end;

{#Insert#Tools_ForEach#Class=TObjectList#Func=TObjectProc}
//----------------------------------------------------
procedure ForEach(aList: TObjectList; aProc: TObjectProc); overload;
var
   i: integer;
   str1: string;
begin
     for i:= 0 to aList.Count- 1 do begin
         aProc(aList[i]);
     end;
end;
{#EndInsert#Tools_ForEach}

//----------------------------------------------------
var
   InnerProcMethodVar: TObjectMethod;
procedure InnerObjProc(aObj: TObject);
begin
     InnerProcMethodVar(aObj);
end;
procedure ForEach(aList: TObjectList; aProc: TObjectMethod);
begin
     InnerProcMethodVar:= aProc;
     ForEach(aList, InnerObjProc);
end;

//----------------------------------------------------
function CrForEachChange(aList: TStrings; aProc: TStringFunc): TStringList;
var
   i: integer;
   str1, str2: string;
begin
     result:= TStringList.Create;
     for i:= 0 to aList.Count- 1 do begin
         str1:= trim(aList[i]);
         str2:= aProc(str1);
         result.Add(str2);
     end;
     manObject(result);
end;

{#Code#Tools_Filter}
//----------------------------------------------------
function Filter(aList: {#Tig#Class}TStrings{#Tag#Class}; aProc: {#Tig#Func}TStringCheckFunc{#Tag#Func}): {#Tig#Class}TStrings{#Tag#Class}; overload;
var
   i: integer;
begin
     result:= {#Tig#Class}TStringList{#Tag#Class}.Create;
     manObject(result);
     for i:= 0 to aList.Count- 1 do begin
         if aProc(aList[i]) then begin
            result.Add(aList[i]);
         end;
     end;
end;
{#EndCode#Tools_Filter}

var
   InnerCheckFuncConstVar: TStringCheckFuncConst;
function InnerCheckFunc(aStr: string): boolean;
begin
     result:= InnerCheckFuncConstVar(aStr);
end;
function Filter(aList: TStrings; aProc: TStringCheckFuncConst): TStrings; overload;
begin
     InnerCheckFuncConstVar:= aProc;
     Filter(aList, InnerCheckFunc);
end;
{#Insert#Tools_Filter#Class=TObjectList#Func=TObjectFuncBoolean}
//----------------------------------------------------
function Filter(aList: TObjectList; aProc: TObjectFuncBoolean): TObjectList;
var
   i: integer;
begin
     result:= TObjectList.Create(false);
     manObject(result);
     for i:= 0 to aList.Count- 1 do begin
         if aProc(aList[i]) then begin
            result.Add(aList[i]);
         end;
     end;
end;
{#EndInsert#Tools_Filter}

//----------------------------------------------------
function ForEachLink(aList: TObjectList; aFunc: TObjectFunc): string;
var
   i: integer;
begin
     result:= '';
     for i:= 0 to aList.Count- 1 do begin
         result:= result+ aFunc(aList[i]);
     end;
end;

//----------------------------------------------------
function ifTest(aTest: Boolean; aTrueValue, aFalseValue: string): string;
begin
     if aTest then begin
        result:= aTrueValue;
     end else begin
         result:= aFalseValue;
     end;
end;

//----------------------------------------------------
// ����ʽ��̣����ļ��� TStringProc
//----------------------------------------------------
procedure FileNamePlus1(aFromName: string);
var
   str1, str2, str3: string;
   a, cc: integer;
begin
     str1:= extractFilePath(aFromName);
     str2:= ChangeFileExt(extractFileName(aFromName), '');
     str3:= extractFileExt(aFromName);
     a:= length(str2);
     if (str2[a] in ['0'..'8'])or (str2[a] in ['a'..'y']) or (str2[a] in ['A'..'Y']) then begin
        str2:= copy(str2, 1, a- 1)+ chr(ord(str2[a])+ 1);
     end else if str2[a]= '9' then begin
         str2:= copy(str2, 1, a- 1)+ 'A';
     end else begin
         str2:= str2+ '1';
     end;
     RenameFile(aFromName, str1+ ChangeFileExt(str2, str3));
end;

//----------------------------------------------------------------
function GetBackUpFileName(aFromName: string): string;
var
   str1, str2, str3: string;
   a, cc: integer;
   dt1: TDateTime;
begin
     str1:= extractFilePath(aFromName);
     str2:= ChangeFileExt(extractFileName(aFromName), '');
     str3:= extractFileExt(aFromName);
     dt1:= now;
     str2:= str2+ '_'+ ChineseDateSimplest(dt1)+ '_'+ ChineseTimeSimple(dt1)+ '_1';
     result:= str1+ ChangeFileExt(str2, str3);
end;

//----------------------------------------------------------------
function NewFileNameFrom(aFromName: string): string;
var
   str1, str2, str3: string;
   a, cc: integer;
begin
     str1:= extractFilePath(aFromName);
     str2:= ChangeFileExt(extractFileName(aFromName), '');
     str3:= extractFileExt(aFromName);
     a:= length(str2);
     if (str2[a] in ['0'..'8'])or (str2[a] in ['a'..'y']) or (str2[a] in ['A'..'Y']) then begin
        str2:= copy(str2, 1, a- 1)+ chr(ord(str2[a])+ 1);
     end else if str2[a]= '9' then begin
         str2:= copy(str2, 1, a- 1)+ 'A';
     end else begin
         // ���������ֱ���ӳ��ļ���������Z��Ҳ��ͬ����
         str2:= str2+ '1';
     end;
     result:= str1+ ChangeFileExt(str2, str3);
end;

//----------------------------------------------------------------
function getLine(aStr: string): string;
begin
     result:= aStr+ #$d#$a;
end;

//----------------------------------------------------------------
function RemoveLast(aStr: string): string;
begin
     result:= copy(aStr, 1, length(aStr)- 1);
end;

//----------------------------------------------------------------
function SpaceList2Comma(aText: string): string;
var
   i, a, st: integer;
   cc: char;
begin
     a:= length(aText);
     result:= '';
     st:= 0;
     for i:= 1 to a do begin
         cc:= aText[i];
         if cc<> ' ' then begin
            result:= result+ cc;
            st:= 0;
         end else begin
             if st= 0 then begin
                result:= result+ ',';
                st:= 1;
             end;
         end;
     end;
end;

//----------------------------------------------------------------
function WinExecAndWait32(FileName: string; Visibility: integer): Dword;
      {ִ��һ���ⲿ���򲢵ȴ������}
var
  zAppName: array[0..512] of char;
  zCurDir: array[0..255] of char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
    StrPCopy(zAppName, FileName);
    GetDir(0, WorkDir);
    StrPCopy(zCurDir, WorkDir);
    FillChar(StartupInfo, Sizeof(StartupInfo), #0);
    StartupInfo.cb := Sizeof(StartupInfo);
    StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartupInfo.wShowWindow := Visibility;
    if not CreateProcess(nil,
      zAppName, { pointer to command line string }
      nil, { pointer to process security attributes }
      nil, { pointer to thread security attributes }
      false, { handle inheritance flag }
      CREATE_NEW_CONSOLE or { creation flags }  NORMAL_PRIORITY_CLASS,
      nil, { pointer to new environment block }
      nil, { pointer to current directory name }
      StartupInfo, { pointer to STARTUPINFO }
      ProcessInfo)
    then Result := 1 { pointer to PROCESS_INF }
    else
      begin
        while WaitforSingleObject(ProcessInfo.hProcess, 10) = WAIT_TIMEOUT
          do Application.ProcessMessages;
        GetExitCodeProcess(ProcessInfo.hProcess, Result);
      end;
end;

//----------------------------------------------------------------
function FGetFileTime(sFileName:string; TimeType:Integer):TDateTime;
var
  ffd:TWin32FindData;
  dft:DWord;
  lft,Time:TFileTime;
  H:THandle;
begin
  H:=Windows.FindFirstFile(PChar(sFileName),ffd);
  case TimeType of
    0:Time:=ffd.ftCreationTime;
    1:Time:=ffd.ftLastWriteTime;
    2:Time:=ffd.ftLastAccessTime;
  end;
//��ȡ�ļ���Ϣ
  if(H<>INVALID_HANDLE_VALUE)then
  begin
  //ֻ����һ���ļ������Թص�"find"
    Windows.FindClose(H);
  //ת��FILETIME��ʽ��ΪlocalFILETIME��ʽ
    FileTimeToLocalFileTime(Time,lft);
  //ת��FILETIME��ʽ��ΪDOStime��ʽ
    FileTimeToDosDateTime(lft,LongRec(dft).Hi,LongRec(dft).Lo);
  //���ת��DOStime��ʽ��ΪDelphi'sӦ�õ�TdateTime��ʽ
    Result:=FileDateToDateTime(dft);
  end
  else
    result:=0;
end;

//----------------------------------------------------------------
function GetExeVersion(aFileName: string): string;
var
verinfosize : DWORD;
verinfo : pointer;
vervaluesize : dword;
vervalue : pvsfixedfileinfo;
dummy : dword;
v1,v2,v3,v4 : word;
begin
verinfosize := getfileversioninfosize(pchar(aFileName),dummy);
if verinfosize = 0 then begin
dummy := getlasterror;
result := '0.0.0.0';
end;
getmem(verinfo,verinfosize);
getfileversioninfo(pchar(aFileName),0,verinfosize,verinfo);
verqueryvalue(verinfo,'\',pointer(vervalue),vervaluesize);
with vervalue^ do begin
v1 := dwfileversionms shr 16;
v2 := dwfileversionms and $ffff;
v3 := dwfileversionls shr 16;
v4 := dwfileversionls and $ffff;
end;
result := inttostr(v1) + '.' + inttostr(v2) + '.' + inttostr(v3) + '.' + copy(inttostr(1000+ v4), 2, 3);
freemem(verinfo,verinfosize);
end;

//----------------------------------------------------------------
function GetBuildInfo: string; //��ȡ�汾��
begin
     result:= GetExeVersion(paramstr(0));
end;


//----------------------------------------------------------------
procedure LoadJpgToImage(aImage: TImage; aJpgFile: string);
var
   jp1: TJpegImage;
begin
     jp1:= TJpegImage.Create;
     jp1.LoadFromFile(ExePath+ 'Blank.jpg');
     aImage.Canvas.MoveTo(0, 0);
     aImage.Canvas.LineTo(10, 10);
     aImage.Picture.Graphic.Width:= jp1.Width;
     aImage.Picture.Graphic.Height:= jp1.Height;
     aImage.Canvas.Draw(0, 0, jp1);
     jp1.Free;
end;

//----------------------------------------------------------------
procedure UpdateSelfAndStartAgain(aFileName: string);
var
  BatchFile: TextFile;
  BatchFileName: string;
  ProcessInfo: TProcessInformation;
  StartUpInfo: TStartupInfo;
begin
  BatchFileName := ExtractFilePath(ParamStr(0)) + '_deleteme.bat';

  AssignFile(BatchFile, BatchFileName);
  Rewrite(BatchFile);

  Writeln(BatchFile, ':try');
  Writeln(BatchFile, 'del "' + ParamStr(0) + '"');
  Writeln(BatchFile,
    'if exist "' + ParamStr(0) + '"' + ' goto try');
  Writeln(BatchFile, 'copy "' + aFileName+ '" "'+ ParamStr(0) + '"');
  Writeln(BatchFile, ParamStr(0));
  Writeln(BatchFile, 'del %0');
  CloseFile(BatchFile);

  FillChar(StartUpInfo, SizeOf(StartUpInfo), $00);
  StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartUpInfo.wShowWindow := SW_HIDE;

  if CreateProcess(nil, PChar(BatchFileName), nil, nil,
    False, IDLE_PRIORITY_CLASS, nil, nil, StartUpInfo,
    ProcessInfo) then
  begin
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
  end;
end;

//----------------------------------------------------------------
function ManyChar(aChar: Char; aNum: integer): string;
var
   i: integer;
begin
     result:= '';
     for i:= 1 to aNum do begin
         result:= result+ aChar;
     end;
end;

//----------------------------------------------------------------
function IsNumber(aStr: string): Boolean;
var
  E, a: Integer;
begin
     Val(aStr, a, E);
     result:= (E=0);
end;

//----------------------------------------------------------------
procedure UpdateFiles(aFileNames: TStrings; aDir: string);
var
   i: integer;
   str1, str2: string;
   dt1, dt2: TDateTime;
   up: boolean;
begin
     if assigned(aFileNames) then begin
        ForceDirectories(aDir);
        for i:= 0 to aFileNames.Count- 1 do begin
            str1:= aFileNames[i];
            str2:= PathWithSlash(aDir)+ extractFileName(aFileNames[i]);
            if not FileExists(str1) then begin
               continue;
            end;
            up:= false;
            if not FileExists(str2) then begin
               up:= true;
            end else begin
                dt1:= FGetFileTime(str1, 1);
                dt2:= FGetFileTime(str2, 1);
                if dt1> dt2 then begin
                   up:= true;
                end;
            end;
            if up then begin
               CopyFile(str1, str2);
            end;
        end;
     end;
end;

//----------------------------------------------------------------
procedure CopyFiles(aFileNames, aDestNames: TStrings; aDir: string);
var
   i: integer;
begin
     if assigned(aFileNames) then begin
        ForceDirectories(aDir);
        for i:= 0 to aFileNames.Count- 1 do begin
            CopyFile(aFileNames[i], PathWithSlash(aDir)+ extractFileName(aDestNames[i]));
        end;
     end;
end;

//----------------------------------------------------------------
procedure CopyFiles(aFileNames: TStrings; aDir: string); overload;
begin
     if assigned(aFileNames) then begin
        CopyFiles(aFileNames, aFileNames, aDir);
     end;
end;

//----------------------------------------------------------------
procedure CopyFiles(aFrom, aDir: string); overload;
var
   sl: TStringList;
begin
     sl:= TStringList.Create;
     getFileList(aFrom, sl);
     copyFiles(sl, aDir);
     sl.Free;
end;

//----------------------------------------------------------------
function WordWrap(aText: string; aWrapLength: integer): string;
var
   i, a, b: integer;
   sl: TStringList;
   str1: string;
begin
     a:= Length(aText);
     if a<= aWrapLength then begin
        result:= aText;
     end else begin
         i:= 1;
         sl:= TStringList.Create;
         repeat
             b:= pos(#13#10, aText);
             if (b>0) and (b<= aWrapLength) then begin
                str1:= copy(aText, 1, b- 1);
                aText:= copy(aText, b+ 2, a);
             end else begin
                 // β��������ĵ�������֮
                 if ByteType(aText, 1+ aWrapLength- 1)= mbLeadByte then begin
                    str1:= copy(aText, 1, aWrapLength- 3);
                 end else begin
                     str1:= copy(aText, 1, aWrapLength- 2);
                 end;
                 aText:= copy(aText, length(str1)+ 1, a);
             end;
             sl.Add(str1);
             //i:= i+ length(str1);
         until aText= '';
         result:= sl.Text;
     end;
end;

//----------------------------------------------------------------
Function CutStr(aStr: string; aLength: integer): string;
var
   a: integer;
begin
     a:= Length(aStr);
     if a<= aLength then begin
        result:= aStr;
     end else begin
         result:= copy(aStr, 1, aLength- 2);
         // β��������ĵ�������֮
         if ByteType(aStr, aLength- 2)= mbLeadByte then begin
            result:= copy(aStr, 1, aLength- 3);
         end;
         result:= result+ '��';
     end;
end;

//----------------------------------------------------------------
Function DecodeIp(aIp: string; var a1, a2, a3, a4: integer): boolean;
var
   i, a: integer;
   v1: array[1..4]of integer;
   str1: string;
begin
     a:= pos(':', aIp);
     if a<= 0 then begin
        a:= pos('_', aIp);
     end;
     if a> 0 then begin
        aIp:= copy(aIp, 1, a- 1);
     end;
     result:= true;
     for i:= 1 to 3 do begin
         a:= pos('.', aIp);
         if a<= 0 then begin
            result:= false;
         end else begin
             str1:= copy(aIp, 1, a- 1);
             v1[i]:= strtointdef(str1, -1);
         end;
         aIp:= copy(aIp, a+ 1, length(aIp));
     end;
     if result then begin
        v1[4]:= strtointdef(aIp, -1);
        if (v1[1]>= 0) and (v1[2]>= 0) and (v1[3]>= 0) and (v1[4]>= 0) then begin
           a1:= v1[1];
           a2:= v1[2];
           a3:= v1[3];
           a4:= v1[4];
        end else begin
            result:= false;
        end;
     end;
end;

//----------------------------------------------------------------
function ReadBetweenTag(aText: string; aFromTag, aToTag: string; var aPos: integer): string;
var
   p1, p2, a1, a2: integer;
begin
     result:= '';
     p1:= ciPosEx(aFromTag, aText, aPos);
     if p1> 0 then begin
        inc(aPos);
        p2:= ciPosEx(aToTag, aText, aPos);
        if p2> 0 then begin
           a1:= p1+ length(aFromTag);
           a2:= p2- a1;
           result:= copy(aText, a1, a2);
        end;
     end;
end;

//----------------------------------------------------------------
function ReadBetween(aText: string; aFc, aTc: Char; var aPos: integer): string;
var
   i, a: integer;
begin
     result:= '';
     i:= aPos;
     a:= Length(aText);
     while (i< a) and (aText[i] <> aFc) do begin
           inc(i);
     end;
     inc(i);
     while (i<= a) and (aText[i] <> aTc) do begin
           result:= result+ aText[i];
           inc(i);
     end;
     if (i<= a) and (aText[i]= aTc) then begin
        aPos:= i+ 1;
     end else begin
         // aPos< 0 �������
         aPos:= -i;
         result:= '';
     end;
end;

//----------------------------------------------------------------
function ReadCodeWord(aText: string; aSpace: TCharSet; var aPos: integer): string;
var
   i, a: integer;
begin
     result:= '';
     i:= aPos;
     a:= Length(aText);
     while (i<= a) and not (aText[i] in aSpace) do begin
           result:= result+ aText[i];
           inc(i);
     end;
     aPos:= i;
     result:= trim(result);
end;

//----------------------------------------------------------------
function ReadWord(aText: string; aSpace: TCharSet; var aPos: integer): string;
var
   i, a: integer;
begin
     result:= '';
     i:= aPos;
     a:= Length(aText);
     while (i< a) and (aText[i] in aSpace) do begin
           inc(i);
     end;
     while (i<= a) and not (aText[i] in aSpace) do begin
           result:= result+ aText[i];
           inc(i);
     end;
     aPos:= i;
end;

//----------------------------------------------------------------
function CopyDir(sDirName:String;sToDirName:String):Boolean;
var
   hFindFile:Cardinal;
   t,tfile:String;
   sCurDir:String[255];
   FindFileData:WIN32_FIND_DATA;
begin
   //��¼��ǰĿ¼
   sCurDir:=GetCurrentDir;
   ChDir(sDirName);
   hFindFile:=FindFirstFile('*.*',FindFileData);
   if hFindFile<>INVALID_HANDLE_VALUE then begin
        if not DirectoryExists(sToDirName) then
           ForceDirectories(sToDirName);
        repeat
              tfile:=FindFileData.cFileName;
              if (tfile='.') or (tfile='..') then
                 Continue;
              if FindFileData.dwFileAttributes= FILE_ATTRIBUTE_DIRECTORY then begin
                   t:=sToDirName+'\'+tfile;
                   if  not DirectoryExists(t) then
                       ForceDirectories(t);
                   if sDirName[Length(sDirName)]<>'\' then
                      CopyDir(sDirName+'\'+tfile,t)
                   else
                      CopyDir(sDirName+tfile, sToDirName+tfile);
              end else begin
                   t:=sToDirName+'\'+tFile;
                   CopyFile(PChar(tfile),PChar(t));
              end;
        until FindNextFile(hFindFile,FindFileData)=false;
      ///  FindClose(hFindFile);
   end else begin
        ChDir(sCurDir);
        result:=false;
        exit;
   end;
   //�ص���ǰĿ¼
   ChDir(sCurDir);
   result:=true;
end;

//----------------------------------------------------------------
function UpdateDir(sDirName:String; sToDirName:String):Boolean;
begin
end;

//----------------------------------------------------------------
function GetDelimaTextCount(aText: string; aDelima: Char): integer;
var
   sl: TStringList;
begin
     sl:= TStringList.Create;
     sl.Delimiter:= aDelima;
     sl.DelimitedText:= aText;
     result:= sl.Count;
     sl.Free;
end;

//----------------------------------------------------------------
function GetItemFromList(aStrList: string; aId: integer): string;
var
   sl: TStringList;
   a, b, i, state: integer;
   c: Char;
   strList: array of string;
   str1: string;
begin
     // ��ӵ�ȫ���㷨
     i:= 1;
     b:= length(aStrList);
     if b= 0 then begin
        result:= '';
        exit;
     end;
     str1:= '';
     state:= 0;
     a:= 0;
     //��βĬ��һ������
     if aStrList[b]<> ',' then begin
        aStrList:= aStrList+ ',';
        b:= b+ 1;
     end;
     setLength(strList, 1);
     while (i<= b) do begin
           c:= aStrList[i];
           if (state= 0) and (c= ',') then begin
              strList[a]:= str1;
              str1:= '';
              inc(a);
              setLength(strList, a+ 1);
           end else if (state= 1) and (c='"') then begin
               state:= 0;
           end else if (state= 0) and (c='"') then begin
               state:= 1;
           end else begin
               str1:= str1+ c;
           end;
           inc(i);
     end;
     //aId:= aId- 1;
     if (aId>= 0) and (aId< a) then begin
        result:= strList[aId];
     end else begin
         result:= '';
     end;
     { �����������Ȼû����ȷ��������
     a:= 1;
     c:= pos(',', aStrList);
     b:= 0;
     while (c> 0) and (b< aId) do begin
           a:= c+ 1;
           c:= posEx(',', aStrList, a);
           inc(b);
     end;
     if c> 0 then begin
        // �м��ĳ��
        result:= copy(aStrList, a, c- a);
     end else if (c<= 0) and (aId= b) then begin
         // ���һ��
         result:= copy(aStrList, a, length(aStrList));
     end else begin
         result:= '';
     end;
     //}
     //  �ɰ�Ч�����ã��޷������лس����е����
     {
     sl:= TStringList.Create;
     sl.CommaText:= aStrList;
     if (aId< sl.Count) and (aId>= 0) then begin
        result:= sl[aId];
     end else begin
         result:= '';
     end;
     sl.Free;
     //}
end;

//----------------------------------------------------------------
function GetItemFromListDelima(aStrList: string; aId: integer; aDelima: Char): string;
var
   sl: TStringList;
   a, b, i, state: integer;
   c: Char;
   strList: array of string;
   str1: string;
begin
     // ��ӵ�ȫ���㷨
     i:= 1;
     b:= length(aStrList);
     str1:= '';
     state:= 0;
     a:= 0;
     //��βĬ��һ������
     if aStrList[b]<> aDelima then begin
        aStrList:= aStrList+ aDelima;
        b:= b+ 1;
     end;
     setLength(strList, 1);
     while (i<= b) do begin
           c:= aStrList[i];
           if (state= 0) and (c= aDelima) then begin
              strList[a]:= str1;
              str1:= '';
              inc(a);
              setLength(strList, a+ 1);
           end else if (state= 1) and (c='"') then begin
               state:= 0;
           end else if (state= 0) and (c='"') then begin
               state:= 1;
           end else begin
               str1:= str1+ c;
           end;
           inc(i);
     end;
     //aId:= aId- 1;
     if (aId>= 0) and (aId< a) then begin
        result:= strList[aId];
     end else begin
         result:= '';
     end;
end;

//----------------------------------------------------------------
function ReplaceStr(aText, aFrom, aTo: string): string;
var
   i, a: integer;
begin
     i:= 1;
     i:= posex(aFrom, aText, i);
     while i>= 1 do begin
           delete(aText, i, Length(aFrom));
           insert(aTo, aText, i);
           i:= i+ length(aTo);
           i:= posex(aFrom, aText, i);
     end;
     result:= aText;
end;

//----------------------------------------------------------------
function MakeLenthNum(aNum, aLen: integer): string;
var
   a, i: integer;
begin
     result:= inttostr(aNum);
     a:= Length(result);
     for i:= 1 to aLen- a do begin
         result:= '0'+ result;
     end;
end;

//----------------------------------------------------------------
function GetRandomNo(aLen: integer): string;
var
   i: integer;
begin
     result:= '';
     for i:= 1 to aLen do begin
         result:= result+ inttostr(Random(10));
     end;
end;

//----------------------------------------------------------------
Function WinExecExW(CMD:Pchar; Visiable:integer):DWORD;
var
    StartupInfo : TStartupInfo;
    ProcessInfo : TProcessInformation;
begin
    FillChar( StartUpInfo, SizeOf(StartUpInfo), $00 );
    StartUpInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartUpInfo.wShowWindow := SW_HIDE;
    if CreateProcess( nil, CMD, nil, nil, {�����������ļ�}
    False, IDLE_PRIORITY_CLASS, nil, nil, StartUpInfo,
    ProcessInfo ) then
    begin
        WaitForSingleObject(Processinfo.hProcess,INFINITE);
        GetExitCodeProcess(ProcessInfo.hProcess,Result);

        CloseHandle( ProcessInfo.hThread );
        CloseHandle( ProcessInfo.hProcess );
    end;
end;

//----------------------------------------------------------------
function ChineseDayOfWeek(aDate: TDateTime): string;
var
   a: integer;
   str1: string;
begin
     a:= DayOfWeek(aDate);
     case a of
          1: begin
             str1:= '��';
          end;
          2: begin
             str1:= 'һ';
          end;
          3: begin
             str1:= '��';
          end;
          4: begin
             str1:= '��';
          end;
          5: begin
             str1:= '��';
          end;
          6: begin
             str1:= '��';
          end;
          7: begin
             str1:= '��';
          end;
     end;
     result:= '����'+ str1;
end;

//----------------------------------------------------------------
procedure ListToCSV(alv: TListView; aFileName: string);
var
   i, j: integer;
   sl: TStringList;
   str1: string;
begin
     sl:= TStringList.Create;
     for i:= 0 to alv.Items.Count- 1 do begin
         str1:= alv.Items[i].Caption;
         for j:= 0 to alv.Items[i].SubItems.Count- 1 do begin
             str1:= str1+ ','+ alv.Items[i].SubItems[j];
         end;
         sl.Add(str1);
     end;
     sl.SaveToFile(aFileName);
     sl.Free;
end;

//----------------------------------------------------------------
procedure DrawStrCenter(aCanvas: TCanvas; ax, ay, aw, ah: integer; aStr: string);
var
   tw, th: integer;
begin
     tw:= aCanvas.TextWidth(aStr);
     th:= aCanvas.TextHeight(aStr);
     aCanvas.TextOut(ax+ (aw- tw) div 2, ay+ (ah- th) div 2, aStr);
end;

//----------------------------------------------------------------
function GetComPortList: TStrings;
var
  Reg: TRegistry;
  sts1,sts2: TStrings;
  i: Integer;
  RegPath: string;  //ע����д�Ŵ���·��
begin
  Result := nil;
  Reg := TRegistry.Create;
  try
    sts1 := TStringList.Create;
    try
      sts2 := TStringList.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      RegPath := UpperCase('hardware\devicemap\SerialComm');
      if Reg.OpenKeyReadOnly(RegPath) then
      begin
        Reg.GetValueNames(sts1);
        for i := 0 to sts1.Count-1 do
          sts2.Add(Reg.ReadString(sts1.Strings[i]));
      end;
      Result := sts2;
      sts2 := nil;
    finally
      FreeAndNil(sts1);
    end;
  finally
    Reg.CloseKey;
    FreeAndNil(Reg);
  end;
end;

//----------------------------------------------------------------
procedure GetComList(slPort: TStrings);

 var
      reg   :   TRegistry;
      ts   :   TStrings;
      i   :   integer;
      sName,sPort:string;
      slList:TStringList;
  begin
      reg   :=   TRegistry.Create;
      ts   :=   TStringList.Create;
      slList:=TStringList.Create;
      try
          reg.RootKey   :=   HKEY_LOCAL_MACHINE;
          reg.OpenKey('hardware\devicemap\serialcomm',false);
          reg.GetValueNames(ts);

          slList.Sorted:=true;

          for   i   :=   0   to   ts.Count   -1   do   begin
              sName:=LowerCase(Trim(ts.Strings[i]));
              //�õ���������
              sPort   :=   UpperCase(Trim(reg.ReadString(sName)));
              if   Copy(sPort,1,3)   <>   'COM'   then   Continue;
              sPort:=Copy(sPort,4,Length(sPort));
              sPort:=FormatFloat('000',StrToInt(sPort));
              slList.Add(sPort);
          end;

          slPort.Clear;
          for   i:=0   to   slList.Count-1   do
              slPort.Add('COM'+IntToStr(StrToInt(slList.Strings[i])));
      finally
          ts.Free;
          reg.CloseKey;
          reg.free;
      end;
end;

//----------------------------------------------------------------
procedure GetUSBCOMNames(var AResult: TStringList);
const
  RegistryRootKey           = HKEY_LOCAL_MACHINE;
  RegistryPath_DeviceClasses= 'SYSTEM\CurrentControlSet\Control\DeviceClasses\{86e0d1e0-8089-11d0-9ce4-08003e301f73}';
  RegistryPath_Enum         = 'SYSTEM\CurrentControlSet\Enum';
var
  Dev, Reg: TRegistry;
  KeyNames: TStringList;
  iLoop   : Integer;
  iCount  : DWORD;
  APath   : TStringList;
begin
  AResult.Clear;
  Dev := TRegistry.Create;
  try
    Dev.RootKey := RegistryRootKey;
    if Dev.OpenKeyReadOnly(RegistryPath_DeviceClasses) then
    begin
      KeyNames := TStringList.Create;
      try
        Dev.GetKeyNames(KeyNames);
        Reg := TRegistry.Create;
        try
          Reg.RootKey := RegistryRootKey;
          //��������USBCOM�豸��ע�����
          for iLoop := 0 to KeyNames.Count - 1 do
          begin
            if Reg.OpenKeyReadOnly(RegistryPath_DeviceClasses + '\' + KeyNames.Strings[iLoop] + '\Control') then
            begin
              iCount := Reg.ReadInteger('ReferenceCount');
              Reg.CloseKey;
              if iCount > 0 then      //RefrenceCount > 0 ��ʾ��USBCOMĿǰ������������
              begin
                APath := TStringList.Create;
                try
                  //��ȡ��USBCOM�豸��Enumע�������
                  APath.Delimiter := '#';
                  APath.DelimitedText := KeyNames.Strings[iLoop];
                  if APath.Count >= 6 then
                  begin
                    if Reg.OpenKeyReadOnly(RegistryPath_Enum + '\' + APath.Strings[3] + '\' + APath.Strings[4] + '\' + APath.Strings[5]) then
                    begin
                      AResult.Add(Reg.ReadString('FriendlyName'));
                      Reg.CloseKey;
                    end;
                  end;
                finally
                  APath.Free;
                end;
              end;
            end;
          end;
        finally
          Reg.Free;
        end;
      finally
        KeyNames.Free;
      end;
      Dev.CloseKey;
    end;
  finally
    Dev.Free;
  end;
end;

//----------------------------------------------------------------
function LengthStr(aStr: string; aLength: integer; aFront: Boolean): string;
var
   a, i: integer;
   str1: string;
begin
     a:= Length(aStr);
     if a>= aLength then begin
        result:= aStr;
     end else begin
         str1:= '';
         for i:= 1 to aLength- a do begin
             str1:= str1+ ' ';
         end;
         if aFront then begin
            result:= str1+ aStr;
         end else begin
             result:= aStr+ str1;
         end;
     end;
end;

//----------------------------------------------------------------
// ��ǰ���Ѱ�ҵ�aNum���Ӵ�
function PosFromSide(aSubStr, aText: string; aSide, aNum: integer): integer;
var
   a, b: integer;
   str1: string;
   pose: array of integer;
   num: integer;
begin
     num:= 0;
     str1:= aText;
     b:= 0;
     a:= pos(aSubstr, str1);
     while a> 0 do begin
           inc(num);
           setLength(pose, num);
           pose[num- 1]:= a+ b;
           str1:= Copy(str1, a+ length(aSubStr), length(str1));
           b:= a+ b;
           a:= pos(aSubSTr, str1);
     end;
     if aNum> Num then begin
        result:= -1;
     end else begin
         if aSide= 1 then begin
            // ��ǰ
            result:= pose[aNum- 1];
         end else if aSide= 2 then begin
             // �Ӻ�
             result:= pose[Num- aNum];
         end;
    end;
end;

//----------------------------------------------------------------
function ReplaceAny(aChar1, aChar2: Char; aText: string): string;
var
   i, a: integer;
begin
     a:= length(aText);
     result:= '';
     for i:= 1 to a do begin
         if aText[i]<> aChar1 then begin
            result:= result+ aText[i];
         end else begin
             result:= result+ aChar2;
         end;
     end;
end;

//----------------------------------------------------------------
function TrimAny(aChar: Char; aText: string): string;
var
   i, a: integer;
begin
     a:= length(aText);
     result:= '';
     for i:= 1 to a do begin
         if aText[i]<> aChar then begin
            result:= result+ aText[i];
         end;
     end;
end;

//----------------------------------------------------------------
function InnerTrim(aText: string): string;
begin
     result:= Trim(TrimAny(#13, TrimAny(#10, TrimAny(#9, TrimAny(' ', aText)))));
end;
//----------------------------------------------------------------
function StrToHex(aStr: string; aIn: string): string;
var
   a, i: integer;
   abc: string;
begin
     a:= Length(aStr);
     abc:= '';
     for i:= 1 to a do begin
         abc:= abc+ inttohex(ord(aStr[i]), 2);
         if i<> a then begin
            abc:= abc+ aIn;
         end else begin
             abc:= abc+ aIn;
         end;
     end;
     StrToHex:= abc;
end;

//----------------------------------------------------------------
function HexToStr(aStr: string; aIn: string): string;
var
   a, b, c, i: integer;
begin
     a:= Length(aStr);
     b:= a div (2+ Length(aIn));
     c:= 2+ Length(aIn);
     result:= '';
     for i:= 1 to b do begin
         result:= result+ chr(StrToIntDef('$0'+ aStr[(i- 1)* c+ 1]+ aStr[(i- 1)* c+ 2], 0));
     end;
     //result:= trim(result);
end;

//----------------------------------------------------------------
function FloatToStrEx(aNum: double; aDig: integer=2): string;
begin
     result:= FloatToStrF(aNum, ffFixed, 10, aDig);
end;

//----------------------------------------------------------------
procedure ShineForm(aForm: TForm);
var
   i: integer;
begin
     aForm.BringToFront;
     aForm.Enabled:= false;
     for i:= 1 to 3 do begin
         aForm.Show;
         aForm.Refresh;
         sleep(500);
         aForm.Hide;
         sleep(100);
     end;
     aForm.Show;
     aForm.Enabled:= true;
end;

//----------------------------------------------------------------
procedure DeleteFileEx(aFileName:string);
var
    FileDir:string;
    FileStruct:TSHFileOpStruct;
begin
    FileDir   :=  aFileName;// 'C:\temp\abc*.txt';
    FileStruct.Wnd   :=0;
    FileStruct.wFunc   :=FO_delete;
    FileStruct.pFrom:=Pchar(FileDir+#0);
    FileStruct.fFlags:=FOF_NOCONFIRMATION;
    FileStruct.pTo   := ' ';
    if SHFileOperation(FileStruct)=0   then begin
    end else begin
        // δɾ��
        raise exception.Create('delete error:'+ aFileName);
    end;
   //       showmessage( 'The   Files   Has   Been   Deleted! ');
end;

//----------------------------------------------------------------
function EmptyDirectory(TheDirectory: String; Recursive: Boolean): Boolean;
var
  SearchRec: TSearchRec;
  Res: Integer;
begin
  Result := False;
  if rightStr(trim(TheDirectory), 1) <> '\' then
    TheDirectory := trim(TheDirectory) + '\'
  else
    TheDirectory := trim(TheDirectory);
  //
  Res := FindFirst(TheDirectory + '*.*', faAnyFile, SearchRec);
  try
    while Res = 0 do begin
      if (SearchRec.Name<>'..') then begin
        if ((SearchRec.Attr and faDirectory) > 0) and Recursive then begin
          EmptyDirectory(TheDirectory + SearchRec.Name, True);
          RemoveDirectory(PChar(TheDirectory + SearchRec.Name));
        end else begin
          DeleteFile(PChar(TheDirectory + SearchRec.Name))
        end;
      end;
      Res := FindNext(SearchRec);
    end;
    if Recursive then begin
       RemoveDirectory(PChar(TheDirectory));
    end;
    Result := True;
  finally
    FindClose(SearchRec);
  end;
end;

//----------------------------------------------------------------
function GetSubStrFrom(aText, aTag1, aTag2: string): string;
var
   a, b: integer;
begin
     a:= pos(aTag1, aText);
     b:= pos(aTag2, aText);
     result:= copy(aText, a+length(aTag1), b-a-length(aTag1));
end;

//----------------------------------------------------------------
function FindTag(aTag, aText: string): boolean;
var
   str1, str2, aTag1, aText1: string;
   a1, a2: integer;
begin
     aTag1:= UpperCase(aTag);
     aText1:= UpperCase(aText);
     str1:= '<'+aTag1+ '>';
     str2:= '</'+aTag1+ '>';
     a1:= pos(str1, aText1);
     a2:= pos(str2, aText1);
     if (a1> 0) and (a2> 0) then begin
        result:= true;
     end else begin
         result:= false;
     end;
end;

//----------------------------------------------------------------
function GetTagged(aTag, aValue: string): string;
begin
     result:= '<'+aTag+ '>'+aValue+ '</'+ aTag+ '>';
end;

function RemoveTagged(aTag, aText: string): string;
var
   str1, str2, s1, s2, aText1: string;
   a1, a2: integer;
begin
     aTag:= UpperCase(aTag);
     aText1:= UpperCase(aText);
     str1:= '<'+aTag+ '>';
     str2:= '</'+aTag+ '>';
     a1:= pos(str1, aText1);
     a2:= pos(str2, aText1);
     if (a1> 0) and (a2> 0) then begin
        s1:= copy(aText, 1, a1- 1);
        s2:= copy(aText, a2+ length(str2), length(aText));
        result:= s1+ s2;
     end else begin
         result:= aText;
     end;
end;

//----------------------------------------------------------------
// ���û�У�����ӣ�����У����޸�
function SetTagValue(aTag, aValue, aText: string): string;
var
   str1, str2, aTag1, aText1: string;
   a1, a2: integer;
   b: boolean;
begin
     b:= FindTag(aTag, aText);
     if b then begin
        if aValue<> '' then begin
           aTag1:= UpperCase(aTag);
           aText1:= UpperCase(aText);
           str1:= '<'+aTag1+ '>';
           str2:= '</'+aTag1+ '>';
           a1:= pos(str1, aText1);
           a2:= pos(str2, aText1);
           if (a1> 0) and (a2> 0) then begin
              result:= copy(aText, 1, a1+ length(str1)- 1)+ aValue+ copy(aText, a2, length(aText));
           end else begin
               result:= aText+ GetTagged(aTag, aValue);
           end;
        end else begin
            result:= RemoveTagged(aTag, aText);
        end;
     end else begin
         if aValue<> '' then begin
            result:= aText+ GetTagged(aTag, aValue);
         end else begin
             result:= aText;
         end;
     end;
end;

//----------------------------------------------------------------
function GetTagValue(aTag, aText: string): string;
var
   str1, str2, aTag1, aText1: string;
   a1, a2: integer;
begin
     aTag1:= UpperCase(aTag);
     aText1:= UpperCase(aText);
     str1:= '<'+aTag1+ '>';
     str2:= '</'+aTag1+ '>';
     a1:= pos(str1, aText1);
     a2:= pos(str2, aText1);
     if (a1> 0) and (a2> 0) then begin
        result:= copy(aText, a1+ length(str1), a2- a1- length(str1));
     end else begin
         result:= '';
     end;
end;

//----------------------------------------------------------------
procedure SaveRgn(aRgn: hrgn);
var
  vRGN: HRGN;
  vSize: Longword;
  vData: PRgnData;
begin
  vRGN := aRgn;
  vSize := GetRegionData(vRGN, SizeOf(TRgnData), nil); // �õ���С
  GetMem(vData, vSize); // ����ռ�

  GetRegionData(vRGN, vSize, vData); // ȡ��RGN����
  // ���浽�ļ�
  with TFileStream.Create(ExePath+ 'temp.rgn', fmCreate) do try
    Write(vData^, vSize);
  finally
    Free;
  end;

  // �ͷ���Դ
  DeleteObject(vRGN);
  FreeMem(vData, vSize);
end;

//----------------------------------------------------------------
procedure LoadRgn(ControlHandle:THandle; aFileName: string);
var
  vData: PRgnData;
  vRGN: HRGN;
begin
     if not FileExists(aFileName) then Exit; // �ļ�������
     // ���ļ�������
     with TFileStream.Create(aFileName, fmOpenRead) do try
          GetMem(vData, Size);
          Read(vData^, Size);
          vRGN := ExtCreateRegion(nil, Size, vData^); // ͨ�����ݴ�������
          SetWindowRgn(ControlHandle, vRGN, True); //����������
          DeleteObject(vRGN);
          FreeMem(vData);
     finally
          Free;
     end;
end;

//----------------------------------------------------------------
procedure DrawAnyShapeControl(ControlHandle:THandle;Canvas:TCanvas;MaskColor:TColor; aw: integer= 0; ah: integer= 0);
  var
  dc:hdc;
  rgn:hrgn;
  x,y,w,h:integer;
  coord:tpoint;
  line:boolean;
  color:tcolor;
begin
      dc:=getwindowdc(controlhandle);
      beginpath(dc);
      if aw= 0 then begin
         w:=canvas.cliprect.Right;
      end else begin
          w:= aw;
      end;
      if ah= 0 then begin
         h:=canvas.ClipRect.Bottom;
      end else begin
          h:= ah;
      end;
      for x:=0   to   w-1   do begin
          line:=false;
          for y:=0   to   h-1   do begin
              color:=canvas.Pixels[x,y];
              if   color<>maskcolor   then begin
                  if   not   line   then begin
                      line:=true;
                      coord.X:=x;
                      coord.Y:=y;
                  end;
              end;
              if   (color=maskcolor)   or   (y=h   -1)   then  begin
                  if   line   then  begin
                      line:=false;
                      movetoex(dc,coord.X,coord.Y,nil);
                      lineto(dc,coord.x,y);
                      lineto(dc,coord.x+1,y);
                      lineto(dc,coord.X+1,coord.Y);
                      closefigure(dc);
                  end;
              end;
          end;
      end;
      endpath(dc);
      rgn:=pathtoregion(dc);
      releasedc(controlhandle,dc);
      //////////////////////
      //SaveRgn(rgn);
      //////////////////////
      if rgn<>0 then begin
          setwindowrgn(controlhandle,rgn,true)   ;
      end;
end;

//----------------------------------------------------------------
function ExePath: string;
begin
     result:= ExtractFilePath(ParamStr(0));
end;

//----------------------------------------------------------------
function GetFullFileName(sPath, sTmpName: string): string;
var                //������Ϊ�϶���ȡ���ļ���
   iColonPos: integer; //':'��λ��
   iRelative: integer; //'..\'��λ��
   sMayName: string;
   i, iLen: integer;
   bNotErr: boolean;
begin
     Result:= '';
     if sTmpName= '' then begin
        result:= sPath;
        exit;
     end;
     if sPath= '' then begin
        result:= sTmpName;
        exit;
     end;
     iColonPos := Pos(':', sTmpName);
     if (iColonPos > 0) or (iColonPos= 0) then begin
        sMayName:= Trim(Copy(sTmpName, iColonPos+ 1, Length(sTmpName)- iColonPos));
        if (Pos('\\', sTmpName)= 0) and (Pos(':\', sTmpName)> 0) then begin
           Result := sTmpName  //����·����ʾ���ļ���
        end else begin                 //���·����ʾ���ļ���
            iRelative := Pos('..\', sMayName);
            bNotErr:= true;
            while bNotErr and (iRelative = 1) do begin
                  Delete(sMayName, iRelative, 3); //ɾ��һ�����·��֮��Ŀ¼'..\'
                  i:= Length(sPath);
                  iLen:= i;
                  if (sPath[i]= '\') then Dec(i);
                  while (i>0) and (sPath[i]<> '\') do Dec(i);
                  if (i> 0) and (i< iLen) then begin
                     Delete(sPath, i, iLen-i+1)    //ɾ��Ŀ¼�����һ����һ��Ŀ¼���������·���ļ�����ȷ�ϲ�
                  end else begin
                      bNotErr := false;
                  end;
                  iRelative := Pos('..\', sMayName);
            end;
            if (bNotErr) then begin
               if sPath[Length(sPath)]<> '\' then begin
                  sPath := sPath + '\';
               end;
               Result  := sPath + sMayName;
            end;
        end;
     end;
end;

//----------------------------------------------------------------
function GetRelaFileName(sPath, sTmpName: string): string;
var
   i, iLastDirPos: integer;
   sLastDir, sRela: string;
begin
     if UpperCase(sPath)= UpperCase(sTmpName) then begin
        result:= '.';
        exit;
     end;
     result:= sTmpName;
     sLastDir:= sPath;
     sRela:= '';
     while pos('\', sLastDir)> 0 do begin
           //showmessage(sLastDir+':'+result+':'+sTmpName);
           iLastDirPos:= Pos(uppercase(sLastDir), uppercase(sTmpName));
           if iLastDirPos> 0 then begin
              // �ҵ���ͬ����Ŀ¼
              result:= sRela+ Copy(sTmpName, Length(sLastDir)+ 1, Length(sTmpName));
              break;
           end else begin
               // ����һ��Ŀ¼
               i:= Length(sLastDir);
               dec(i);
               while (i> 0) and (sLastDir[i]<> '\') do Dec(i);
               if (i> 0) then begin
                  sLastDir:= Copy(sLastDir, 1, i);
                  sRela:= sRela+ '..\';
               end else begin
                   sLastDir:= '';
               end;
           end;
     end;
end;

function GetIconImageListSmall: TImageList;
begin
    result:=TImageList.CreateSize(32,32);
    result.ShareImages:=True;
    result.Handle:=ShGetFileInfo('',0,SHFileInfo, SizeOf(SHFileInfo),
       SHGFI_ICON or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
end;

function GetIconImageList: TImageList;
begin
    result:=TImageList.CreateSize(32,32);
    result.ShareImages:=True;
    result.Handle:=ShGetFileInfo('',0,SHFileInfo, SizeOf(SHFileInfo),SHGFI_LARGEICON
       or SHGFI_ICON or SHGFI_SYSICONINDEX);
    //myImageList.Handle:=ShGetFileInfo('',0,SHFileInfo, SizeOf(SHFileInfo),SHGFI_LARGEICON
    //   or SHGFI_ICON or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
end;

//--------------------------------------------------
function PathWithoutSlash(const Path: string): string;
begin
  if (Length(Path) > 0) and (Path[Length(Path)] = '\') then Result := Copy(Path, 1, Length(Path) - 1)
  else Result := Path;
end;

//--------------------------------------------------
function PathWithSlash(const Path: string): string;
begin
  Result := Path;
  if (Length(Result) > 0) and (Result[Length(Result)] <> '\') then Result := Result + '\';
end;
//--------------------------------------------------
function PathGetTempPath: string;
var
   Buf: array[0..255] of Char;
begin
     GetTempPath(255, @Buf); //����·����
     result:= PathWithSlash(StrPas(@Buf));
end;

function GetFileIconIndex(FileName:string):integer;
var
   FStream:TFileStream;
   str1: string;
   i: integer;
begin
     if FileExists(FileName) then begin
         str1:= FileName;
     end else if DirectoryExists(FileName) then begin
         str1:= FileName;
     end else begin
         if trim(str1)= '' then begin
            str1:= 'a';
         end;
         str1:= PathGetTempPath+ ExtractFileName(FileName);
         try
            try
               FStream:=TFileStream.Create(str1, fmCreate);
               FStream.Write(i,sizeof(integer));
            except
               str1:= '';
            end;
         finally
            FStream.Free;
         end;
     end;
     ShGetFileInfo(Pansichar(str1), 0, SHFileInfo, SizeOf(SHFileInfo),
         SHGFI_LARGEICON or SHGFI_SYSICONINDEX or SHGFI_TYPENAME or SHGFI_SMALLICON);
     Result:=SHFileInfo.iIcon;

end;

function FindPartial(aList: TStringList; aKey: string): integer;
var
   i: integer;
   str1: string;
begin
     result:= -1;
     for i:= 0 to aList.Count- 1 do begin
         str1:= UpperCase(aList[i]);
         if StrLIComp(PAnsiChar(str1), PansiChar(aKey), Length(aKey))= 0 then begin
            result:= i;
            break;
         end;
     end;
end;

function Space(aLength: integer): string;
var
   i: integer;
begin
     result:= '';
     for i:= 0 to aLength do begin
         result:= result+ ' ';
     end;
end;

procedure copyfile;
begin
     windows.CopyFile(PAnsiChar(sourcefilename), PAnsiChar(targetfilename), false);
{ //  ���ٸ���
var
   f1,f2: tfilestream ;
begin
     f1:=Tfilestream.Create(sourcefilename,fmopenread);
     try
        f2:=Tfilestream.Create(targetfilename,fmopenwrite or fmcreate);
        try
           f2.CopyFrom(f1,f1.size);
        finally
           f2.Free;
        end;
     finally
        f1.Free;
     end;
}
end;

// �ڲ��ú���
function IsValidDir(SearchRec: TSearchRec): Boolean;
begin
     if (SearchRec.Attr = faDirectory) and (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        Result := True
     else
         Result := False;
end;

procedure GetFileList(aDesc: string; asl: TStrings);

   procedure GetFiles(aInDesc: string);
   var
      sr: TSearchRec;
   begin
        // ����������Ŀ¼
        if (FindFirst(extractFilePath(aInDesc) + '*.*', faDirectory, sr) = 0) then begin
           if IsValidDir(sr) then begin
              GetFiles(extractFilePath(aInDesc)+ sr.Name+ '\'+ extractFileName(aInDesc));
           end;
        end;
        while (FindNext(sr) = 0) do begin
              if IsValidDir(sr) then begin
                 GetFiles(extractFilePath(aInDesc)+ sr.Name+ '\'+ extractFileName(aInDesc));
              end;
        end;
        // Ȼ�������ļ�
        if (FindFirst(aInDesc, faAnyFile, sr) = 0) then begin
           if (sr.Attr and faDirectory)= 0 then begin
              asl.Add(extractFilePath(aInDesc)+ sr.Name);
           end;
        end;
        while (FindNext(sr) = 0) do begin
              if (sr.Attr and faDirectory)= 0 then begin
                 asl.Add(extractFilePath(aInDesc)+ sr.Name);
              end;
        end;
        FindClose(sr);
   end;

begin
     asl.Clear;
     GetFiles(aDesc);
end;

//-----------------------------------------------------------
function GetFileDate(aFileName: string): TDateTime;
var
   fhandle:Thandle;
begin
     fhandle:=fileopen(aFileName, 0);
     try
        result:= filedatetodatetime(filegetdate(fhandle));
     finally
        fileclose(fhandle);
     end;
end;
//-----------------------------------------------------------
function GetRandomName: string;
var
   yy, mm, dd, hh, min, sec, ms, rr: word;
begin
     decodedate(now, yy, mm, dd);
     decodetime(now, hh, min, sec, ms);
     rr:= random(100);
     result:= inttostr(yy)+ copy(inttostr(100+ mm), 2, 2)+ copy(inttostr(100+ dd), 2, 2)+ '_'+ copy(inttostr(100+ hh), 2, 2)+ copy(inttostr(100+ min), 2, 2)+ copy(inttostr(100+ sec), 2, 2)+ copy(inttostr(100+ ms), 2, 2)+ '_'+ copy(inttostr(100+ rr), 2, 2)
end;

procedure GetDirListNoSub(aDesc: string; asl: TStrings);
var
   sr: TSearchRec;
begin
     asl.Clear;
     // ������Ŀ¼
     if (FindFirst(extractFilePath(aDesc) + '*.*', faDirectory, sr) = 0) then begin
        if IsValidDir(sr) then begin
           asl.Add(extractFilePath(aDesc)+ sr.Name);
        end;
     end;
     while (FindNext(sr) = 0) do begin
           if IsValidDir(sr) then begin
              asl.Add(extractFilePath(aDesc)+ sr.Name);
           end;
     end;
     FindClose(sr);
end;

procedure GetFileListNoSub(aDesc: string; asl: TStrings);
var
   sr: TSearchRec;
begin
     asl.Clear;
     if (FindFirst(extractFilePath(aDesc) + '*.*', faDirectory, sr) = 0) then begin
        if (sr.Attr and faDirectory)= 0 then begin
           asl.Add(extractFilePath(aDesc)+ sr.Name);
        end;
     end;
     while (FindNext(sr) = 0) do begin
           if (sr.Attr and faDirectory)= 0 then begin
              asl.Add(extractFilePath(aDesc)+ sr.Name);
           end;
     end;
     FindClose(sr);
end;

procedure GetFileListNoSub2(aDesc: string; asl: TStrings);
var
   sr: TSearchRec;
begin
     asl.Clear;
     if (FindFirst(aDesc, faDirectory, sr) = 0) then begin
        if (sr.Attr and faDirectory)= 0 then begin
           asl.Add(extractFilePath(aDesc)+ sr.Name);
        end;
     end;
     while (FindNext(sr) = 0) do begin
           if (sr.Attr and faDirectory)= 0 then begin
              asl.Add(extractFilePath(aDesc)+ sr.Name);
           end;
     end;
     FindClose(sr);
end;

function ComponentToString(Component: TComponent): string;
var
  BinStream:TMemoryStream;
  StrStream: TStringStream;
  s: string;
begin
  BinStream := TMemoryStream.Create;
  try
    StrStream := TStringStream.Create(s);
    try
      BinStream.WriteComponent(Component);
      BinStream.Seek(0, soFromBeginning);
      ObjectBinaryToText(BinStream, StrStream);
      StrStream.Seek(0, soFromBeginning);
      Result:= StrStream.DataString;
    finally
      StrStream.Free;

    end;
  finally
    BinStream.Free
  end;
end;

//������
const
     Max_Locker= 20;
var
   Locker: array[0..Max_Locker] of Boolean;

procedure InitLocker;
var
   i: integer;
begin
     for i:=0 to Max_Locker do begin
         Locker[i]:= false;
     end;
end;

function CheckLock(aId: integer): Boolean;
begin
     if Locker[aId] then begin
        result:= true;
     end else begin
         result:= false;
     end;
end;

function Lock(aId: integer): Boolean;
begin
     if Locker[aId] then begin
        result:= true;
     end else begin
         Locker[aId]:= true;
         result:= false;
     end;
end;

procedure UnLock(aId: integer);
begin
     Locker[aId]:= false;
end;

initialization
    initLocker;
    InnerObjList:= TObjectList.Create(true);
finalization
    InnerObjList.Free;
end.
