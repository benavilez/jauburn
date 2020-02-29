"
Tests for JbInterpreter.
"
Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> testAbsBind [

	self interpret: 'var x = abs(-9);'.
	self assert: (interpreter environment at: 'x') equals: 9.
	
	self interpret: 'var x = abs(0);'.
	self assert: (interpreter environment at: 'x') equals: 0.
	
	self interpret: 'var x = abs(2);'.
	self assert: (interpreter environment at: 'x') equals: 2.
]

{ #category : #tests }
JbInterpreterTest >> testConcatBind [

	self interpret: 'var x = concat("hello","this");'.
	self assert: (interpreter environment at: 'x') equals: 'hellothis'.
	
	self interpret: 'var x = concat("running"," now");'.
	self assert: (interpreter environment at: 'x') equals: 'running now'.
	
	self interpret: 'var x = concat("23 is the "," magic number!");'.
	self assert: (interpreter environment at: 'x') equals: '23 is the  magic number!'.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 12 / 6;'.
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var x = 12 - 4;var y = x / 2;'.
	self assert: (interpreter environment at: 'y') equals: 4.
	
	self interpret: 'var x = 5 < 2;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 10;var y  = x < 11;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = 9 == 2;'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 10;var y  = x == 10;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = 2 > 1;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = -8;var y  = x > -9;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = 2 <= 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 1;var y  = x <= 0;'.
	self assert: (interpreter environment at: 'y') equals: false.
	
	self interpret: 'var x = 2 >= 2;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 18;var y  = x >= 11;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = 2 != 1;'.
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 10;var y  = x != 10;'.
	self assert: (interpreter environment at: 'y') equals: false.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testInputBind [

	interpreter uimanager: MockUIManager new.
	self interpret: 'input("This is a test");'.
	self assert: (interpreter uimanager prompt) equals: 'This is a test'.
]

{ #category : #tests }
JbInterpreterTest >> testLengthBind [

	self interpret: 'var x = length("cat");'.
	self assert: (interpreter environment at: 'x') equals: 3.
	
	self interpret: 'var x = length("");'.
	self assert: (interpreter environment at: 'x') equals: 0.
	
	self interpret: 'var x = length("elephant");'.
	self assert: (interpreter environment at: 'x') equals: 8.
]

{ #category : #tests }
JbInterpreterTest >> testModBind [

	self interpret: 'var x = mod(9, 3);'.
	self assert: (interpreter environment at: 'x') equals: 0.
	
	self interpret: 'var x = mod(10, 3);'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = mod(7, 4);'.
	self assert: (interpreter environment at: 'x') equals: 3.
]

{ #category : #tests }
JbInterpreterTest >> testNotBind [

	self interpret: 'var x = not(true);'.
	self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testPrintlnBind [

	self interpret: 'var x = println("hello");'.
	self assert: (interpreter environment at: 'x') equals: 'hello'.
	
	self interpret: 'var x = println("does this work?");'.
	self assert: (interpreter environment at: 'x') equals: 'does this work?'.
]

{ #category : #tests }
JbInterpreterTest >> testWhileStatement [
	
	self interpret: 'var x = 1; var y = 0; while (x <= 10) { y = y + x; x = x + 1; }'.
	self assert: (interpreter environment at: 'y') equals: 55
]
