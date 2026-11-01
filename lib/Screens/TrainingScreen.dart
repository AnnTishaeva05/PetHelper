import 'package:flutter/material.dart';
import 'package:mobile/Screens/TrainingScreenItem.dart';

class TrainingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrainingScreenState();
  }
}

class _TrainingScreenState extends State<TrainingScreen> {
  final List<TrainingScreenItem> _items = [
    TrainingScreenItem(
        title: "Команда сидеть",
        description: "Упражнение для изучения команды сидеть",
        image: Image.network(
            "https://i.pinimg.com/736x/0e/58/55/0e58555319267f71a2b1e99a686341d9.jpg")
    ),
    TrainingScreenItem(
        title: "Команда суслик",
        description: "Упражнение для изучения команды суслик",
        image: Image.network(
            "https://i.pinimg.com/736x/f7/ba/da/f7bada65156cfc3ab04f80df9e763db3.jpg")
    ),
    TrainingScreenItem(
        title: "Команда лежать",
        description: "Упражнение для изучения команды лежать",
        image: Image.network("https://stihi.ru/pics/2024/08/02/1684.jpg")
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery
                  .of(context)
                  .padding
                  .top + 20,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFDC95E),
                  Color(0xFFFFB761),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Тренировки',
                  style: TextStyle(
                    color: Color(0xFF8A4D05),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Выберите нужную тренировку',
                  style: TextStyle(
                    color: Color(0xFF8A4D05).withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Сетка тренировок
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75, // Немного изменили пропорции
                ),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildTrainingCard(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingCard(int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _items[index])
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: (_items[index].image as Image).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Контент
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название
                  Text(
                    _items[index].title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 4),

                  // Описание
                  Text(
                    _items[index].description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 8),

                  // Простая кнопка
                  Container(
                    width: double.infinity,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFB761),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Начать',
                        style: TextStyle(
                          color: Color(0xFF8A4D05),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}