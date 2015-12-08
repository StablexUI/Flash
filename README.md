StablexUI Flash
=======================
This library provides a backend for using StablexUI with OpenFL, NME or pure flash.

Supports all targets of OpenFL and NME. 

However there is a bug while building for android (it looks like hxcpp-related) which breaks building at c++ compilation step.
The workaround for that bug will be found asap.


Installation
-----------------------
```
haxelib git stablexui-flash https://github.com/StablexUI/Flash master
```
Include it in your hxml:
```
-lib stablexui-flash
```
or xml:
```
<haxelib name="stablexui-flash" />
```