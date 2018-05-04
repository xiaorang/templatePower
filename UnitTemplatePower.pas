{
另外一套模板替换机制，采用外部事件
支持循环嵌套
支持一层IF分支
}
unit UnitTemplatePower;

interface
uses
    UnitTools, Classes, Contnrs;
type
    TFillMethod= function(aTag, aBlock, aLoopId: string): string of object;

function LoadTemplate(aFileName: string; aDealFunc: TStringFunc): string;
function FillTemplate(aText: string; aDealFunc: TStringFunc): string;
function FillTemplateNew(aText: string; aDealFunc: TFillMethod): string;
function FillTigTag(aText: string; aSl: TStrings): string;
function CallTemplateToFile(aTmplName, aDstName: string; aDealFunc: TStringFunc): string; overload;
function CallTemplateToFile(aTmplName, aDstName: string; aDealFunc: TFillMethod): string; overload;
// 扩展支持，直接从INI中读取数据
function CallTemplateToFile(aTmplName, aDstName, aIniData: string): string; overload;
function CallTemplateToFileUTF8(aTmplName, aDstName, aIniData: string): string; overload;
// 扩展，支持多个ini文件
function CallTemplateToFileManyIni(aTmplName, aDstName: string; aIniList: Tstrings): string;
function CallTemplateToFileManyIniUTF8(aTmplName, aDstName: string; aIniList: Tstrings): string;
// 扩展支持StringList
function CallTemplateToFile(aTmplName, aDstName: string; aSl: TStrings): string; overload;

implementation
uses
    SysUtils, StrUtils, IniFiles;

const
     csHead = '%';
     cnLenHead = Length(csHead);
     cTail = '%';
     cnLenTail = Length(cTail);

var
   // 模板文件本身所在的路径
   templatePath: string;

function CallTemplateToFile(aTmplName, aDstName: string; aDealFunc: TStringFunc): string;
begin
     templatePath:= extractFilePath(aTmplName);
     result:= LoadTemplate(aTmplName, aDealFunc);
     SaveTextToFile(result, aDstName);
end;

function CallTemplateToFile(aTmplName, aDstName: string; aDealFunc: TFillMethod): string; overload;
begin
     templatePath:= extractFilePath(aTmplName);
     SaveTextToFile(FillTemplateNew(getTextFromFile(aTmplName), aDealFunc), aDstName);
end;

type
    TIniData= class
       ini: TIniFile;
       relaPath: string;
       function DataFromIni(aTag, aBlock, aLoopId: string): string;
    end;
    function TIniData.DataFromIni(aTag, aBlock, aLoopId: string): string;
    var
       str1: string;
    begin
         if aBlock= '' then begin
            aBlock:= 'sys';
         end;
         str1:= ini.ReadString(aBlock, aTag, '');
         if (str1<> '') and (str1[1]='#') then begin
            result:= trim(getTextFromFile(getFullFileName(relaPath, copy(str1, 2, length(str1)))));
         end else begin
             result:= str1;
         end;
    end;

function CallTemplateToText(aTmplText, aIniData: string): string;
var
   IniData1: TIniData;
begin
     if not FileExists(aIniData) then begin
        raise exception.Create('文件未找到：'+ aIniData);
     end;
     IniData1:= TIniData.Create;
     IniData1.ini:= TIniFile.Create(aIniData);
     IniData1.relaPath:= extractFilePath(aIniData);
     result:= FillTemplateNew(aTmplText, IniData1.DataFromIni);
     iniData1.Free;
end;

function CallTemplateToFileUTF8(aTmplName, aDstName, aIniData: string): string; overload;
begin
     templatePath:= extractFilePath(aTmplName);
     SaveTextToUTF8File(CallTemplateToText(getTextUTF8File(aTmplName), aIniData), aDstName);
end;

function CallTemplateToFile(aTmplName, aDstName, aIniData: string): string;
begin
     templatePath:= extractFilePath(aTmplName);
     SaveTextToFile(CallTemplateToText(getTextFromFile(aTmplName), aIniData), aDstName);
end;

function FindParamName(aText: string; var ParamName: string; offset: integer = 1): integer;
var
  nPos, nLenText, n: integer;
  p: Pchar;
  Found: boolean;
