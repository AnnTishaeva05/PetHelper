import 'package:flutter/material.dart';

class FoodScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FoodScreenState();
  }
}

class _FoodScreenState extends State<FoodScreen> {
  final _formKey = GlobalKey<FormState>();

  // Основные параметры
  double _weight = 10.0;
  FoodType? _foodType = FoodType.dry;
  double _baseCoefficient = 0.015;

  // Индивидуальные факторы (корректировки)
  double _activityLevel = 0.0;
  double _ageFactor = 0.0;
  double _environmentFactor = 0.0;
  double _healthFactor = 0.0;

  // Результат
  double _dailyNorm = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateNorm();
  }

  void _calculateNorm() {
    // Базовый расчет
    double baseNorm = _weight * _baseCoefficient * 1000; // в граммах

    // Суммарная корректировка
    double totalAdjustment = _activityLevel +
        _ageFactor +
        _environmentFactor +
        _healthFactor;

    // Финальный расчет
    double adjustedNorm = baseNorm * (1 + totalAdjustment / 100);

    setState(() {
      _dailyNorm = double.parse(adjustedNorm.toStringAsFixed(0));
    });
  }

  void _updateFoodType(FoodType? type) {
    if (type == null) return;

    setState(() {
      _foodType = type;
      _baseCoefficient = type == FoodType.dry ? 0.015 : 0.02;
      _calculateNorm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderContainer(),
              SizedBox(height: 16),
              _buildBasicInfoSection(),
              SizedBox(height: 24),
              _buildFactorsSection(),
              SizedBox(height: 32),
              _buildResultSection(),
              SizedBox(height: 16),
              _buildInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFB761).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.pets,
            size: 40,
            color: Color(0xFF8A4D05),
          ),
          SizedBox(height: 8),
          Text(
            'Калькулятор нормы корма',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8A4D05),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            'Рассчитайте суточную норму питания для вашего питомца',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8A4D05),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Основная информация',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Вес животного
            Row(
              children: [
                Expanded(
                  child: Text('Вес животного: ${_weight.toStringAsFixed(1)} кг'),
                ),
                Text('${(_weight * 1000).toStringAsFixed(0)} г'),
              ],
            ),
            Slider(
              value: _weight,
              min: 1.0,
              max: 100.0,
              divisions: 99,
              activeColor: Color(0xFF8A4D05),
              inactiveColor: Colors.grey[300],
              thumbColor: Color(0xFF8A4D05),
              onChanged: (value) {
                setState(() {
                  _weight = value;
                  _calculateNorm();
                });
              },
            ),

            SizedBox(height: 16),

            // Тип корма
            Text('Тип корма:'),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<FoodType>(
                    title: Text('Сухой корм (1.5%)'),
                    value: FoodType.dry,
                    groupValue: _foodType,
                    activeColor: Color(0xFF8A4D05),
                    onChanged: _updateFoodType,
                  ),
                ),
                Expanded(
                  child: RadioListTile<FoodType>(
                    title: Text('Натуральный (2%)'),
                    value: FoodType.natural,
                    groupValue: _foodType,
                    activeColor: Color(0xFF8A4D05),
                    onChanged: _updateFoodType,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactorsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Индивидуальные факторы',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Выберите подходящие вашему питомцу факторы:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),

            _buildFactorSlider(
              'Уровень активности',
              _activityLevel,
              -20.0,
              40.0,
                  (value) {
                setState(() {
                  _activityLevel = value;
                  _calculateNorm();
                });
              },
              leftLabel: 'Низкая (-20%)',
              rightLabel: 'Высокая (+40%)',
            ),

            _buildFactorSlider(
              'Возраст и рост',
              _ageFactor,
              -15.0,
              100.0,
                  (value) {
                setState(() {
                  _ageFactor = value;
                  _calculateNorm();
                });
              },
              leftLabel: 'Пожилой (-15%)',
              rightLabel: 'Щенок/рост (+100%)',
            ),

            _buildFactorSlider(
              'Условия содержания',
              _environmentFactor,
              -10.0,
              20.0,
                  (value) {
                setState(() {
                  _environmentFactor = value;
                  _calculateNorm();
                });
              },
              leftLabel: 'Квартира (-10%)',
              rightLabel: 'Улица/холод (+20%)',
            ),

            _buildFactorSlider(
              'Здоровье и кондиция',
              _healthFactor,
              -25.0,
              15.0,
                  (value) {
                setState(() {
                  _healthFactor = value;
                  _calculateNorm();
                });
              },
              leftLabel: 'Лишний вес (-25%)',
              rightLabel: 'Недостаток веса (+15%)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactorSlider(
      String title,
      double value,
      double min,
      double max,
      Function(double) onChanged, {
        String leftLabel = '',
        String rightLabel = '',
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              '${value > 0 ? '+' : ''}${value.toStringAsFixed(0)}%',
              style: TextStyle(
                color: value > 0 ? Colors.green : value < 0 ? Colors.red : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          activeColor: Color(0xFF8A4D05),
          inactiveColor: Colors.grey[300],
          thumbColor: Color(0xFF8A4D05),
          onChanged: onChanged,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftLabel,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              rightLabel,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildResultSection() {
    return Card(
      color: Color(0xFFFFF9E6), // Приятный бежево-кремовый цвет
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'РЕКОМЕНДУЕМАЯ СУТОЧНАЯ НОРМА',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A4D05),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${_dailyNorm.toStringAsFixed(0)} г/день',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A4D05),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Рекомендуется разделить на 2-3 приема пищи',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8A4D05),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Важная информация',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A4D05),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '• Данная формула является стартовой точкой\n'
                  '• Регулярно оценивайте кондицию тела питомца\n'
                  '• При лишнем весе уменьшите норму на 5-10%\n'
                  '• При недостатке веса увеличьте на 5-10%\n'
                  '• При серьезных заболеваниях обратитесь к ветеринару',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum FoodType { dry, natural }