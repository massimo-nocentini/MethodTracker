"
I am a data object for the building of sequence diagrams.
"
Class {
	#name : 'MTTimedMessageSend',
	#superclass : 'Object',
	#instVars : [
		'timespan',
		'messageSend'
	],
	#category : 'MethodTracker-UI',
	#package : 'MethodTracker-UI'
}

{ #category : 'accessing' }
MTTimedMessageSend >> messageSend [

	^ messageSend
]

{ #category : 'accessing' }
MTTimedMessageSend >> messageSend: anObject [

	messageSend := anObject
]

{ #category : 'accessing' }
MTTimedMessageSend >> timespan [

	^ timespan
]

{ #category : 'accessing' }
MTTimedMessageSend >> timespan: anObject [

	timespan := anObject
]
