import 'package:flutter/material.dart';
import 'package:pr_11/src/models/game_model.dart';
import 'package:pr_11/src/ui/components/game_card.dart';


class EditGamePage extends StatefulWidget {
  const EditGamePage({super.key, required this.game});
  final Game game;
  @override
  State<EditGamePage> createState() => _EditGamePage();
}

class _EditGamePage extends State<EditGamePage> {

  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _gamersController = TextEditingController();
  final TextEditingController _rulesController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  late String selectedColor;
  final List<String> colorNames = ["Желтый", "Розовый", "Синий"];

  bool get _isFormValid {
    return _imageUrlController.text.isNotEmpty &&
        _titleController.text.isNotEmpty; }

  @override
  void initState() {
    super.initState();
    _imageUrlController.text = widget.game.image;
    _titleController.text = widget.game.name;
    _priceController.text = widget.game.price.toString();
    _descriptionController.text = widget.game.description;
    _ageController.text = widget.game.age.toString();
    _gamersController.text = widget.game.gamers;
    _rulesController.text = widget.game.rules;
    _timeController.text = widget.game.gameTime;
    selectedColor = colorNames[widget.game.colorInd - 1];
  }

  void _updateGameInfo() {
    Navigator.pop(context, Game(
        id: widget.game.id,
        name: _titleController.text,
        image: _imageUrlController.text,
        description: _descriptionController.text,
        rules: _rulesController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        gamers: _gamersController.text,
        gameTime: _timeController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        colorInd: colorNames.indexOf(selectedColor) + 1,
        stock: 0
    ));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактирование игры',
          style: TextStyle(
            color: Color.fromRGBO(76, 23, 0, 1.0),
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              top: 5.0
          ),
          child: Column(
            children: [

              if(_isFormValid)
                (colorNames.indexOf(selectedColor) + 1 == 1)?
                GameCard(game: Game(
                    id: widget.game.id,
                    name: _titleController.text,
                    image: _imageUrlController.text,
                    description: _descriptionController.text,
                    rules: _rulesController.text,
                    age: int.tryParse(_ageController.text) ?? 0,
                    gamers: _gamersController.text,
                    gameTime: _timeController.text,
                    price: double.tryParse(_priceController.text) ?? 0,
                    colorInd: colorNames.indexOf(selectedColor) + 1,
                    stock: 0
                ),
                  bodyColor: const Color.fromRGBO(255, 207, 2, 1.0),
                  textColor: const Color.fromRGBO(129, 40, 0, 1.0),
                )
                    : (colorNames.indexOf(selectedColor) + 1 == 2) ?
                GameCard(game: Game(
                    id: widget.game.id,
                    name: _titleController.text,
                    image: _imageUrlController.text,
                    description: _descriptionController.text,
                    rules: _rulesController.text,
                    age: int.tryParse(_ageController.text) ?? 0,
                    gamers: _gamersController.text,
                    gameTime: _timeController.text,
                    price: double.tryParse(_priceController.text) ?? 0,
                    colorInd: colorNames.indexOf(selectedColor) + 1,
                    stock: 0
                ),
                  bodyColor: const Color.fromRGBO(163, 3, 99, 1.0),
                  textColor: const Color.fromRGBO(255, 204, 254, 1.0),
                ):
                GameCard(game: Game(
                    id: widget.game.id,
                    name: _titleController.text,
                    image: _imageUrlController.text,
                    description: _descriptionController.text,
                    rules: _rulesController.text,
                    age: int.tryParse(_ageController.text) ?? 0,
                    gamers: _gamersController.text,
                    gameTime: _timeController.text,
                    price: double.tryParse(_priceController.text) ?? 0,
                    colorInd: colorNames.indexOf(selectedColor) + 1,
                    stock: 0
                ),
                  bodyColor: const Color.fromRGBO(48, 0, 155, 1.0),
                  textColor: const Color.fromRGBO(203, 238, 251, 1.0),
                ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL картинки'),
                onChanged: (_) {
                  setState(() {});
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Обязательное поле';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название товара'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Обязательное поле';
                  }
                  return null;
                },
                onChanged: (_) {
                  setState(() {});
                },
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Цена (в рублях)'),
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  setState(() {});
                },
              ),

              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Возрастное ограничение'),
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  setState(() {});
                },
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Описание товара (кратко)'),
                onChanged: (_) {
                  setState(() {});
                },
              ),
              SizedBox(
                width: 400,
                height: 50,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:  Color.fromRGBO(76, 23, 0, 0.8),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: selectedColor,
                    hint: const Text('Выберите цвет'),
                    items: colorNames
                        .map((color) => DropdownMenuItem<String>(
                      value: color,
                      child: Text(color),
                    ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedColor = value!;
                      });
                    },
                    isExpanded: true,
                    underline: const SizedBox(),
                    alignment: Alignment.centerLeft,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                    iconEnabledColor: const Color.fromRGBO(76, 23, 0, 1.0),
                    style: const TextStyle(fontSize: 16,
                      color: Color.fromRGBO(76, 23, 0, 1.0),
                    ),

                  ),
                ),
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Среднее время на игру'),
              ),
              TextField(
                controller: _gamersController,
                decoration: const InputDecoration(labelText: 'Количество игроков'),
              ),


              TextField(
                controller: _rulesController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(labelText: 'Правила игры'),
              ),


              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isFormValid ? _updateGameInfo : null,

                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(400, 40),
                    textStyle: const TextStyle(
                      fontSize: 16,
                    )
                ),
                child: const Text('Сохранить изменения'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
