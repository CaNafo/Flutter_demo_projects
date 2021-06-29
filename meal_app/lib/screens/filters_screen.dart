import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> _initFilters;

  FiltersScreen(this.saveFilters, this._initFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegan = false;
  var _vegetarian = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget._initFilters['glutenFree'];
    _vegan = widget._initFilters['vegan'];
    _vegetarian = widget._initFilters['vegeterian'];
    _lactoseFree = widget._initFilters['lactoseFree'];
    super.initState();
  }

  Widget buildSwitchListTile(
    String title,
    String subtitle,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: currentValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
              onPressed: () {
                final filters = {
                  'glutenFree': _glutenFree,
                  'lactoseFree': _lactoseFree,
                  'vegeterian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.saveFilters(filters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Your meal selection",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchListTile(
                  "Gluten free", "Only include gluten free meals", _glutenFree,
                  (val) {
                setState(() {
                  _glutenFree = val;
                });
              }),
              buildSwitchListTile("Lactose free",
                  "Only include lactose free meals", _lactoseFree, (val) {
                setState(() {
                  _lactoseFree = val;
                });
              }),
              buildSwitchListTile(
                  "Vegeterian", "Only include vegeterian meals", _vegetarian,
                  (val) {
                setState(() {
                  _vegetarian = val;
                });
              }),
              buildSwitchListTile("Vegan", "Only include vegan meals", _vegan,
                  (val) {
                setState(() {
                  _vegan = val;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
