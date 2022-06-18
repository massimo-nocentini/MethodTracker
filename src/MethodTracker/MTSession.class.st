"
I am a container of method trackers and I manage their installation, execution and uninstallation.
"
Class {
	#name : #MTSession,
	#superclass : #Object,
	#instVars : [
		'stackCounter',
		'trackers',
		'home'
	],
	#category : #MethodTracker
}

{ #category : #API }
MTSession class >> compiledMethods: aCollection thenSelect: methodBlock [

	| methods session |
	methods := aCollection select: methodBlock.

	session := self new.

	methods do: [ :each | 
		| decorator |
		decorator := MTTracker new
			             compiledMethod: each;
			             yourself.

		session add: decorator ].

	^ session
]

{ #category : #API }
MTSession class >> forBaselineClass: aBaselineClass selectMethod: methodBlock [

	| methods |
	methods := (aBaselineClass allPackageNames collect: [ :each | 
		            each asPackage ]) flatCollect: [ :each | each methods ].

	^ self compiledMethods: methods thenSelect: methodBlock
]

{ #category : #API }
MTSession class >> forPackages: aCollection selectMethod: methodBlock [

	| methods |
	methods := aCollection asOrderedCollection flatCollect: [ :each | 
		           each methods ].

	^ self compiledMethods: methods thenSelect: methodBlock
]

{ #category : #'instance creation' }
MTSession class >> withAll: aCollection [

	^ self compiledMethods: aCollection thenSelect: [ :each | true ]
]

{ #category : #'instance creation' }
MTSession class >> withAllImplementations: aCollection [

	^ self
		  compiledMethods:
		  (aCollection flatCollect: [ :each | each allImplementations ])
		  thenSelect: [ :each | true ]
]

{ #category : #adding }
MTSession >> add: aTracker [

	^ trackers at: aTracker compiledMethod ifAbsentPut: [ 
		  aTracker
			  session: self;
			  yourself ]
]

{ #category : #enumerating }
MTSession >> do: aBlock [

	trackers valuesDo: aBlock
]

{ #category : #initialization }
MTSession >> initialize [

	super initialize.

	trackers := Dictionary new.

	stackCounter := 0
]

{ #category : #accessing }
MTSession >> value: aBlock [

	"Save the current context as 'root' for the following computation."

	home := thisContext.

	^ [ 
	  self do: [ :each | each install ].
	  aBlock value ] ensure: [ 
		  self do: [ :each | each uninstall ].
		  home := nil ]
]
