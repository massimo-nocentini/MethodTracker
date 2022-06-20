"
I am a profiling variant that also copies both receivers, arguments, clients and returned values.
"
Class {
	#name : #MTHandlerCopyingProfiling,
	#superclass : #MTHandlerProfiling,
	#instVars : [
		'copier',
		'table'
	],
	#category : #MethodTracker
}

{ #category : #copying }
MTHandlerCopyingProfiling >> copyBlock: anObject [

	copier := anObject
]

{ #category : #initialization }
MTHandlerCopyingProfiling >> initialize [

	super initialize.

	table := Dictionary new.
	self copyBlock: [ :each | each copy ]
]

{ #category : #accessing }
MTHandlerCopyingProfiling >> metadata: metadata [

	super metadata: metadata.

	table keysAndValuesDo: [ :each :anAssoc | 
		| model ctx messageSend messageSent |
		model := metadata at: each.

		messageSent := anAssoc value.
		messageSend := messageSent messageSend.

		ctx := model reifiedContext.

		model reifiedContext: (Context
				 sender: ctx sender
				 receiver: messageSend receiver
				 method: ctx method
				 arguments: messageSend arguments).

		model return: messageSent return.

		model client
			ifNothing: [  ]
			ifJust: [ :aJust | 
			model client: anAssoc key asJustMaybe asCategory ] ]
]

{ #category : #'as yet unclassified' }
MTHandlerCopyingProfiling >> run: aSelector with: anArray in: aReceiver postContext: aContext tracker: aTracker carry: timed return: result [

	| superResult client clientCopied resultCopied message |
	superResult := super
		               run: aSelector
		               with: anArray
		               in: aReceiver
		               postContext: aContext
		               tracker: aTracker
		               carry: timed
		               return: result.

	client := (self parent: aContext ifAbsent: [ Error signal ])
		          asArgumentsReifiedContext receiver.

	clientCopied := copier value: client.
	resultCopied := copier value: superResult.

	message := table at: aContext.

	table
		at: aContext
		put: clientCopied -> (message return: resultCopied).

	^ superResult
]

{ #category : #evaluation }
MTHandlerCopyingProfiling >> run: aSelector with: anArray in: aReceiver preContext: aContext tracker: aTracker [

	| message messageSend |
	messageSend := MessageSend
		               receiver: (copier value: aReceiver)
		               selector: aSelector
		               arguments: (anArray collect: copier).

	message := table at: aContext put: messageSend.

	^ super
		  run: aSelector
		  with: anArray
		  in: aReceiver
		  preContext: aContext
		  tracker: aTracker
]
