final List<Map<String, dynamic>> initialSessions = [];


/* [
  {
    "chatMessages": [
      {
        "role": "USER",
        "text": "Then It's been incredible.",
        "emotion_features": "{\"Admiration\": 0.006397247314453125, \"Adoration\": 0.004726409912109375}"
      },
      {
        "role": "AGENT",
        "text": "I'm sensing some mixed emotions in your response.",
        "emotion_features": "{\"Admiration\": 0.041778564453125, \"Adoration\": 0.0143890380859375}"
      },
      {
        "role": "AGENT",
        "text": "While you say it's been incredible, I'm detecting a hint of disappointment, a slight touch of anger, and a trace of contempt.",
        "emotion_features": "{\"Admiration\": 0.1485595703125, \"Adoration\": 0.055816650390625}"
      }
    ],
    "emotions": {
      "Anger": 0.3512890625,
      "Disappointment": 0.22265625,
      "Contempt": 0.18162109375,
      "Distress": 0.160380859375,
      "Awkwardness": 0.12932373046875,
      "Disgust": 0.0944921875
    },
    "createdAt": "2024-11-29T12:30:06.973870",
    "priority": "low",
    "diga": ""
  },
  {
    "chatMessages": [
      {
        "role": "USER",
        "text": "Then It's been incredible.",
        "emotion_features": "{\"Admiration\": 0.006397247314453125, \"Adoration\": 0.004726409912109375}"
      },
      {
        "role": "AGENT",
        "text": "I'm sensing some mixed emotions in your response.",
        "emotion_features": "{\"Admiration\": 0.041778564453125, \"Adoration\": 0.0143890380859375}"
      },
      {
        "role": "AGENT",
        "text": "While you say it's been incredible, I'm detecting a hint of disappointment, a slight touch of anger, and a trace of contempt.",
        "emotion_features": "{\"Admiration\": 0.1485595703125, \"Adoration\": 0.055816650390625}"
      }
    ],
    "emotions": {
      "Contempt": 0.3812890625,
      "Anger": 0.19265625,
      "Disappointment": 0.17162109375,
      "Distress": 0.150380859375,
      "Disgust": 0.13932373046875,
      "Awkwardness": 0.0844921875
    },
    "createdAt": "2024-11-29T11:00:06.973870",
    "priority": "low",
    "diga": ""
  },
  {
    "chatMessages": [
      {
        "role": "USER",
        "text": "Then It's been incredible.",
        "emotion_features": "{\"Admiration\": 0.006397247314453125, \"Adoration\": 0.004726409912109375}"
      },
      {
        "role": "AGENT",
        "text": "I'm sensing some mixed emotions in your response.",
        "emotion_features": "{\"Admiration\": 0.041778564453125, \"Adoration\": 0.0143890380859375}"
      },
      {
        "role": "AGENT",
        "text": "While you say it's been incredible, I'm detecting a hint of disappointment, a slight touch of anger, and a trace of contempt.",
        "emotion_features": "{\"Admiration\": 0.1485595703125, \"Adoration\": 0.055816650390625}"
      }
    ],
    "emotions": {
      "Distress": 0.3612890625,
      "Disgust": 0.24265625,
      "Anger": 0.16162109375,
      "Disappointment": 0.130380859375,
      "Contempt": 0.10932373046875,
      "Awkwardness": 0.0944921875
    },
    "createdAt": "2024-11-29T10:00:06.973870",
    "priority": "low",
    "diga": ""
  },
  {
    "chatMessages": [
      {
        "role": "USER",
        "text": "Then It's been incredible.",
        "emotion_features": "{\"Admiration\": 0.006397247314453125, \"Adoration\": 0.004726409912109375}"
      },
      {
        "role": "AGENT",
        "text": "I'm sensing some mixed emotions in your response.",
        "emotion_features": "{\"Admiration\": 0.041778564453125, \"Adoration\": 0.0143890380859375}"
      },
      {
        "role": "AGENT",
        "text": "While you say it's been incredible, I'm detecting a hint of disappointment, a slight touch of anger, and a trace of contempt.",
        "emotion_features": "{\"Admiration\": 0.1485595703125, \"Adoration\": 0.055816650390625}"
      }
    ],
    "emotions": {
      "Disgust": 0.3412890625,
      "Awkwardness": 0.25265625,
      "Distress": 0.15162109375,
      "Anger": 0.120380859375,
      "Disappointment": 0.11932373046875,
      "Contempt": 0.0844921875
    },
    "createdAt": "2024-11-28T13:30:06.973870",
    "priority": "low",
    "diga": ""
  },
  {
    "chatMessages": [
      {
        "role": "USER",
        "text": "Then It's been incredible.",
        "emotion_features": "{\"Admiration\": 0.006397247314453125, \"Adoration\": 0.004726409912109375}"
      },
      {
        "role": "AGENT",
        "text": "I'm sensing some mixed emotions in your response.",
        "emotion_features": "{\"Admiration\": 0.041778564453125, \"Adoration\": 0.0143890380859375}"
      },
      {
        "role": "AGENT",
        "text": "While you say it's been incredible, I'm detecting a hint of disappointment, a slight touch of anger, and a trace of contempt.",
        "emotion_features": "{\"Admiration\": 0.1485595703125, \"Adoration\": 0.055816650390625}"
      }
    ],
    "emotions": {
      "Disappointment": 0.3712890625,
      "Contempt": 0.23265625,
      "Awkwardness": 0.16162109375,
      "Disgust": 0.110380859375,
      "Anger": 0.10932373046875,
      "Distress": 0.0944921875
    },
    "createdAt": "2024-11-28T11:30:06.973870",
    "priority": "low",
    "diga": ""
  },
  {
    "chatMessages": [
      {
        "role": "USER",
        "text": "Then It's been incredible.",
        "emotion_features": "{\"Admiration\": 0.006397247314453125, \"Adoration\": 0.004726409912109375}"
      },
      {
        "role": "AGENT",
        "text": "I'm sensing some mixed emotions in your response.",
        "emotion_features": "{\"Admiration\": 0.041778564453125, \"Adoration\": 0.0143890380859375}"
      },
      {
        "role": "AGENT",
        "text": "While you say it's been incredible, I'm detecting a hint of disappointment, a slight touch of anger, and a trace of contempt.",
        "emotion_features": "{\"Admiration\": 0.1485595703125, \"Adoration\": 0.055816650390625}"
      }
    ],
    "emotions": {
      "Awkwardness": 0.3912890625,
      "Distress": 0.21265625,
      "Disgust": 0.15162109375,
      "Contempt": 0.130380859375,
      "Disappointment": 0.09932373046875,
      "Anger": 0.0844921875
    },
    "createdAt": "2024-11-28T10:30:00.973870",
    "priority": "low",
    "diga": ""
  }
];
 */