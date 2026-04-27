# openapi.model.ReturnChatEvent

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**chatId** | **String** | Identifier for the Chat this event occurred in. Formatted as a UUID. | 
**emotionFeatures** | **String** | Stringified JSON containing the prosody model inference results.  EVI uses the prosody model to measure 48 expressions related to speech and vocal characteristics. These results contain a detailed emotional and tonal analysis of the audio. Scores typically range from 0 to 1, with higher values indicating a stronger confidence level in the measured attribute. | [optional] 
**id** | **String** | Identifier for a Chat Event. Formatted as a UUID. | 
**messageText** | **String** | The text of the Chat Event. This field contains the message content for each event type listed in the `type` field. | [optional] 
**metadata** | **String** | Stringified JSON with additional metadata about the chat event. | [optional] 
**relatedEventId** | **String** | Identifier for a related chat event. Currently only seen on ASSISTANT_PROSODY events, to point back to the ASSISTANT_MESSAGE that generated these prosody scores | [optional] 
**role** | [**ReturnChatEventRole**](ReturnChatEventRole.md) |  | 
**timestamp** | **int** | Time at which the Chat Event occurred. Measured in seconds since the Unix epoch. | 
**type** | [**ReturnChatEventType**](ReturnChatEventType.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


