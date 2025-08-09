import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_text_field.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const double _defaultMinPrice = 0;
  static const double _defaultMaxPrice = 100000;
  static const int _defaultMinYear = 2000;
  static const int _defaultMaxYear = 2025;
  static const Color _backgroundOverlayColor = Color(0xFF1E1E1E);
  static const double _cardOpacity = 0.9;

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  final TextEditingController _minYearController = TextEditingController();
  final TextEditingController _maxYearController = TextEditingController();

  String _selectedCategory = 'All';
  double _minPrice = _defaultMinPrice;
  double _maxPrice = _defaultMaxPrice;
  int _minYear = _defaultMinYear;
  int _maxYear = _defaultMaxYear;

  final List<String> _categories = [
    "All",
    'Aston Martin (UK)',
    'Audi (Germany)',
    'Bentley (UK)',
    'BMW (Germany)',
    'Chery (China)',
    'Chevrolet (USA)',
    'Citroen (France)',
    'Ford (USA)',
    'Genesis (South Korea)',
    'General Motors (USA)',
    'Honda (Japan)',
    'Hyundai (South Korea)',
    'Jaguar (UK)',
    'Jeep (USA)',
    'Land Rover (UK)',
    'Lotus (UK)',
    'Lucid (USA)',
    'Maserati (Italy)',
    'Maybach (Germany)',
    'McLaren (UK)',
    'Mercedes-Benz (Germany)',
    'Nissan (Japan)',
    'Peugeot (France)',
    'Renault (France)',
    'Rolls-Royce (UK)',
    'Stellantis (Multinational)',
    'Suzuki (Japan)',
    'Toyota (Japan)',
    'Venturi (France)',
    'Volkswagen (Germany)',
  ];

  final List<Map<String, dynamic>> _cars = [
    {
      'name': 'Toyota Camry',
      'category': 'Toyota (Japan)',
      'price': 30000,
      'year': 2023,
    },
    {
      'name': 'BMW X5',
      'category': 'BMW (Germany)',
      'price': 60000,
      'year': 2022,
    },
    {
      'name': 'Ford Mustang',
      'category': 'Ford (USA)',
      'price': 45000,
      'year': 2021,
    },
    {
      'name': 'Audi A4',
      'category': 'Audi (Germany)',
      'price': 40000,
      'year': 2020,
    },
  ];

  List<Map<String, dynamic>> _filteredCars = [];

  @override
  void initState() {
    super.initState();
    _filteredCars = List.from(_cars);
    _initializeControllers();
    _addListeners();
  }

  void _initializeControllers() {
    _minPriceController.text = _minPrice.toStringAsFixed(0);
    _maxPriceController.text = _maxPrice.toStringAsFixed(0);
    _minYearController.text = _minYear.toString();
    _maxYearController.text = _maxYear.toString();
  }

  void _addListeners() {
    _searchController.addListener(_filterCars);
    _minPriceController.addListener(_filterCars);
    _maxPriceController.addListener(_filterCars);
    _minYearController.addListener(_filterCars);
    _maxYearController.addListener(_filterCars);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _minYearController.dispose();
    _maxYearController.dispose();
    super.dispose();
  }

  void _filterCars() {
    setState(() {
      _minPrice = double.tryParse(_minPriceController.text) ?? _defaultMinPrice;
      _maxPrice = double.tryParse(_maxPriceController.text) ?? _defaultMaxPrice;
      _minYear = int.tryParse(_minYearController.text) ?? _defaultMinYear;
      _maxYear = int.tryParse(_maxYearController.text) ?? _defaultMaxYear;

      _filteredCars = _cars.where(_applyFilters).toList();
    });
  }

  bool _applyFilters(Map<String, dynamic> car) {
    final matchesSearch = car['name'].toString().toLowerCase().contains(
      _searchController.text.toLowerCase(),
    );
    final matchesCategory =
        _selectedCategory == 'All' || car['category'] == _selectedCategory;
    final matchesPrice = car['price'] >= _minPrice && car['price'] <= _maxPrice;
    final matchesYear = car['year'] >= _minYear && car['year'] <= _maxYear;
    return matchesSearch && matchesCategory && matchesPrice && matchesYear;
  }

  void _onApplyFilters() {
    _filterCars();
    CustomSnackBar.show(
      context,
      message: 'Filters applied!',
      type: SnackBarType.success,
    );
  }

  Widget _buildSearchBar() {
    return CustomTextField(
      controller: _searchController,
      hintText: 'Search by car name...',
      prefixIcon: const Icon(Icons.search, color: Colors.white70),
    );
  }

  Widget _buildFiltersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txt: 'Filters',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        const SizedBox(height: 10),
        _buildCategoryDropdown(),
        const SizedBox(height: 10),
        _buildPriceRangeFields(),
        const SizedBox(height: 10),
        _buildYearRangeFields(),
        const SizedBox(height: 20),
        _buildApplyButton(),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      decoration: InputDecoration(
        filled: true,
        fillColor: _backgroundOverlayColor.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: _backgroundOverlayColor,
      style: const TextStyle(color: Colors.white),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
      items: _categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: CustomText(txt: category, color: Colors.white),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value!;
          _filterCars();
        });
      },
    );
  }

  Widget _buildPriceRangeFields() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _minPriceController,
            hintText: 'Min Price',
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextField(
            controller: _maxPriceController,
            hintText: 'Max Price',
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildYearRangeFields() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _minYearController,
            hintText: 'Min Year',
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextField(
            controller: _maxYearController,
            hintText: 'Max Year',
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return CustomButton(
      backgroundColor: const Color(0xFF2E4A62),
      content: CustomText(
        txt: 'Apply Filters',
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      onPressed: _onApplyFilters,
    );
  }

  Widget _buildResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txt: 'Results (${_filteredCars.length} cars)',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        const SizedBox(height: 10),
        _buildCarList(),
      ],
    );
  }

  Widget _buildCarList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredCars.length,
      itemBuilder: (context, index) {
        final car = _filteredCars[index];
        return Card(
          color: _backgroundOverlayColor.withOpacity(_cardOpacity),
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const Icon(Icons.directions_car, color: Colors.white70),
            title: CustomText(txt: car['name'], color: Colors.white),
            subtitle: CustomText(
              txt: 'Price: \$${car['price']} | Year: ${car['year']}',
              color: Colors.white70,
            ),
            onTap: () {
              GoRouter.of(context).push(
                RouteNames.carDetail,
                extra: {
                  'carName': car['name'],
                  'manufacturer': car['category'].split(' (')[0],
                  'model': car['name'].split(' ').last,
                  'year': car['year'].toString(),
                  'fuelType': 'Petrol',
                  'mileage': '15000',
                  'price': car['price'].toString(),
                  'imagePath': 'assets/car2.jpg',
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: CustomText(
          txt: 'Search Cars',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/car1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildFiltersSection(),
              const SizedBox(height: 20),
              _buildResultsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
