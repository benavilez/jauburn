Class {
	#name : #JbIfElseNode,
	#superclass : #JbIfNode,
	#instVars : [
		'falseStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #api }
JbIfElseNode >> executeIn: anEnvironment [

	(condition evaluateIn: anEnvironment) 
	ifTrue: [ :each | each trueStatements] 
	ifFalse: [ :each | each falseStatements ]
]

{ #category : #accessing }
JbIfElseNode >> falseStatements [
	^ falseStatements
]

{ #category : #accessing }
JbIfElseNode >> falseStatements: anObject [
	falseStatements := anObject
]
