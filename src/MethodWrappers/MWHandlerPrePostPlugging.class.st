Class {
	#name : #MWHandlerPrePostPlugging,
	#superclass : #MWHandler,
	#category : #MethodWrappers
}

{ #category : #hooks }
MWHandlerPrePostPlugging >> run: aSelector with: anArray in: aReceiver context: aContext wrapper: aWrapper [

	| result carry |
	carry := aWrapper
		         withSuspendWrapping: [ 
			         self
				         run: aSelector
				         with: anArray
				         in: aReceiver
				         preContext: aContext
				         wrapper: aWrapper ]
		         context: aContext.

	result := super
		          run: aSelector
		          with: anArray
		          in: aReceiver
		          context: aContext
		          wrapper: aWrapper.

	aWrapper
		withSuspendWrapping: [ 
			self
				run: aSelector
				with: anArray
				in: aReceiver
				postContext: aContext
				wrapper: aWrapper
				carry: carry
				return: result ]
		context: aContext.

	^ result
]

{ #category : #'as yet unclassified' }
MWHandlerPrePostPlugging >> run: aSelector with: anArray in: aReceiver postContext: aContext wrapper: aWrapper carry: carry return: result [

	
]

{ #category : #'as yet unclassified' }
MWHandlerPrePostPlugging >> run: aSelector with: anArray in: aReceiver preContext: aContext wrapper: aWrapper [

	
]