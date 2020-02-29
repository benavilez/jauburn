"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'uimanager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [
	^#abs -> [ :f | f abs ]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [
	^#concat -> [ :s1 :s2 | s1,s2 ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| binding method |
				binding := self perform: s.
				method := JbPrimitive new block: binding value.
				environment at: binding key put: method ].
]

{ #category : #primitives }
JbInterpreter >> inputBinding [
	^#input -> [ :prompt | self uimanager request: prompt ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [
	^#length -> [ :s | s size ]
]

{ #category : #primitives }
JbInterpreter >> modBinding [
	^#mod -> [ :a :b | a \\ b ]
]

{ #category : #primitives }
JbInterpreter >> notBinding [
	^#not -> [ :b | b not ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
	^#print -> [ :value | Transcript show: value printString ]
]

{ #category : #primitives }
JbInterpreter >> printlnBinding [
	^#println -> [ :value | Transcript show: value printString; cr ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #accessing }
JbInterpreter >> uimanager [

	^uimanager ifNil: [ UIManager default ]
]

{ #category : #accessing }
JbInterpreter >> uimanager: userInput [

	^uimanager := userInput
]
