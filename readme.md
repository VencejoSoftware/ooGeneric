[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Build Status](https://travis-ci.org/VencejoSoftware/ooGeneric.svg?branch=master)](https://travis-ci.org/VencejoSoftware/ooGeneric)

# ooGeneric - Object pascal generic library
Code to manipulate [generics](https://en.wikipedia.org/wiki/Generic_programming) list and enumerators, also with nullable data type container

### Documentation
If not exists folder "code-documentation" then run the batch "build_doc". The main entry is ./doc/index.html

### Example of a list
```pascal
uses
  ooList
...
var
  List: IList<String>;
begin
  List := TListGeneric<String>.New;
  List.Add('Line1');
  List.Add('Line2');
  List.Add('Line3');
  List.Add('Line4');
  List.Add('Line5');
end;
```

### Example of a filtrable list
The TFiltrableList allow to reduce the items of a list with a criteria condition, for example:

```pascal
uses
  ooFiltrableList
...

function Condition(const Value: Byte): Boolean;
begin
  Result := (Value = 40);
end;

var
  FiltrableList: IFiltrableList<Byte>;
  Item: Byte;
begin
  FiltrableList := TFiltrableList<Byte>.New;
  FiltrableList.Add(1);
  FiltrableList.Add(20);
  FiltrableList.Add(30);
  FiltrableList.Add(40);
  FiltrableList.Add(40);
  for Item in _List.Filter(Condition) do
  begin
    ...
  end;
end;
```

### Demo
See the project example at the demo folder.

## Built With
* [Delphi&reg;](https://www.embarcadero.com/products/rad-studio) - Embarcadero&trade; commercial IDE
* [Lazarus](https://www.lazarus-ide.org/) - The Lazarus project

## Contribute
This are an open-source project, and they need your help to go on growing and improving.
You can even fork the project on GitHub, maintain your own version and send us pull requests periodically to merge your work.

## Authors
* **Alejandro Polti** (Vencejo Software team lead) - *Initial work*