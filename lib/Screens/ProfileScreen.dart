import 'package:flutter/material.dart';
import 'package:mobile/Common/custom_text_field.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Иван Иванов');
  final List<Pet> _pets = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          // Фон с легким затемнением для лучшей читаемости
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/page_profile_background.png'),
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomLeft,

              ),
            ),
          ),

          SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  // Заголовок профиля
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFFB761).withOpacity(1),
                          Color(0xFFFFB761).withOpacity(0.1),
                        ],
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.white10,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Мой профиль',
                          style: TextStyle(
                            color: Color(0xFF8A4D05),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Аватар и имя
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              // Аватар с улучшенным дизайном
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 254, 201, 98),
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset(
                                      'assets/images/duck_avatar.jpg',
                                      fit: BoxFit.cover
                                  ),
                                ),
                              ),
                              SizedBox(width: 25),
                              Expanded(
                                child: CustomTextField(
                                  defaultValue: 'Иван Иванов',
                                  controller: _nameController,
                                  labelText: 'Имя пользователя',
                                  hintText: 'Введите ваше имя',
                                  borderRadius: 15.0,
                                  labelStyle: TextStyle(
                                    color: Color(0xFF8A4D05),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                  // Секция питомцев
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Красивый заголовок "Мои питомцы"
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFFFB761),
                                width: 3,
                              ),
                            ),
                          ),
                          child: Text(
                            'Мои питомцы',
                            style: TextStyle(
                              color: Color(0xFF8A4D05),
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Кнопка добавления с иконкой
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _addPet,
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: 28,
                              color: Color(0xFF8A4D05),
                            ),
                            label: Text(
                              'Добавить питомца',
                              style: TextStyle(
                                color: Color(0xFF8A4D05),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFFB761),
                              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 5,
                              shadowColor: Color(0xFFFFB761).withOpacity(0.5),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        // Список питомцев
                        ..._pets.asMap().entries.map((entry) {
                          int index = entry.key;
                          return _buildPetCard(index);
                        }).toList(),

                        // Сообщение если нет питомцев
                        if (_pets.isEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 40),
                            padding: EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.pets,
                                  size: 60,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Пока нет добавленных питомцев',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Нажмите кнопку выше, чтобы добавить первого питомца',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade100,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Заголовок карточки питомца
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFFFB761).withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFFFB761).withOpacity(0.3),
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.pets,
                  color: Color(0xFF8A4D05),
                  size: 24,
                ),
                SizedBox(width: 10),
                Text(
                  'Питомец ${index + 1}',
                  style: TextStyle(
                    color: Color(0xFF8A4D05),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    // Аватар питомца с улучшенным дизайном
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFFFB761),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey.shade100,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(11.0),
                        child: _pets[index].photoUrl.isNotEmpty
                            ? Image.network(_pets[index].photoUrl, fit: BoxFit.cover)
                            : Icon(Icons.pets, size: 45, color: Colors.grey.shade400),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CustomTextField(
                        defaultValue: _pets[index].nameController.text.isEmpty
                            ? ''
                            : _pets[index].nameController.text,
                        controller: _pets[index].nameController,
                        labelText: 'Кличка питомца',
                        hintText: 'Введите кличку',
                        borderRadius: 12.0,
                        labelStyle: TextStyle(
                          color: Color(0xFF8A4D05),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Поля ввода в сетке
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 90) / 2 - 25,
                      child: CustomTextField(
                        defaultValue: _pets[index].ageController.text.isEmpty
                            ? ''
                            : _pets[index].ageController.text,
                        controller: _pets[index].ageController,
                        labelText: 'Возраст',
                        hintText: 'лет',
                        borderRadius: 12.0,
                        labelStyle: TextStyle(
                          color: Color(0xFF8A4D05),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 90) / 2 - 25,
                      child: CustomTextField(
                        defaultValue: _pets[index].heightController.text.isEmpty
                            ? ''
                            : _pets[index].heightController.text,
                        controller: _pets[index].heightController,
                        labelText: 'Рост',
                        hintText: 'см',
                        borderRadius: 12.0,
                        labelStyle: TextStyle(
                          color: Color(0xFF8A4D05),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 90) / 2 - 25,
                      child: CustomTextField(
                        defaultValue: _pets[index].weightController.text.isEmpty
                            ? ''
                            : _pets[index].weightController.text,
                        controller: _pets[index].weightController,
                        labelText: 'Вес',
                        hintText: 'кг',
                        borderRadius: 12.0,
                        labelStyle: TextStyle(
                          color: Color(0xFF8A4D05),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Кнопка удаления
                Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _removePet(index),
                    icon: Icon(
                      Icons.delete_outline,
                      size: 22,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Удалить питомца',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addPet() {
    setState(() {
      _pets.add(Pet());
    });
  }

  void _removePet(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Удаление питомца'),
          content: Text('Вы уверены, что хотите удалить этого питомца?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Отмена', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _pets[index].dispose();
                  _pets.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Удалить', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    for (var pet in _pets) {
      pet.dispose();
    }
    _nameController.dispose();
    super.dispose();
  }
}

class Pet {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  String photoUrl;

  Pet()
      : nameController = TextEditingController(),
        ageController = TextEditingController(),
        heightController = TextEditingController(),
        weightController = TextEditingController(),
        photoUrl = '';

  void dispose() {
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
  }
}