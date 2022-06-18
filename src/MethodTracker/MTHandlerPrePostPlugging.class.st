"
I am a handler that allows my subclasses to customize both the pre and post phases in an instrumentation-suspended context.
"
Class {
	#name : #MTHandlerPrePostPlugging,
	#superclass : #MTHandler,
	#category : #MethodTracker
}

{ #category : #'as yet unclassified' }
MTHandlerPrePostPlugging >> afterExecutionOf: aSelector inReceiver: receiver arguments: arguments returnValue: aReturnValue carry: carry context: aContext [

	^ self
		  run: aSelector
		  with: arguments
		  in: receiver
		  postContext: aContext
		  tracker: nil
		  carry: carry
		  return: aReturnValue
]

{ #category : #'as yet unclassified' }
MTHandlerPrePostPlugging >> beforeExecutionOf: aSelector inReceiver: receiver arguments: arguments context: aContext [

	^ self
		  run: aSelector
		  with: arguments
		  in: receiver
		  preContext: aContext
		  tracker: nil
]

{ #category : #'as yet unclassified' }
MTHandlerPrePostPlugging >> run: aSelector with: anArray in: aReceiver postContext: aContext tracker: aTracker carry: carry return: result [

	^ result
]

{ #category : #'as yet unclassified' }
MTHandlerPrePostPlugging >> run: aSelector with: anArray in: aReceiver preContext: aContext tracker: aTracker [

	
]
