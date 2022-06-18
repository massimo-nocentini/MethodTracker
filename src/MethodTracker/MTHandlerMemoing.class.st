"
I am a decorator that prevents the delegation to my handler if a given message send has been already seen.
"
Class {
	#name : #MTHandlerMemoing,
	#superclass : #MTHandlerTabling,
	#category : #MethodTracker
}

{ #category : #'as yet unclassified' }
MTHandlerMemoing >> run: aSelector with: anArray in: aReceiver context: aContext tracker: aTracker [

	| key missing value witness |
	witness := Object new.

	key := { 
		       aReceiver.
		       aSelector } , anArray.

	value := table at: key ifAbsent: [ witness ].

	missing := value == witness.

	^ missing
		  ifTrue: [ 
			  value := super
				           run: aSelector
				           with: anArray
				           in: aReceiver
				           context: aContext
				           tracker: aTracker.

			  table at: key put: value ]
		  ifFalse: [ value ]
]
