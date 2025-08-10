import 'dart:async';
import 'package:carraze/core/models/car_model.dart';
import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_text_field.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/features/home/cubit/get_cars_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Timer? _debounceTimer;

  String _selectedCategory = 'All';
  List<Car> _cars = [];
  List<Car> _filteredCars = [];
  bool _isInitialLoad = true;

  static const List<String> _categories = [
    'All',
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

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _addTextListeners();
    context.read<GetCarsCubit>().fetchCars();
  }

  void _initializeControllers() {
    _minPriceController.text = _defaultMinPrice.toStringAsFixed(0);
    _maxPriceController.text = _defaultMaxPrice.toStringAsFixed(0);
    _minYearController.text = _defaultMinYear.toString();
    _maxYearController.text = _defaultMaxYear.toString();
  }

  void _addTextListeners() {
    _searchController.addListener(_debouncedFilterCars);
    _minPriceController.addListener(_debouncedFilterCars);
    _maxPriceController.addListener(_debouncedFilterCars);
    _minYearController.addListener(_debouncedFilterCars);
    _maxYearController.addListener(_debouncedFilterCars);
  }

  void _debouncedFilterCars() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), _filterCars);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.removeListener(_debouncedFilterCars);
    _minPriceController.removeListener(_debouncedFilterCars);
    _maxPriceController.removeListener(_debouncedFilterCars);
    _minYearController.removeListener(_debouncedFilterCars);
    _maxYearController.removeListener(_debouncedFilterCars);
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _minYearController.dispose();
    _maxYearController.dispose();
    super.dispose();
  }

  void _filterCars() {
    final minPrice =
        double.tryParse(_minPriceController.text) ?? _defaultMinPrice;
    final maxPrice =
        double.tryParse(_maxPriceController.text) ?? _defaultMaxPrice;
    final minYear = int.tryParse(_minYearController.text) ?? _defaultMinYear;
    final maxYear = int.tryParse(_maxYearController.text) ?? _defaultMaxYear;

    setState(() {
      _filteredCars = _cars.where((car) {
        final matchesSearch = car.carName.toLowerCase().contains(
          _searchController.text.toLowerCase(),
        );
        final matchesCategory =
            _selectedCategory == 'All' || car.manufacturer == _selectedCategory;
        final carPrice = double.tryParse(car.price.toString()) ?? 0;
        final matchesPrice = carPrice >= minPrice && carPrice <= maxPrice;
        final carYear = int.tryParse(car.year.toString()) ?? _defaultMinYear;
        final matchesYear = carYear >= minYear && carYear <= maxYear;
        return matchesSearch && matchesCategory && matchesPrice && matchesYear;
      }).toList();
    });
  }

  void _applyFilters() {
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
      items: _categories
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: CustomText(txt: category, color: Colors.white),
            ),
          )
          .toList(),
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
      onPressed: _applyFilters,
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

  Widget _buildCarCard(Car car) {
    return Card(
      color: _backgroundOverlayColor.withOpacity(_cardOpacity),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: car.imagePath.isNotEmpty
              ? NetworkImage(car.imagePath)
              : const AssetImage('assets/placeholder.jpg') as ImageProvider,
          radius: 30,
        ),
        title: CustomText(txt: car.carName, color: Colors.white),
        subtitle: CustomText(
          txt: 'Price: \$${car.price} | Year: ${car.year}',
          color: Colors.white70,
        ),
        onTap: () =>
            GoRouter.of(context).push(RouteNames.carDetail, extra: car),
      ),
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _filteredCars.length,
          itemBuilder: (context, index) => _buildCarCard(_filteredCars[index]),
        ),
      ],
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
            image: AssetImage('assets/car1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocConsumer<GetCarsCubit, GetCarsState>(
          listener: (context, state) {
            if (state is GetCarsSuccess && _isInitialLoad) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _cars = state.cars;
                  _filteredCars = _cars;
                  _filterCars();
                  _isInitialLoad = false;
                });
              });
            }
          },
          builder: (context, state) {
            if (state is GetCarsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetCarsSuccess) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
              );
            } else if (state is GetCarsFailure) {
              return Center(
                child: CustomText(
                  txt: state.message,
                  color: Colors.red,
                  fontSize: 16,
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
