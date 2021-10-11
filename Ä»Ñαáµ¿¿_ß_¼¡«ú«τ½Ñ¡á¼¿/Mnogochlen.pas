unit Mnogochlen;

interface
uses
  Classes,SysUtils,Dialogs;

//��������������
procedure initPoly(line: integer);
//����� ������ �� �������
Function outPoly(line: integer):string;
//���������
procedure multyPoly;
//�����
procedure SummPoly;
//��������
procedure MinusPoly;
//�������
procedure DivPoly;
// ������ �� edite � ������. �������� �����������.
procedure inputPoly(line: integer; str:string);
//��������� �� x
function multyPolyX(Mnog:string; px:string):string;


implementation

// ������������ ����� i �������
const
  maxpower = 10;
var
  koeff: array[0..maxpower, 1..3] of integer;
//��������������
procedure initPoly(line: integer);
var
  i, n: integer;
begin
  randomize;
  n := random(maxpower div 2);
  for i:=0 to maxpower do
    if i > n then
      koeff[i, line] := 0
    else
      koeff[i, line] := random(20) - 10;
end;

//����� ������ �� �������
Function outPoly(line: integer):string;
var
  i: integer;
  str: string;
begin
  Result:='';
  str := '';
  //�������� � ����� �������
  for i := maxpower downto 0 do
    // ���� � ������� 0
    if (koeff[i, line] <> 0) or (i = 0) then
    begin
      //���� � ������ ��� ���� ������ � ����� ������ 0
      if (str <> '') and (koeff[i, line] > 0) then
        //� ������ ����������� +
        str := str + '+';
      //� ������ ����������� �����
      str := str + IntToStr(koeff[i, line]);
      // ���� �� ������ �������
      if i > 0 then
        str := str + '*X';
      //���� ���� ������ 1 ������� �� �����
      if i > 1 then
        str := str + '^'+IntToStr(i);
    end;
    // ������� ������ � ��������� ������� ��� ������������ ������
    Result:=str;
end;

// ������ �� edite � ������. �������� �����������.
procedure inputPoly(line: integer; str:string);
var
  i,x,k: integer;
  s:string;
begin
  //�������� ������ ����� �������
  for i:=0 to maxpower do
    koeff[i, line] := 0;

  // �������� �� ������ ������
  k:=0;
  x:=0;
  s:='';

  //�� 1 �� ����� ������
  for i := 1 to Length(str) do
    //���� ������ � ������
    case str[i] of
     '0'..'9':
        begin
          //���� ��� �� ���� � ���������� ����� � ������
          if x=0
            then s:=s+Str[i];

          // ���� ��� x � ^ �����
          if (x=1) and (k=1) then
            begin
              //���������� � ������ S � ������ ������� = �������
              koeff[strtoint(str[i]), line]:= strtoint(s);
              s:='';
              x:=0;
              k:=0;
            end;

         // ���� ����� ������ ���������� �����
         if (i=Length(str))
           then koeff[0, line]:= strtoint(s);
        end;
     'a'..'z','A'..'Z':
       begin
         //��������� x
         x:=1;
         // ���� ������ x ��� -x ��������� 1
         if (s='') or (s='-')
           then s:=s+'1';

         // ���� x ��������� � ������
         if i=Length(str)
           then
             begin
               koeff[1, line]:= strtoint(s);
               s:='';
               x:=0;
               k:=0;
             end;
       end;
     '^':
       begin
         //��������� ^
         k:=1;
       end;
     '*':
       begin
        //�� ����, �� �� ��� �� ���������
       end;
     '+','-':
       begin
         // ���� ��� x �� ������ ^
         if (x=1) and (k=0)
           then
             begin
               koeff[1, line]:= strtoint(s);
               s:='';
               x:=0;
               k:=0;
             end;

         // ���� ����� ���������� � ������
         if (str[i]='-')
           then s:=s+Str[i];
       end;
    end;
end;

//���������
procedure multyPoly;
var
  i, k: integer;
begin
  // �������� 3 ������� �� ������, ���� � ��� ��� ���� ������
  for i:=0 to maxpower do
    koeff[i, 3] := 0;
  // ������ ���� ���������� �������� 1 ������� � 3 ������� ��� ������� ������������
  for i:=0 to maxpower do
    for k:=0 to maxpower do
      if i+k < maxpower then
        koeff[i+k, 3] := koeff[i+k, 3] + koeff[i, 1]*koeff[k, 2];
end;

//��������� �� x
function multyPolyX(Mnog:string; px:string):string;
begin
  // ��������� ������ x ��� ���
  if (px<>'') and (px<>' ')
  // �������� ��� x ��� ����� �������� �� �����
    then Result:=StringReplace(Mnog, 'x', px ,[rfReplaceAll, rfIgnoreCase])
      else showmessage('"X" �� ������');
end;

//�����
procedure SummPoly;
var
  i: integer;
begin
  for i:=0 to maxpower do
    koeff[i, 3] := 0;
  for i:=0 to maxpower do
      if i < maxpower then
      // ���������� 1 � ����� �������, ��������� ���������� � 3
        koeff[i, 3] := koeff[i, 1]+koeff[i, 2];
end;

//��������
procedure MinusPoly;
var
  i: integer;
begin
  for i:=0 to maxpower do
    koeff[i, 3] := 0;
  for i:=0 to maxpower do
      if i < maxpower then
        koeff[i, 3] := koeff[i, 1]-koeff[i, 2];
end;

//�������
procedure DivPoly;
var
  i: integer;
begin
  for i:=0 to maxpower do
    koeff[i, 3] := 0;
  for i:=0 to maxpower do
      if i < maxpower then
        begin
          if koeff[i, 2]<> 0
            then koeff[i, 3] := koeff[i, 1] div koeff[i, 2]
              else koeff[i, 3] := koeff[i, 1];
        end;
end;


end.