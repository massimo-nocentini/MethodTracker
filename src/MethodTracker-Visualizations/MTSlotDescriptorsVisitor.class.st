"
I am a visitor that simplify the representation of blocks.
"
Class {
	#name : 'MTSlotDescriptorsVisitor',
	#superclass : 'CTSlotDescriptorsVisitor',
	#category : 'MethodTracker-Visualizations',
	#package : 'MethodTracker-Visualizations'
}

{ #category : 'visiting' }
MTSlotDescriptorsVisitor >> visitBlockClosure: aBlock [

	^ { (self newSlotDescriptorSelector: #asString) inline }
]
