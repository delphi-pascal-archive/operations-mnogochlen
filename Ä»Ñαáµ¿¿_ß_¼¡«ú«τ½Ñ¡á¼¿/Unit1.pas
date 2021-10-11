unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    Edit3: TEdit;
    Label1: TLabel;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  Mnogochlen;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  //Записываем в первый столбец массива
  initPoly(1);
  //Выводим первый столбец массива
  Edit1.Text:=outPoly(1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  initPoly(2);
  Edit2.Text:=outPoly(2);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if (Edit1.text<>'')and (Edit1.text<>'') then
    begin
      //Записываем в первый столбец массива из первого едита
      inputPoly(1, Edit1.Text);
      //Записываем во второй столбец массива из второго едита
      inputPoly(2, Edit2.Text);
      //Умножаем(результат записываеися в 3 столбец массива)
      multyPoly;
      // Выводим третий столбец массива
      Memo1.Lines.Add('Полином = '+outPoly(3));
    end
  else ShowMessage('Не все поля заполненны');

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if (Edit1.text<>'')and (Edit1.text<>'') then
    begin
      inputPoly(1, Edit1.Text);
      inputPoly(2, Edit2.Text);
      summPoly;
      Memo1.Lines.Add('Полином = '+outPoly(3));
    end
  else ShowMessage('Не все поля заполненны');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if (Edit1.text<>'')and (Edit1.text<>'') then
    begin
      inputPoly(1, Edit1.Text);
      inputPoly(2, Edit2.Text);
      MinusPoly;
      Memo1.Lines.Add('Полином = '+outPoly(3));
    end
  else ShowMessage('Не все поля заполненны');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if (Edit1.text<>'')and (Edit1.text<>'') then
    begin
      inputPoly(1, Edit1.Text);
      inputPoly(2, Edit2.Text);
      DivPoly;
      Memo1.Lines.Add('Полином = '+outPoly(3));
    end
  else ShowMessage('Не все поля заполненны');
end;

procedure TForm1.Button7Click(Sender: TObject);
var
 str:string;
begin
  inputPoly(1, Edit1.Text);
  str:=multyPolyX(Edit1.Text,Edit3.Text);
  Memo1.Lines.Add('Подставили x = '+str);
end;

end.
