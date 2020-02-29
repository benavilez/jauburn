Class {
	#name : #MockUIManager,
	#superclass : #Object,
	#instVars : [
		'prompt'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #accessing }
MockUIManager >> prompt [

	^prompt
]

{ #category : #'as yet unclassified' }
MockUIManager >> request: queryString [

	prompt := queryString
]
