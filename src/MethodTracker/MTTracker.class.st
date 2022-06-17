"
I am able to represent a compiled method and, collaborating with an handler, I can customize the computation flow.
"
Class {
	#name : #MTTracker,
	#superclass : #MpMethodProxyWithContext,
	#instVars : [
		'session'
	],
	#category : #MethodTracker
}

{ #category : #initialization }
MTTracker class >> doInspectAllInstances [

	<script>
	self inspectAllInstances
]

{ #category : #initialization }
MTTracker class >> reset [

	<script>
	self allSubclassesDo: [ :each | 
		each allInstances do: [ :w | 
			[ w uninstall ] onDNU: #uninstall do: [  ] ] ].

	SpNullApplication reset.

	Smalltalk garbageCollect
]

{ #category : #initialization }
MTTracker >> compiledMethod [

	^ self wrappedMethod
]

{ #category : #initialization }
MTTracker >> compiledMethod: aCompiledMethod [

	self
		class: aCompiledMethod methodClass
		selector: aCompiledMethod selector
]

{ #category : #private }
MTTracker >> ifInstalled: iBlock ifNotInstalled: niBlock [

	^ self compiledMethod methodClass methodDict
		  at: self compiledMethod selector
		  ifPresent: [ :aMethod | 
			  aMethod == self
				  ifTrue: iBlock
				  ifFalse: niBlock ]
		  ifAbsent: [ Error signal ]
]

{ #category : #accessing }
MTTracker >> session: anObject [

	session := anObject
]

{ #category : #evaluation }
MTTracker >> withSuspendWrapping: aBlock context: aContext [

	"session pushContext: aContext.

	^ [ aBlock cull: session ] ensure: [ session popContext: aContext ]"

	^ aBlock cull: session
]
