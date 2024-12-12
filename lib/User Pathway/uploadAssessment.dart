import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadAssessments() async {
  List<Map<String, dynamic>> assessments = [
    {
      "topic": "Mindfulness Interest",
      "question": "Why are you exploring mindfulness practices? \nSelect all that apply",
      "options": [
        'Stress Relief',
        'Improve Mental Health',
        'Curiosity',
        'Improve Relationships',
        'Other (please specify)',
      ],
      "isMessage": false,
    },
    {
      "topic": "Mindfulness Interest",
      "question": 'How often do you currently practice mindfulness?',
      "options": [
        'Never',
        'Rarely',
        'Sometimes',
        'Often',
        'Daily',
      ],
      "isMessage": false,
    },
    {
      "topic": "Mindfulness Knowledge",
      "question": 'How would you rate your current knowledge of mindfulness on a scale from 1 (beginner) to 5 (expert)',
      "options": [],
      "isMessage": false,
    },
  {
    "topic":"Mindfulness Interest",
    "question":  'What challenges or obstacles do you face when trying to practice mindfulness?  ',
    "options": [
      "Don't know how to start",
      'Lack of time',
      'Easily distracted',
      'Not seeing results',
      "Not Effective",
    ],
    "isMessage":false,

  },
  {
    "topic":"Mindfulness Interest",
    "question":  'Which of the following would you find most helpful in your mindfulness journey?',
    "options": [
      'Guided meditation',
      'Tracking tools',
      'Community Support',
      'Experts insights',
      'Daily reminders',
    ],
    "isMessage":false,

  },
  {
    "topic":"Learning Style",
    "question":  'How do you prefer to engage with mindfulness content?',
    "options": [
      'Reading',
      'Audio Guided Sessions',
      'Video Demonstrations',
      'Interactive tools',
      'Group sessions',
    ],
    "isMessage":false,

  },
  {
    "topic":"Learning Style",
    "question":    'Do you prefer short daily practices or longer, less frequent sessions?',
    "options": [
      'Short Daily Practices',
      'Longer Sessions ',
      'A Mix or Both',
    ],
    "isMessage":false,

  },
  {
    "topic":"Learning Style",
    "question":  'On a scale from 1 (very low) to 5 (very high), how would you rate your current stress level? ',
    "options": [

    ],
    "isMessage":false,

  },
  {
    "topic":"Learning Style",
    "question": 'Would you be interested in connecting with a community or group as part of your mindfulness journey?',
    "options": [
      'Yes',
      'No',
      'Maybe',
    ],
    "isMessage":true,

  },
  {
    "topic":"Learning Style",
    "question":'Please select your new pathway to get started on your journey',

  "options": [
    'Focus & Productivity',
    "Burnout Reduction",
    "Performance",
    'Collaboration',
    'Leadership',
    ],
    "isMessage":false,

  },

  ];

  CollectionReference assessmentsRef = FirebaseFirestore.instance.collection('assessments');

  for (var assessment in assessments) {
    // Check if an assessment with the same question already exists
    QuerySnapshot existingAssessments = await assessmentsRef
        .where('question', isEqualTo: assessment['question'])
        .get();

    if (existingAssessments.docs.isEmpty) {
      // If no existing document is found, add the new assessment
      await assessmentsRef.add(assessment);
    } else {
      // Optionally, handle what happens if the document already exists
      print("Assessment already exists: ${assessment['question']}");
    }
  }
}

