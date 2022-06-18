"
I am a decorator that install my self on the sender of the caught context.
"
Class {
	#name : #MTHandlerSenderPropagating,
	#superclass : #MTHandlerDecorating,
	#instVars : [
		'walkBlock'
	],
	#category : #MethodTracker
}

{ #category : #hooks }
MTHandlerSenderPropagating >> initialize [

	super initialize.

	self walkBlock: [ :aContext | aContext sender home method ]
]

{ #category : #hooks }
MTHandlerSenderPropagating >> run: aSelector with: anArray in: aReceiver context: aContext tracker: aTracker [

	| tracker additionWitness walkedContext |
	walkedContext := walkBlock value: aContext.

	tracker := MTTracker onMethod: walkedContext handler: self.

	additionWitness := aTracker session add: tracker.

	additionWitness == tracker ifTrue: [ tracker install ].

	^ super
		  run: aSelector
		  with: anArray
		  in: aReceiver
		  context: aContext
		  tracker: aTracker
]

{ #category : #accessing }
MTHandlerSenderPropagating >> walkBlock: anObject [

	walkBlock := anObject
]
