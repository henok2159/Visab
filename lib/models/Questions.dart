class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({required this.id,required this.question,required this.answer,required this.options});
}
const List sample_data = [ { "id": 1, "question": "What is the capital city of ETHIOPIA", "options": ['Addis Ababa', 'Gonder', 'Jimma', 'Mekele'], "answer_index": 0, },
  { "id": 2, "question": "Who was the 1st Ethiopian to win a Gold medal in olympic", "options": ['Haile G/selase', 'Abebe Bikila', 'Mofara', 'Kenenisa bekele'], "answer_index": 1, },
  { "id": 3, "question": "How old is ETHIOPIA", "options": ['200', '>3000', '200', '>100'], "answer_index": 1, },
  { "id": 4, "question": "ETHIOPIA is well known for her", "options": ['Coffee', 'Injera', 'Marvelous culture', 'All of the above'], "answer_index": 3, },
  { "id": 5, "question": "Which African country was not colonized by Western power ", "options": ['Gabon', 'ETHIOPIA', 'Sudan', 'Ghana'], "answer_index": 1, },
  { "id": 6, "question": "From the following ETHIOPIAN historical places which one is registered to UNESCO", "options": ['Sofumar', 'Axum', 'Lalibela', 'All of the above'], "answer_index": 3, },
  { "id": 7, "question": "The old name of Ethiopia was", "options": ['Abyssinia', 'Axum', 'Zagwe', 'Persia'], "answer_index": 0, },
];
