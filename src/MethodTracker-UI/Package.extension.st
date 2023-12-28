Extension { #name : 'Package' }

{ #category : '*MethodTracker-UI' }
Package >> activatedPackages: selectedPackages classes: selectedClasses methods: selectedMethods [

	selectedPackages add: self
]

{ #category : '*MethodTracker-UI' }
Package >> belongsPackages: selectedPackages classes: selectedClasses methods: selectedMethods [

	^ selectedPackages includes: self
]

{ #category : '*MethodTracker-UI' }
Package >> childrenForCompiledMethodChoosePresenter: aPresenter [

	^ self definedClasses asSortedCollection: [ :aClass :anotherClass | 
		  aClass name < anotherClass name ]
]

{ #category : '*MethodTracker-UI' }
Package >> deactivatedPackages: selectedPackages classes: selectedClasses methods: selectedMethods [

	selectedPackages remove: self
]

{ #category : '*MethodTracker-UI' }
Package >> iconNameForCompiledMethodChoosePresenter: aPresenter [

	^ #package
]
