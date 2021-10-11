unit Mnogochlen;

interface
uses
  Classes,SysUtils,Dialogs;

//јвтозаполнение
procedure initPoly(line: integer);
//¬ывод данных из массива
Function outPoly(line: integer):string;
//умножение
procedure multyPoly;
//сумма
procedure SummPoly;
//разность
procedure MinusPoly;
//деление
procedure DivPoly;
// запись из edite в массив. ѕроходим посимвольно.
procedure inputPoly(line: integer; str:string);
//умножение на x
function multyPolyX(Mnog:string; px:string):string;


implementation

// максимальна€ длина i массива
const
  maxpower = 10;
var
  koeff: array[0..maxpower, 1..3] of integer;
//јвтозаполнение
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

//¬ывод данных из массива
Function outPoly(line: integer):string;
var
  i: integer;
  str: string;
begin
  Result:='';
  str := '';
  //начинаем с конца массива
  for i := maxpower downto 0 do
    // ≈сли в массиве 0
    if (koeff[i, line] <> 0) or (i = 0) then
    begin
      //если в строке уже есть запись и число больше 0
      if (str <> '') and (koeff[i, line] > 0) then
        //к строке подставл€ем +
        str := str + '+';
      //к строке подставл€ем число
      str := str + IntToStr(koeff[i, line]);
      // если не начало массива
      if i > 0 then
        str := str + '*X';
      //если есть хот€бы 1 позици€ до конца
      if i > 1 then
        str := str + '^'+IntToStr(i);
    end;
    // передем строку в результат функции дл€ последующего вывода
    Result:=str;
end;

// запись из edite в массив. ѕроходим посимвольно.
procedure inputPoly(line: integer; str:string);
var
  i,x,k: integer;
  s:string;
begin
  //обнул€ем массив перед записью
  for i:=0 to maxpower do
    koeff[i, line] := 0;

  // обнул€ем на вс€кий случай
  k:=0;
  x:=0;
  s:='';

  //от 1 до длины строки
  for i := 1 to Length(str) do
    //если символ в строке
    case str[i] of
     '0'..'9':
        begin
          //если еще не было ’ записываем число в строку
          if x=0
            then s:=s+Str[i];

          // ≈сли был x и ^ тогда
          if (x=1) and (k=1) then
            begin
              //«аписываем в массив S в строку номером = степени
              koeff[strtoint(str[i]), line]:= strtoint(s);
              s:='';
              x:=0;
              k:=0;
            end;

         // ≈сли конец строки записываем число
         if (i=Length(str))
           then koeff[0, line]:= strtoint(s);
        end;
     'a'..'z','A'..'Z':
       begin
         //встретили x
         x:=1;
         // если просто x или -x добавл€ем 1
         if (s='') or (s='-')
           then s:=s+'1';

         // ≈сли x последний в строке
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
         //¬стретили ^
         k:=1;
       end;
     '*':
       begin
        //он есть, но мы его не учитываем
       end;
     '+','-':
       begin
         // ≈сли был x но небыло ^
         if (x=1) and (k=0)
           then
             begin
               koeff[1, line]:= strtoint(s);
               s:='';
               x:=0;
               k:=0;
             end;

         // ≈сли минус записываем в строку
         if (str[i]='-')
           then s:=s+Str[i];
       end;
    end;
end;

//умножение
procedure multyPoly;
var
  i, k: integer;
begin
  // ќбнул€ем 3 столбец на случай, если в нем уже есть запись
  for i:=0 to maxpower do
    koeff[i, 3] := 0;
  // первый цикл записывает значение 1 столбец в 3 столбец при повторе перемножение
  for i:=0 to maxpower do
    for k:=0 to maxpower do
      if i+k < maxpower then
        koeff[i+k, 3] := koeff[i+k, 3] + koeff[i, 1]*koeff[k, 2];
end;

//умножение на x
function multyPolyX(Mnog:string; px:string):string;
begin
  // провер€ем введен x или нет
  if (px<>'') and (px<>' ')
  // замен€ем все x без учета регистра на число
    then Result:=StringReplace(Mnog, 'x', px ,[rfReplaceAll, rfIgnoreCase])
      else showmessage('"X" не введен');
end;

//сумма
procedure SummPoly;
var
  i: integer;
begin
  for i:=0 to maxpower do
    koeff[i, 3] := 0;
  for i:=0 to maxpower do
      if i < maxpower then
      // складываем 1 и ворой столбец, результат записываем в 3
        koeff[i, 3] := koeff[i, 1]+koeff[i, 2];
end;

//разность
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

//деление
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