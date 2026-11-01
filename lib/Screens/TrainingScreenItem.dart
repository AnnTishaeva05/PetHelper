import 'package:flutter/material.dart';

class TrainingScreenItem extends StatelessWidget {
  String title;
  String description;
  Image image;

  TrainingScreenItem({
    required this.title,
    required this.description,
    required this.image,
  });

  // Этапы тренировки для разных команд
  List<String> getTrainingSteps() {
    switch (title) {
      case "Команда сидеть":
        return [
          "Возьмите лакомство и поднесите к носу питомца",
          "Медленно поднимите руку с лакомством над головой животного",
          "Питомец инстинктивно сядет, чтобы следить за лакомством",
          "Как только он сядет, четко произнесите команду 'Сидеть!'",
          "Немедленно дайте лакомство и похвалите питомца",
          "Повторяйте 5-10 раз за тренировку",
          "Постепенно уменьшайте количество лакомств"
        ];
      case "Команда суслик":
        return [
          "Посадите питомца в положение 'сидеть'",
          "Поднесите лакомство к его носу и медленно опустите руку вниз",
          "Питомец потянется за лакомством и примет позу суслика",
          "В момент принятия позы произнесите команду 'Суслик!'",
          "Сразу же дайте лакомство и похвалите",
          "Тренируйтесь на мягкой поверхности для комфорта питомца",
          "Увеличивайте время удержания позы постепенно"
        ];
      case "Команда лежать":
        return [
          "Посадите питомца в положение 'сидеть'",
          "Поднесите лакомство к носу и медленно опустите руку к земле",
          "Питомец ляжет, чтобы достать лакомство",
          "Четко произнесите команду 'Лежать!' в момент укладки",
          "Немедленно дайте лакомство и похвалите",
          "Если питомец не ложится, аккуратно направьте его",
          "Практикуйте команду из разных положений"
        ];
      default:
        return [
          "Подготовьте лакомства для мотивации",
          "Выберите спокойное место для тренировки",
          "Начните с коротких сессий (5-10 минут)",
          "Постоянно хвалите питомца за успехи",
          "Завершайте тренировку на позитивной ноте"
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final trainingSteps = getTrainingSteps();

    return Scaffold(
    appBar: AppBar(
      toolbarHeight: 60,
      backgroundColor: Color.fromARGB(255, 254, 201, 98),
      title: Row(
      children: [
        Image.asset(
          "assets/images/eye_and_noyse.png",
          height: 110,
          width: 110,
          ),
        SizedBox(width: 12),
        Text(
          'Обучение команде',
          style: TextStyle(
            color: Color(0xFF8A4D05),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        ],
      ),
    ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF9F2),
              Color(0xFFFFF3E0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFB761),
                        Color(0xFFFEC962),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFFB761).withOpacity(0.4),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.school,
                        size: 40,
                        color: Color(0xFF8A4D05),
                      ),
                      SizedBox(height: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8A4D05),
                          letterSpacing: 1.1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Пошаговое руководство',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8A4D05).withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                // Наглядный пример
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 220,
                          child: image,
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFB761),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.photo_camera, size: 16, color: Color(0xFF8A4D05)),
                                SizedBox(width: 5),
                                Text(
                                  'Наглядный пример',
                                  style: TextStyle(
                                    color: Color(0xFF8A4D05),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 25),

                // Пошаговые инструкции
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      color: Color(0xFFFFB761).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.format_list_numbered,
                            color: Color(0xFFFFB761),
                            size: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Шаги обучения',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8A4D05),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      ...trainingSteps.asMap().entries.map((entry) {
                        int stepIndex = entry.key;
                        String step = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFB761),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '${stepIndex + 1}',
                                    style: TextStyle(
                                      color: Color(0xFF8A4D05),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  step,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                // Советы по тренировке
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF8A4D05).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Color(0xFF8A4D05).withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: Color(0xFFFFB761),
                            size: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Полезные советы',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8A4D05),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      _buildTipItem('⏱️ Длительность тренировки', '5-10 минут, 2-3 раза в день'),
                      _buildTipItem('🎯 Лучшее время', 'Когда питомец спокоен и немного голоден'),
                      _buildTipItem('🍖 Мотивация', 'Используйте любимые лакомства питомца'),
                      _buildTipItem('👍 Похвала', 'Всегда хвалите голосом и поглаживаниями'),
                      _buildTipItem('🔄 Повторение', 'Повторяйте команды в разных условиях'),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Блок успеха
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF8A4D05).withOpacity(0.1),
                        Color(0xFFFFB761).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Color(0xFFFFB761).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.celebration,
                        color: Color(0xFF8A4D05),
                        size: 30,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'При регулярных тренировках ваш питомец освоит команду за 1-2 недели!',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF8A4D05),
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8A4D05),
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}