begin
  result := 0;
  ParamName := '';
  nLenText := Length(aText);

  Found := false;
  nPos := PosEx(csHead, aText, offset);

  while (nPos > 0) and (nPos < nLenText) do begin

    p := @aText[nPos + cnLenHead];
    n := 0;

    repeat

      if p^ = cTail then // 检查右匹配框
      begin
        Found := true;
        result := nPos;
        ParamName := Copy(aText, nPos + cnLenTail, n);
      end
      else if p^ in [' ', #9, #10, #13] then // 检测空白字符
      begin
        offset := nPos + cnLenHead + n;
        Break;
      end;

      inc(p);
      inc(n);

    until Found;

    if Found then Break;

    nPos := PosEx(csHead, aText, offset);

  end;

end;

function BackRemove(var APos: integer; aText, AName: string): string;
var
   i, a, b: Integer;
   str1: string;
begin
     i:= aPos- 1;
     a:= length(AName);
     b:= a;
     while i> 0 do begin
           str1:= copy(aText, i, a);
           if SameText(str1, AName) then begin
              Delete(aText, i, b);
              aPos:= aPos- b;
              Break;
           end else if trim(str1)= '' then begin
               i:= i- 1;
               b:= b+ 1;
           end else begin
               Break;
           end;
     end;
     result:= aText;
end;

function ReplaceParam(APos: integer; aText, AName, AValue: string; aRecur: boolean): string;
var
  str1, sB, sE: string;
  nLenName: integer;
  nLenText: integer;
begin
     str1:= csHead+ aName+ cTail;
     aPos:= pos(str1, aText);
     while (aPos> 0) do begin
         nLenName := Length(AName);
         nLenText := Length(aText);
         sB := Copy(aText, 1, APos - 1);
         sE := Copy(aText, APos + nLenName + cnLenHead + 1, nLenText);
         aText:= sB + AValue + sE;
         aPos:= pos(str1, aText);
         if not aRecur then begin
            aPos:= 0;
         end;
     end;
     result := aText;
end;

function LoadTemplate(aFileName: string; aDealFunc: TStringFunc): string;
var
   sText: string;
begin
     sText:= GetTextFromFile(aFileName);
     result:= FillTemplate(sText, aDealFunc);
end;

function FillTemplate(aText: string; aDealFunc: TStringFunc): string;
var
   StrSelf, sParamName: string;
   str1, strTagMark, sRealParm: string;
   nPos, nMove: integer;
   strLoop, nextMark: string;
   a, p1, p2: integer;
   TagIsLoop: Boolean;
begin
     StrSelf:= aText;
     nPos := FindParamName(aText, sParamName, 1);
     while nPos > 0 do begin
           a:= 1;
           strTagMark:= readBetween(sParamName, '(', ')', a);
           sRealParm:= filterBranck(sParamName);
           if SameText(strTagMark, 'Loop') then begin
              p1:= nPos+ Length(sParamName)+ 2;
              nextMark:= UpperCase('%(ENDLOOP)'+ sRealParm+ '%');
              p2:= posEx(nextMark, UpperCase(aText), p1);
              if p2> 0 then begin
                 strLoop:= Copy(aText, p1, p2+ Length(nextMark)- p1);
              end else begin
                  // 不匹配的Loop，形同虚设
                  strLoop:= '';
              end;
              TagIsLoop:= true;
           end else if SameText(strTagMark, 'ENDLOOP') then begin
               sRealParm:= 'Next_'+ filterBranck(sParamName);
               TagIsLoop:= true;
           end else begin
               TagIsLoop:= false;
               sRealParm:= sParamName
           end;
           if assigned(aDealFunc) then begin
              str1:= aDealFunc(sRealParm);
           end;
           if str1= '%' then begin
              if TagIsLoop then begin
                 str1:= strLoop;
              end else begin
                  str1:= StrSelf;
              end;
              nMove:= 0;
           end else begin
               nMove:= Length(Str1);
           end;
           aText:= ReplaceParam(nPos- 1, aText, sParamName, str1, false);
           inc(nPos, nMove);
           nPos := FindParamName(aText, sParamName, nPos);
     end;
     result:= aText;
end;

function FindTigTag(aText: string; var ParamName: string; offset: integer = 1): integer;
begin
end;

var
   InnerStringList: TStrings;
function GetValueFromStringList(aName: string): string;
begin
     result:= InnerStringList.Values[aName];
end;

function FillTigTag(aText: string; aSl: TStrings): string;
begin
     InnerStringList:= aSl;
     result:= FillTemplate(aText, GetValueFromStringList);
end;

function CallTemplateToFile(aTmplName, aDstName: string; aSl: TStrings): string; overload;
begin
     templatePath:= extractFilePath(aTmplName);
     InnerStringList:= aSl;
     result:= LoadTemplate(aTmplName, GetValueFromStringList);
     SaveTextToFile(result, aDstName);
end;


type
    TLoopTag= class
        BlockTag: string;
        Id: integer;
        preBlock: string;
        preId: string;
        strLoop: string;
    end;
    TIfTag= class
        // 选中的分支的内容
        strCase: string;
        // 全部的总内容
        strIfAll: string;
    end;

function FillTemplateNew(aText: string; aDealFunc: TFillMethod): string;
  function getTag(aFrom: string; aPos: integer; aFunc, aTag: string; var aFound: boolean): string;
  var
     mark1, mark2: string;
     p1, p2: integer;
  begin
       mark1:= UpperCase('%('+ aFunc+ ')'+ aTag+ '%');
       p1:= posEx(mark1, UpperCase(aFrom), aPos);
       p1:= p1+ length(mark1);
       mark2:= UpperCase('%(End'+ aFunc+ ')'+ aTag+ '%');
       p2:= posEx(mark2, UpperCase(aFrom), aPos);
       if (p2> p1) and (p1> 0) then begin
          result:= Copy(aFrom, p1, p2- p1);
          aFound:= true;
       end else begin
           result:= '';
           aFound:= false;
       end;
  end;
  function getRepeatTag(aFrom: string; aPos: integer; aFunc, aTag: string): string;
  var
     mark1, mark2: string;
     p1, p2: integer;
  begin
       mark1:= UpperCase('%('+ aFunc+ ')'+ aTag+ '%');
       p1:= posEx(mark1, UpperCase(aFrom), aPos);
       p1:= p1+ length(mark1);
       mark2:= UpperCase('%(End'+ aFunc+ ')'+ aTag+ '%');
       p2:= posEx(mark2, UpperCase(aFrom), aPos);
       if (p2> p1) and (p1> 0) then begin
          result:= Copy(aFrom, p1, p2- p1+ length(mark2));
       end else begin
           result:= '';
       end;
  end;
var
   StrSelf, sParamName: string;
   str1, str2, strTagMark, sRealParm: string;
   nPos, nMove: integer;
   nextMark: string;
   a, p1, p2: integer;
   TagIsLoop, InnerTag, noDeal, ifTag: Boolean;
   cutTag, InnerValueTag: Boolean;
   loopStack, repeatStack: TStack;
   tag1, tag2, repeatTag, foreachTag: TLoopTag;
   tagIF1: TIfTag;
   sBlock, sId: string;
   sTemp: string;
   InnerValue: string;
   sl: TStringList;
   sFound: boolean;
   //ConstList: TStringList;
   VarList: TStringList;
begin
     StrSelf:= aText;
     nPos := FindParamName(aText, sParamName, 1);
     loopStack:= TStack.Create;
     repeatStack:= TStack.Create;
     //ConstList:= TStringList.Create;
     VarList:= TStringList.Create;
     tagIF1:= TIfTag.Create;
     tag1:= nil;
     while nPos > 0 do begin
           a:= 1;
           strTagMark:= readBetween(sParamName, '(', ')', a);
           sRealParm:= filterBranck(sParamName);
           InnerTag:= false;
           TagIsLoop:= false;
           noDeal:= false;
           ifTag:= false;
           cutTag:= false;
           InnerValueTag:= false;
           if SameText(strTagMark, 'Loop') then begin
              if sameText(sRealParm, 'AddBtn') then begin
                 sRealParm:= 'ExtBtn';
              end;
              if Assigned(tag1) then begin
                 loopStack.Push(tag1);
                 tag2:= tag1;
                 tag1:= TLoopTag.Create;
                 if tag2.preBlock<> '' then begin
                    tag1.preBlock:= tag2.preBlock+ ','+ tag2.BlockTag;
                 end else begin
                     tag1.preBlock:= tag2.BlockTag;
                 end;
                 if tag2.preId<> '' then begin
                    tag1.preId:= tag2.preId+ ','+ IntToStr(tag2.Id);
                 end else begin
                     tag1.preId:= IntToStr(tag2.Id);
                 end;
              end else begin
                 tag1:= TLoopTag.Create;
                 tag1.preBlock:= '';
                 tag1.preId:= '';
              end;
              tag1.Id:= 0;
              tag1.BlockTag:= sRealParm;
              //
              p1:= nPos+ Length(sParamName)+ 2;
              nextMark:= UpperCase('%(ENDLOOP)'+ sRealParm+ '%');
              p2:= posEx(nextMark, UpperCase(aText), p1);
              if p2> 0 then begin
                 tag1.strLoop:= Copy(aText, p1, p2+ Length(nextMark)- p1);
              end else begin
                  // 不匹配的Loop，形同虚设
                  tag1.strLoop:= '';
              end;
           end else if SameText(strTagMark, 'ENDLOOP') then begin
               sRealParm:= 'Next_'+ filterBranck(sParamName);
               TagIsLoop:= true;
           end else if SameText(strTagMark, 'Repeat') then begin
               // repeat 不支持同数量的嵌套
               repeatTag:= TLoopTag.Create;
               repeatTag.strLoop:= getRepeatTag(aText, nPos, 'repeat', sRealParm);
               repeatTag.Id:= strtoint(sRealParm);
               repeatTag.preId:= sRealParm;
               InnerValue:= '';
               InnerTag:= true;
               InnerValueTag:= true;
           end else if SameText(strTagMark, 'LoopId') then begin
               if assigned(repeatTag) then begin
                  InnerValue:= inttostr(strtoint(repeatTag.preId)- repeatTag.Id+ 1);
               end else begin
                   InnerValue:= '';
               end;
               InnerTag:= true;
               InnerValueTag:= true;
           end else if SameText(strTagMark, 'EndRepeat') then begin
               dec(repeatTag.Id);
               if repeatTag.Id> 0 then begin
                  InnerValue:= repeatTag.strLoop;
               end else begin
                   InnerValue:= '';
                   freeAndNil(repeatTag);
               end;
               InnerTag:= true;
               InnerValueTag:= true;
           end else if SameText(strTagMark, 'ForEachFile') then begin
               // repeat 不支持同数量的嵌套
               foreachTag:= TLoopTag.Create;
               foreachTag.strLoop:= getRepeatTag(aText, nPos, 'ForEachFile', sRealParm);
               foreachTag.Id:= 0;
               sl:= TStringList.Create;
               GetFileList(getFullFileName(templatePath, sRealParm), sl);
               foreachTag.preId:= sl.CommaText;
               foreachTag.preBlock:= inttostr(sl.Count);
               sl.Free;
               InnerValue:= '';
               InnerTag:= true;
               InnerValueTag:= true;
           end else if SameText(strTagMark, 'LoopFileName') then begin
               if assigned(foreachTag) then begin
                  InnerValue:= ChangeFileExt(extractFileName(getItemFromList(foreachTag.preId, foreachTag.Id)), '');
               end else begin
                   InnerValue:= '';
               end;
               InnerTag:= true;
               InnerValueTag:= true;
           end else if SameText(strTagMark, 'EndForEachFile') then begin
               inc(foreachTag.Id);
               if foreachTag.Id< strtoint(foreachTag.preBlock) then begin
                  InnerValue:= foreachTag.strLoop;
               end else begin
                   InnerValue:= '';
                   freeAndNil(foreachTag);
               end;
               InnerTag:= true;
               InnerValueTag:= true;
           end else if SameText(strTagMark, 'BACK') then begin
               InnerTag:= true;
               InnerValueTag:= true;
               InnerValue:= '';
           end else if SameText(strTagMark, 'Call') then begin
               InnerTag:= true;
           end else if SameText(strTagMark, 'Cut') then begin
               InnerTag:= true;
               cutTag:= true;
           end else if SameText(strTagMark, 'Var') then begin
               p1:= pos('=', sRealParm);
               if p1> 0 then begin
                  str1:= copy(sRealParm, 1, p1- 1);
                  str2:= copy(sRealParm, p1+ 1, length(sRealParm));
                  if VarList.IndexOfName(str2)>= 0 then begin
                     str2:= VarList.Values[str2];
                  end;
               end else begin
                   str1:= sRealParm;
                   // 变量暂时只取根目录变量？
                   str2:= aDealFunc(sRealParm, '', '');
               end;
               if VarList.IndexOfName(str1)< 0 then begin
                  VarList.Add(str1+ '='+ str2);
               end else begin
                   VarList.Values[str1]:= str2;
               end;
               InnerTag:= true;
               InnerValueTag:= true;
               InnerValue:= '';
           end else if SameText(strTagMark, 'IF') then begin
               // 简化的，可以用switch实现
               raise exception.Create('not support "if" yet');
           end else if SameText(strTagMark, 'SWITCH') then begin
               InnerTag:= false;
               ifTag:= true;
               p1:= nPos+ Length(sParamName)+ 2;
               nextMark:= UpperCase('%(END'+ strTagMark+ ')'+ sRealParm+ '%');
               p2:= posEx(nextMark, UpperCase(aText), p1);
               if p2> 0 then begin
                  TagIf1.strIfAll:= Copy(aText, p1, p2+ Length(nextMark)- p1);
               end else begin
                   // 不匹配的Loop，形同虚设
                   tagif1.strIfAll:= '';
               end;
           end else begin
               sRealParm:= sParamName
           end;
           if not InnerTag then begin
              if assigned(aDealFunc) then begin
                 if Assigned(tag1) then begin
                    if tag1.preBlock<> '' then begin
                       sBlock:= tag1.preBlock+ ','+ tag1.BlockTag;
                    end else begin
                        sBlock:= tag1.BlockTag;
                    end;
                    if tag1.preId<> '' then begin
                       sId:= tag1.preId+ ','+ IntToStr(tag1.Id);
                    end else begin
                        sId:= IntToStr(tag1.Id);
                    end;
                    if SameText(strTagMark, 'Loop') then begin
                       sBlock:= tag1.preBlock;
                       //sId:= sId;
                    end;
                    if SameText(strTagMark, 'EndLoop') then begin
                       sBlock:= tag1.preBlock;
                       //sId:= IntToStr(tag1.Id);
                    end;
                 end else begin
                     sBlock:= '';
                     sId:= '';
                 end;
                 // 只有未定义为变量的，才去系统中取
                 if VarList.IndexOfName(sRealParm)>= 0 then begin
                    str1:= VarList.Values[sRealParm];
                 end else begin
                     str1:= aDealFunc(sRealParm, sBlock, sId);
                 end;
              end;
           end else begin
               if SameText(strTagMark, 'Back') then begin
                  // 首先清除此TAG
                  str1:= '';
               end else if SameText(strTagMark, 'Call') then begin
                   str1:= getTextFromFile(getFullFileName(templatePath, sRealParm));
               end else if InnerValueTag then begin
                   str1:= InnerValue;
               end;
           end;
           if str1= '%' then begin
              // 下一循环标记
              if TagIsLoop then begin
                 str1:= tag1.strLoop;
                 tag1.Id:= tag1.Id+ 1;
              end else begin
                  str1:= StrSelf;
              end;
              nMove:= 0;
           end else if str1= '#' then begin
               // 清除循环体标记
               if Assigned(tag1) then begin
                  Delete(aText, nPos, Length(tag1.strLoop)+ Length(sParamName)+ 2);
                  noDeal:= true;
                  nMove:= 0;
                  if loopStack.AtLeast(1) then begin
                     tag1.Free;
                     tag1:= loopStack.Pop;
                  end else begin
                      freeAndNil(tag1);
                  end;
               end;
           end else if ifTag then begin
               tagIf1.strCase:= getTag(tagIf1.strIfAll, 1, 'CASE', str1, sFound);
               if not sFound then begin
                  tagIf1.strCase:= getTag(tagIf1.strIfAll, 1, 'CASE', 'else', sFound);
               end;
               Delete(aText, nPos, Length(tagIf1.strIfAll)+ Length(sParamName)+ 2);
               nMove:= 0;
               Insert(tagIf1.strCase, aText, nPos);
               noDeal:= true;
           end else if InnerValueTag then begin
               nMove:= 0;
           end else if cutTag then begin
               sTemp:= getTag(aText, nPos, 'CUT', sRealParm, sFound);
               Delete(aText, nPos, Length(sTemp));
               nMove:= 0;
               noDeal:= true;
           end else begin
               nMove:= Length(Str1);
               if TagIsLoop then begin
                  if loopStack.AtLeast(1) then begin
                     tag1.Free;
                     tag1:= loopStack.Pop;
                  end else begin
                      freeAndNil(tag1);
                  end;
               end;
           end;
           if not noDeal then begin
              aText:= ReplaceParam(nPos- 1, aText, sParamName, str1, false);
           end;
           if InnerTag then begin
              if SameText(strTagMark, 'Back') then begin
                 // 处理回退，删除指定单个字符
                 aText:= BackRemove(nPos, aText, sRealParm);
              end else if SameText(strTagMark, 'Call') then begin
                  nMove:= 0;
              end;
           end;
           inc(nPos, nMove);
           nPos := FindParamName(aText, sParamName, nPos);
     end;
     result:= aText;
     loopStack.Free;
     tagIf1.Free;
     repeatStack.Free;
     //ConstList.Free;
     VarList.Free;
end;

type
    TMultyIniData= class
       iniList: TObjectList;
       relaPath: string;
       function DataFromIni(aTag, aBlock, aLoopId: string): string;
       constructor create;
       destructor Destroy; override;
    end;
    constructor TMultyIniData.create;
    begin
         iniList:= TObjectList.Create(true);
    end;

    function TMultyIniData.DataFromIni(aTag, aBlock, aLoopId: string): string;
    var
       str1: string;
       ini: TInifile;
       i, j: integer;
       rela: string;
       sec1, tag1: string;
       secList: TStringArray;
       found: boolean;
    begin
         if aBlock= '' then begin
            sec1:= 'sys';
         end else begin
             sec1:= '';
         end;
         str1:= '';
         rela:= '';
         secList:= makeList('');
         while aBlock<> '' do begin
            if sec1= '' then begin
               sec1:= sec1+ getFirst(aBlock)+ '_'+ getFirst(aLoopId);
            end else begin
                sec1:= sec1+ '_'+ getFirst(aBlock)+ '_'+ getFirst(aLoopId);
            end;
            //secList:= concatTable(secList, makeList(sec1));
            aBlock:= getTail(aBlock);
            aLoopId:= getTail(aLoopId);
         end;
         if (aLoopId<> '') and sameText(copy(aTag, 1, 5), 'next_') then begin
            Tag1:= aTag+ '_'+ getFirst(aLoopId);
         end else begin
             tag1:= aTag;
         end;
         // 看是否在tag中指定了sec
         j:= pos('.', aTag);
         if j> 0 then begin
            sec1:= copy(aTag, 1, j- 1);
            tag1:= copy(aTag, j+ 1, length(aTag));
         end;
         found:= false;
         for i:= 0 to iniList.Count- 1 do begin
             ini:= TIniFile(iniList[i]);
             str1:= ini.ReadString(sec1, Tag1, '');
             if str1<> '' then begin
                // 读到了数据
                rela:= extractFilePath(ini.FileName);
                found:= true;
                break;

             end;
         end;
         if (str1<> '') and (str1<> '#') and (str1[1]='#') then begin
            result:= trim(getTextFromFile(getFullFileName(rela, copy(str1, 2, length(str1)))));
         end else begin
             result:= str1;
         end;
    end;
    destructor TMultyIniData.Destroy;
    begin
         iniList.Free;
         inherited;
    end;


var
   tempReader: TMultyIniData;
function getMultyIniEntry(aIniList: TStrings): TFillMethod;
var
   i: integer;
   ini: TIniFile;
   str1: string;
begin
     tempReader:= TMultyIniData.Create;
     for i:= 0 to aIniList.Count- 1 do begin
         str1:= aIniList[i];
         if fileExists(str1) then begin
            ini:= TIniFile.Create(str1);
            tempReader.iniList.Add(ini);
         end;
     end;
     result:= tempReader.DataFromIni;
end;

function CallTemplateToFileManyIni(aTmplName, aDstName: string; aIniList: Tstrings): string;
begin
     templatePath:= extractFilePath(aTmplName);
     result:= FillTemplateNew(getTextFromFile(aTmplName), getMultyIniEntry(aIniList));
     saveTextToFile(result, aDstName);
     tempReader.Free;
end;

function CallTemplateToFileManyIniUTF8(aTmplName, aDstName: string; aIniList: Tstrings): string;
begin
     templatePath:= extractFilePath(aTmplName);
     result:= FillTemplateNew(getTextUTF8File(aTmplName), getMultyIniEntry(aIniList));
     saveTextToUTF8File(result, aDstName);
     tempReader.Free;
end;

end.
