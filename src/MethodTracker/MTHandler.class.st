"
I am able to accept and customize the execution of a (tracked) compiled method.
"
Class {
	#name : #MTHandler,
	#superclass : #MpHandler,
	#traits : 'TMpHandlerWithContext',
	#classTraits : 'TMpHandlerWithContext classTrait',
	#category : #MethodTracker
}

{ #category : #hooks }
MTHandler >> metadata: metadata [
]

{ #category : #evaluating }
MTHandler >> proxy: aMethodProxy [

	self shouldNotImplement
]

{ #category : #hooks }
MTHandler >> run: aSelector with: anArray in: aReceiver context: aContext tracker: aTracker [

	^ aTracker
		  valueWithReceiver: aReceiver
		  arguments: anArray
		  context: aContext
]
