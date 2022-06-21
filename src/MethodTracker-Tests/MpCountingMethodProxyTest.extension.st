Extension { #name : #MpCountingMethodProxyTest }

{ #category : #'*MethodTracker-Tests' }
MpCountingMethodProxyTest >> testInversions [

	"Dual of `MTVisualizationsTest>>#testInspectInversions`"

	| proxies |
	proxies := OrderedCollection new.

	[ "Setting up."
	proxies add: (self proxyClass
			 onMethod: SequenceableCollection >> #inversions:
			 handler: self handlerClass new).

	proxies add: (self proxyClass
			 onMethod:
			 PositionableStream >> #merge:sortBlock:on:inversionsOrNil:
			 handler: self handlerClass new).

	proxies add: (self proxyClass
			 onMethod: SequenceableCollection >> #bisect:baseBlock:
			 handler: self handlerClass new).

	proxies add: (self proxyClass
			 onMethod: SequenceableCollection >> #bisect:from:to:baseBlock:
			 handler: self handlerClass new).

	proxies add: (self proxyClass
			 onMethod: Stream >> #nextPut:inversion:
			 handler: self handlerClass new).

	"Install."
	proxies do: [ :each | each install ].

	"Do."
	{ 2. 4. 1. 3. 5 } inversions: [ :i :j | i < j ].

	"Check."
	self assert: proxies first handler count equals: 1.
	self assert: proxies second handler count equals: 4.
	self assert: proxies third handler count equals: 1.
	self assert: proxies fourth handler count equals: 9.
	self assert: proxies fifth handler count equals: 3 ] ensure: [ 
		proxies do: [ :each | each uninstall ] ]
]
