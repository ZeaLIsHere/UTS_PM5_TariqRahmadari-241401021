class QuizQuestion {
  const QuizQuestion(
    this.prompt,
    this.options,
    this.correctIndex,
    this.explanation,
  );
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;
}

const questions = <QuizQuestion>[
  QuizQuestion(
    'Apa sebutan makhluk supernatural dalam cerita rakyat Jepang?',
    ['Yōkai', 'Samurai', 'Shōgun', 'Ronin'],
    0,
    'Yōkai adalah istilah luas untuk makhluk dan fenomena supernatural dalam folklor Jepang.',
  ),
  QuizQuestion(
    'Rubah dalam mitologi Jepang yang dikenal dapat berubah wujud disebut...',
    ['Tengu', 'Kitsune', 'Oni', 'Kappa'],
    1,
    'Kitsune dipercaya memiliki kecerdasan dan kemampuan berubah wujud.',
  ),
  QuizQuestion(
    'Makhluk sungai dengan cekungan berisi air di kepalanya adalah...',
    ['Kodama', 'Yuki-onna', 'Kappa', 'Nekomata'],
    2,
    'Kappa tinggal di perairan; cekungan di kepalanya dianggap sumber kekuatannya.',
  ),
  QuizQuestion(
    'Oni biasanya digambarkan sebagai...',
    ['Raksasa bertanduk', 'Burung pembawa pesan', 'Rubah putih', 'Roh pohon'],
    0,
    'Oni sering digambarkan bertanduk, bertaring, dan membawa gada besi.',
  ),
  QuizQuestion(
    'Tengu kerap dikaitkan dengan tempat seperti...',
    ['Dasar laut', 'Pegunungan dan hutan', 'Istana bawah tanah', 'Gurun pasir'],
    1,
    'Tengu sering muncul dalam cerita tentang gunung, hutan, dan pertapa.',
  ),
  QuizQuestion(
    'Siapa nama dewi matahari dalam kepercayaan Shinto?',
    ['Tsukuyomi', 'Susanoo', 'Amaterasu', 'Izanami'],
    2,
    'Amaterasu Ōmikami adalah dewi matahari yang penting dalam mitologi Jepang.',
  ),
  QuizQuestion(
    'Legenda Yuki-onna menggambarkan sosok yang berhubungan dengan...',
    ['Api', 'Salju', 'Petir', 'Laut'],
    1,
    'Yuki-onna berarti perempuan salju dan muncul dalam kisah musim dingin.',
  ),
  QuizQuestion(
    'Kodama adalah roh yang dipercaya menghuni...',
    ['Pohon', 'Pedang', 'Cermin', 'Sungai'],
    0,
    'Kodama adalah roh pohon dalam tradisi rakyat Jepang.',
  ),
  QuizQuestion(
    'Nekomata digambarkan sebagai yōkai berupa...',
    ['Burung hantu', 'Kucing', 'Serigala', 'Ular'],
    1,
    'Nekomata adalah sosok kucing supernatural dalam cerita rakyat Jepang.',
  ),
  QuizQuestion(
    'Dewa badai dan laut, saudara Amaterasu, bernama...',
    ['Susanoo', 'Inari', 'Raijin', 'Hachiman'],
    0,
    'Susanoo-no-Mikoto berkaitan dengan badai dan laut dalam mitologi Jepang.',
  ),
];
