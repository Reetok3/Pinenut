<div id="pinuts_description"></div>

# Pinenuts
これはネットワークがプログラムしやすい言語です。
## インストール
```
git clone https://github.com/Reetok3/Reetok-repository.git
```
## 実行
```
cd Reetok-repository/Make-Programming-Language/Pinenuts
ruby main.rb ファイル
```
## 特徴
・すべてを一行で済ませることができます。
```
print "aiueo" print "kakikukeko" print "sasisuseso"
```
## 機能
### Print
printの後にスペースを1個以上入れます。
```
print "aiueo"
```
### 変数
スペースをイコールの前後に入れます。
```
a = "aiueo"
b = "kakikukeko"
print a
print b
```
#### 型
##### String
文字列です。
ダブルクオーテーションで囲います。
```
print "aiueo"
```
##### Integer
数値です。
```
print 123
print 123.456
```
##### Cond
条件式です。
演算子の前後にスペースは入れない。
```
print 1==2
print 1!=2
print 1<2
print 1>2
```
##### Truth
真偽です。
```
print true
print false
```
##### EXP
計算式です。
+と-のみ使うことが可能です。
+と-の前後にスペースは入れない。
```
print 1+1+1-2
print 43689+58973-562497
```
### While
ループです。
条件式がfalseになるまで続けます。
```
while true do
endwhile
```
上の場合は無限ループになります。
```
i = 0
while i<10
	print i
	i = i+1
endwhile
```
上の場合は、0~9の数字が表示されます。
### If
これは条件分岐です。
条件式がtrueだと実行します。
```
i = 0
if i<0
	print "iは0より小さい"
endif
```
### ネットワークメソッド
#### pn
これは、バックグラウンドで起動します。
起動したら、終了するまで動作します。
配列を指定することで配列に情報を入れることができます。
##### pn_start
バックグラウンドで起動を始めます。
```
pn_start
```
##### pn_new
これは、一番最近の情報を配列に入れます。
これは、定数のように使うことができます。
```
pn_start
print pn_new
```
上のプログラムでは、一番最近のデータが保存されます。
pn_startを行い、ネットワーク通信を行ってから、pn_newをすると、ネットワーク通信のデータを見ることができます。
また、一番最近のデータは、dbとして保存されています。
なので、プログラムを終了した後でも、維持されます。
もし、過去のデータを消去したい場合は、ディレクトリにある、`data_list_var.txt`を削除してください。
### random(数値)
これは、定数のように使うことができます。
```
print random(10)
```
上のプログラムは、0~10までの整数を表示します。
%を使うことでも、上限を指定することができます。（%はまだじっそうされていません。）
