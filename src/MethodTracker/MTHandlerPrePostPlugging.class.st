"
I am a handler that allows my subclasses to customize both the pre and post phases in an instrumentation-suspended context.
"
Class {
	#name : #MTHandlerPrePostPlugging,
	#superclass : #MTHandler,
	#traits : 'TMpHandlerWithContext',
	#classTraits : 'TMpHandlerWithContext classTrait',
	#category : #MethodTracker
}

{ #category : #'as yet unclassified' }
MTHandlerPrePostPlugging >> afterExecutionWithReceiver: receiver arguments: arguments returnValue: aReturnValue carry: carry context: aContext [

	^ self
		  run: proxy selector
		  with: arguments
		  in: receiver
		  postContext: aContext
		  tracker: proxy
		  carry: carry
		  return: aReturnValue
]

{ #category : #'as yet unclassified' }
MTHandlerPrePostPlugging >> beforeExecutionWithReceiver: receiver arguments: arguments context: aContext [

	^ self
		  run: proxy selector
		  with: arguments
		  in: receiver
		  preContext: aContext
		  tracker: proxy
]

{ #category : #'as yet unclassified' }
MTHandlerPrePostPlugging >> run: aSelector with: anArray in: aReceiver postContext: aContext tracker: aTracker carry: carry return: result [

	^ result
]

{ #category : #'as yet unclassified' }
MTHandlerPrePostPlugging >> run: aSelector with: anArray in: aReceiver preContext: aContext tracker: aTracker [

	
]
