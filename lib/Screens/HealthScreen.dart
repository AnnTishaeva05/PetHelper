import 'package:flutter/material.dart';

class HelthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelthScreenState();
  }
}

class _HelthScreenState extends State<HelthScreen> {
  final _formKey = GlobalKey<FormState>();

  // Основная информация о питомце
  String _petName = 'Бадди';
  String _petType = 'Собака';
  DateTime _birthDate = DateTime.now().subtract(Duration(days: 365));
  double _weight = 10.0;
  String _breed = 'Лабрадор';

  // Медицинская информация
  List<Vaccination> _vaccinations = [];
  List<MedicalRecord> _medicalRecords = [];
  List<Medication> _medications = [];

  // Календарь
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDay;

  // Контроллеры для форм
  final _vaccineNameController = TextEditingController();
  final _vaccineDateController = TextEditingController();
  final _nextVaccineDateController = TextEditingController();
  final _medicalNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _addSampleData();
  }

  void _addSampleData() {
    setState(() {
      _vaccinations.addAll([
        Vaccination(
          name: 'Комплексная вакцина',
          date: DateTime.now().subtract(Duration(days: 180)),
          nextDate: DateTime.now().add(Duration(days: 185)),
          notes: 'Первая ежегодная ревакцинация',
        ),
        Vaccination(
          name: 'От бешенства',
          date: DateTime.now().subtract(Duration(days: 200)),
          nextDate: DateTime.now().add(Duration(days: 165)),
          notes: 'Обязательная вакцинация',
        ),
        Vaccination(
          name: 'От лептоспироза',
          date: DateTime.now().subtract(Duration(days: 100)),
          nextDate: DateTime.now().add(Duration(days: 265)),
          notes: 'Сезонная вакцинация',
        ),
      ]);

      _medicalRecords.addAll([
        MedicalRecord(
          date: DateTime.now().subtract(Duration(days: 30)),
          description: 'Плановый осмотр',
          diagnosis: 'Здоров, вес в норме',
          veterinarian: 'Др. Иванов',
        ),
        MedicalRecord(
          date: DateTime.now().subtract(Duration(days: 90)),
          description: 'Обработка от паразитов',
          diagnosis: 'Профилактика блох и клещей',
          veterinarian: 'Др. Петрова',
        ),
        MedicalRecord(
          date: DateTime.now().subtract(Duration(days: 150)),
          description: 'Чистка зубов',
          diagnosis: 'Зубной камень удален',
          veterinarian: 'Др. Сидоров',
        ),
      ]);

      _medications.addAll([
        Medication(
          name: 'Глистогонное',
          dosage: '1 таблетка',
          startDate: DateTime.now().subtract(Duration(days: 10)),
          endDate: DateTime.now(),
          frequency: 'Каждые 3 месяца',
        ),
        Medication(
          name: 'Витамины',
          dosage: '2 мл',
          startDate: DateTime.now().subtract(Duration(days: 30)),
          endDate: null,
          frequency: 'Ежедневно',
        ),
      ]);
    });
  }

  // Метод для форматирования даты
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  // Метод для парсинга даты из строки
  DateTime _parseDate(String dateString) {
    try {
      final parts = dateString.split('.');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      print('Ошибка парсинга даты: $e');
    }
    return DateTime.now();
  }

  void _addVaccination() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Добавить прививку'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _vaccineNameController,
                decoration: InputDecoration(
                  labelText: 'Название вакцины',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _vaccineDateController,
                decoration: InputDecoration(
                  labelText: 'Дата прививки (дд.мм.гггг)',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context, _vaccineDateController),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _nextVaccineDateController,
                decoration: InputDecoration(
                  labelText: 'Следующая прививка (дд.мм.гггг)',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context, _nextVaccineDateController),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена', style: TextStyle(color: Color(0xFF8A4D05))),
          ),
          ElevatedButton(
            onPressed: () {
              if (_vaccineNameController.text.isNotEmpty &&
                  _vaccineDateController.text.isNotEmpty) {
                setState(() {
                  _vaccinations.add(Vaccination(
                    name: _vaccineNameController.text,
                    date: _parseDate(_vaccineDateController.text),
                    nextDate: _nextVaccineDateController.text.isNotEmpty
                        ? _parseDate(_nextVaccineDateController.text)
                        : null,
                  ));
                });
                _vaccineNameController.clear();
                _vaccineDateController.clear();
                _nextVaccineDateController.clear();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Прививка добавлена!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFDC95E),
              foregroundColor: Color(0xFF8A4D05),
            ),
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _addMedicalRecord() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Добавить запись о здоровье'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _medicalNoteController,
                decoration: InputDecoration(
                  labelText: 'Описание посещения',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Диагноз (если есть)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Ветеринар',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена', style: TextStyle(color: Color(0xFF8A4D05))),
          ),
          ElevatedButton(
            onPressed: () {
              if (_medicalNoteController.text.isNotEmpty) {
                setState(() {
                  _medicalRecords.add(MedicalRecord(
                    date: DateTime.now(),
                    description: _medicalNoteController.text,
                  ));
                });
                _medicalNoteController.clear();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Запись добавлена!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFDC95E),
              foregroundColor: Color(0xFF8A4D05),
            ),
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = _formatDate(picked);
    }
  }

  List<Vaccination> _getVaccinationsForDay(DateTime day) {
    return _vaccinations.where((vaccination) =>
    vaccination.date.year == day.year &&
        vaccination.date.month == day.month &&
        vaccination.date.day == day.day
    ).toList();
  }

  List<MedicalRecord> _getMedicalRecordsForDay(DateTime day) {
    return _medicalRecords.where((record) =>
    record.date.year == day.year &&
        record.date.month == day.month &&
        record.date.day == day.day
    ).toList();
  }

  List<Vaccination> _getUpcomingVaccinations() {
    final now = DateTime.now();
    return _vaccinations.where((vaccination) =>
    vaccination.nextDate != null && vaccination.nextDate!.isAfter(now)
    ).toList();
  }

  List<MedicalRecord> _getRecentMedicalRecords() {
    final now = DateTime.now();
    return _medicalRecords.where((record) =>
        record.date.isAfter(now.subtract(Duration(days: 30)))
    ).toList();
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  List<DateTime> _getDaysInMonth() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final days = <DateTime>[];

    // Добавляем дни предыдущего месяца для заполнения первой недели
    for (var i = 0; i < firstDay.weekday - 1; i++) {
      days.add(DateTime(firstDay.year, firstDay.month, 1 - (firstDay.weekday - 1 - i)));
    }

    // Добавляем дни текущего месяца
    for (var i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    return days;
  }

  String _formatMonthYear(DateTime date) {
    final months = [
      'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
      'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final upcomingVaccinations = _getUpcomingVaccinations();
    final recentRecords = _getRecentMedicalRecords();

    return Scaffold(
      body: Column(
        children: [
          // Кастомный заголовок вместо AppBar
          _buildHeaderContainer(),
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    color: Color(0xFFFDC95E),
                    child: TabBar(
                      labelColor: Color(0xFF8A4D05),
                      unselectedLabelColor: Color(0xFF8A4D05).withOpacity(0.6),
                      indicatorColor: Color(0xFF8A4D05),
                      tabs: [
                        Tab(text: 'Обзор', icon: Icon(Icons.dashboard)),
                        Tab(text: 'Прививки', icon: Icon(Icons.medical_services)),
                        Tab(text: 'История', icon: Icon(Icons.history)),
                        Tab(text: 'Календарь', icon: Icon(Icons.calendar_today)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildOverviewTab(upcomingVaccinations, recentRecords),
                        _buildVaccinationsTab(),
                        _buildHistoryTab(),
                        _buildCalendarTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMedicalRecord,
        backgroundColor: Color(0xFFFDC95E),
        foregroundColor: Color(0xFF8A4D05),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeaderContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFDC95E),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.medical_services,
            size: 40,
            color: Color(0xFF8A4D05),
          ),
          SizedBox(height: 8),
          Text(
            'Здоровье питомца',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8A4D05),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Медицинская карта вашего любимца',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8A4D05),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(List<Vaccination> upcomingVaccinations, List<MedicalRecord> recentRecords) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPetInfoCard(),
          SizedBox(height: 16),
          _buildHealthStatsCard(),
          SizedBox(height: 16),
          _buildUpcomingVaccinationsCard(upcomingVaccinations),
          SizedBox(height: 16),
          _buildRecentRecordsCard(recentRecords),
          SizedBox(height: 16),
          _buildQuickActionsCard(),
        ],
      ),
    );
  }

  Widget _buildPetInfoCard() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFFDC95E),
                  child: Icon(Icons.pets, color: Color(0xFF8A4D05)),
                  radius: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _petName,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('$_petType • $_breed'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 8),
            _buildInfoRow('Дата рождения', _formatDate(_birthDate)),
            _buildInfoRow('Возраст', _calculateAge()),
            _buildInfoRow('Вес', '${_weight.toStringAsFixed(1)} кг'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildHealthStatsCard() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Статистика здоровья',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Прививки', _vaccinations.length.toString(), Icons.medical_services),
                _buildStatItem('Записи', _medicalRecords.length.toString(), Icons.note),
                _buildStatItem('Лекарства', _medications.length.toString(), Icons.medication),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFDC95E).withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: Color(0xFF8A4D05)),
        ),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildUpcomingVaccinationsCard(List<Vaccination> upcoming) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Предстоящие прививки',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Color(0xFF8A4D05)),
                  onPressed: _addVaccination,
                ),
              ],
            ),
            SizedBox(height: 12),
            if (upcoming.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Нет предстоящих прививок',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ...upcoming.take(3).map((vaccination) => ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.medical_services, size: 20, color: Colors.green),
              ),
              title: Text(vaccination.name),
              subtitle: Text('Следующая: ${_formatDate(vaccination.nextDate!)}'),
              trailing: Chip(
                label: Text('${vaccination.nextDate!.difference(DateTime.now()).inDays} дн.'),
                backgroundColor: Colors.green[50],
                labelStyle: TextStyle(color: Colors.green[800]),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentRecordsCard(List<MedicalRecord> recentRecords) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Последние записи',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            if (recentRecords.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Нет недавних записей',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ...recentRecords.take(3).map((record) => ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.medical_services, size: 20, color: Colors.blue),
              ),
              title: Text(record.description),
              subtitle: Text(_formatDate(record.date)),
              trailing: record.diagnosis != null
                  ? Chip(
                label: Text('Осмотр', style: TextStyle(fontSize: 12)),
                backgroundColor: Colors.blue[50],
              )
                  : null,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Быстрые действия',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionChip(
                  avatar: Icon(Icons.medical_services, size: 18, color: Color(0xFF8A4D05)),
                  label: Text('Добавить прививку', style: TextStyle(color: Color(0xFF8A4D05))),
                  onPressed: _addVaccination,
                  backgroundColor: Color(0xFFFDC95E),
                ),
                ActionChip(
                  avatar: Icon(Icons.note_add, size: 18, color: Color(0xFF8A4D05)),
                  label: Text('Мед. запись', style: TextStyle(color: Color(0xFF8A4D05))),
                  onPressed: _addMedicalRecord,
                  backgroundColor: Color(0xFFFDC95E),
                ),
                ActionChip(
                  avatar: Icon(Icons.medication, size: 18, color: Color(0xFF8A4D05)),
                  label: Text('Лекарство', style: TextStyle(color: Color(0xFF8A4D05))),
                  onPressed: () {},
                  backgroundColor: Color(0xFFFDC95E),
                ),
                ActionChip(
                  avatar: Icon(Icons.notifications, size: 18, color: Color(0xFF8A4D05)),
                  label: Text('Напоминание', style: TextStyle(color: Color(0xFF8A4D05))),
                  onPressed: () {},
                  backgroundColor: Color(0xFFFDC95E),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVaccinationsTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'История прививок',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _addVaccination,
                icon: Icon(Icons.add),
                label: Text('Добавить'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFDC95E),
                  foregroundColor: Color(0xFF8A4D05),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _vaccinations.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.medical_services, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('Нет данных о прививках', style: TextStyle(color: Colors.grey)),
              ],
            ),
          )
              : ListView.builder(
            itemCount: _vaccinations.length,
            itemBuilder: (context, index) {
              final vaccination = _vaccinations[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.medical_services, color: Colors.green),
                  ),
                  title: Text(vaccination.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text('Дата: ${_formatDate(vaccination.date)}'),
                      if (vaccination.nextDate != null)
                        Text('Следующая: ${_formatDate(vaccination.nextDate!)}'),
                      if (vaccination.notes != null)
                        Text('Примечания: ${vaccination.notes!}', style: TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (vaccination.nextDate != null && vaccination.nextDate!.isAfter(DateTime.now()))
                        Chip(
                          label: Text('${vaccination.nextDate!.difference(DateTime.now()).inDays} дн.'),
                          backgroundColor: Colors.green[100],
                        ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteDialog(context, 'прививку', () {
                            setState(() {
                              _vaccinations.removeAt(index);
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Медицинская история',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _addMedicalRecord,
                icon: Icon(Icons.add),
                label: Text('Добавить'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFDC95E),
                  foregroundColor: Color(0xFF8A4D05),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _medicalRecords.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('Нет медицинских записей', style: TextStyle(color: Colors.grey)),
              ],
            ),
          )
              : ListView.builder(
            itemCount: _medicalRecords.length,
            itemBuilder: (context, index) {
              final record = _medicalRecords[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.medical_services, color: Colors.blue),
                  ),
                  title: Text(record.description, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text('${_formatDate(record.date)}'),
                      if (record.diagnosis != null)
                        Text('Диагноз: ${record.diagnosis!}'),
                      if (record.veterinarian != null)
                        Text('Ветеринар: ${record.veterinarian!}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteDialog(context, 'запись', () {
                        setState(() {
                          _medicalRecords.removeAt(index);
                        });
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarTab() {
    final daysInMonth = _getDaysInMonth();
    final monthName = _formatMonthYear(_currentMonth);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Заголовок календаря
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left),
                        onPressed: _previousMonth,
                      ),
                      Text(
                        monthName,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: _nextMonth,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Дни недели
                  Row(
                    children: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс']
                        .map((day) => Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                  // Ячейки календаря
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: daysInMonth.length,
                    itemBuilder: (context, index) {
                      final day = daysInMonth[index];
                      final isCurrentMonth = day.month == _currentMonth.month;
                      final isToday = isSameDay(day, DateTime.now());
                      final isSelected = isSameDay(day, _selectedDay);
                      final hasVaccinations = _getVaccinationsForDay(day).isNotEmpty;
                      final hasRecords = _getMedicalRecordsForDay(day).isNotEmpty;

                      return GestureDetector(
                        onTap: () => setState(() => _selectedDay = day),
                        child: Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xFF8A4D05) :
                            isToday ? Color(0xFFFDC95E).withOpacity(0.3) :
                            Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: isToday ? Border.all(color: Color(0xFF8A4D05)) : null,
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  day.day.toString(),
                                  style: TextStyle(
                                    color: isCurrentMonth
                                        ? (isSelected ? Colors.white : Colors.black)
                                        : Colors.grey[400],
                                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                              if (hasVaccinations || hasRecords)
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: hasVaccinations ? Colors.green : Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // События выбранного дня
          if (_selectedDay != null) ..._buildDayEvents(_selectedDay!),
        ],
      ),
    );
  }

  List<Widget> _buildDayEvents(DateTime day) {
    final vaccinations = _getVaccinationsForDay(day);
    final records = _getMedicalRecordsForDay(day);

    return [
      if (vaccinations.isNotEmpty || records.isNotEmpty) ...[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'События на ${_formatDate(day)}:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
      ],
      if (vaccinations.isNotEmpty) ...vaccinations.map((vaccination) => Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        color: Colors.green[50],
        child: ListTile(
          leading: Icon(Icons.medical_services, color: Colors.green),
          title: Text(vaccination.name),
          subtitle: Text('Прививка • ${vaccination.notes ?? ''}'),
        ),
      )),
      if (records.isNotEmpty) ...records.map((record) => Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        color: Colors.blue[50],
        child: ListTile(
          leading: Icon(Icons.medical_services, color: Colors.blue),
          title: Text(record.description),
          subtitle: Text('Мед. запись • ${record.diagnosis ?? ''}'),
        ),
      )),
      if (vaccinations.isEmpty && records.isEmpty)
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'На этот день нет событий',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
    ];
  }

  void _showDeleteDialog(BuildContext context, String itemName, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Удалить $itemName?'),
        content: Text('Это действие нельзя отменить.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена', style: TextStyle(color: Color(0xFF8A4D05))),
          ),
          TextButton(
            onPressed: () {
              onDelete();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$itemName удалена!')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Удалить'),
          ),
        ],
      ),
    );
  }

  String _calculateAge() {
    final now = DateTime.now();
    final difference = now.difference(_birthDate);
    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;

    if (years == 0) {
      return '$months мес.';
    } else if (months == 0) {
      return '$years ${_getYearsText(years)}';
    } else {
      return '$years ${_getYearsText(years)} $months мес.';
    }
  }

  String _getYearsText(int years) {
    if (years % 10 == 1 && years % 100 != 11) return 'год';
    if (years % 10 >= 2 && years % 10 <= 4 && (years % 100 < 10 || years % 100 >= 20)) return 'года';
    return 'лет';
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class Vaccination {
  final String name;
  final DateTime date;
  final DateTime? nextDate;
  final String? notes;

  Vaccination({
    required this.name,
    required this.date,
    this.nextDate,
    this.notes,
  });
}

class MedicalRecord {
  final DateTime date;
  final String description;
  final String? diagnosis;
  final String? veterinarian;

  MedicalRecord({
    required this.date,
    required this.description,
    this.diagnosis,
    this.veterinarian,
  });
}

class Medication {
  final String name;
  final String dosage;
  final DateTime startDate;
  final DateTime? endDate;
  final String frequency;

  Medication({
    required this.name,
    required this.dosage,
    required this.startDate,
    this.endDate,
    required this.frequency,
  });
}