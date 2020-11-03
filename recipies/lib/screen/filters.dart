import 'package:flutter/material.dart';
import 'package:recipies/widget/main_drawer.dart';

class Filters extends StatefulWidget {
  static const routeName = "/filters";
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  Filters(this.currentFilters,this.saveFilters);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  Widget _buildSwitchListTile({
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  }) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      onChanged: updateValue,
      subtitle: Text(description),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFree = widget.currentFilters["gluten"];
    _lactoseFree = widget.currentFilters["lactose"];
    _vegeterian = widget.currentFilters["vegetarian"];
    _vegan = widget.currentFilters["vegan"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  "gluten": _glutenFree,
                  "vegan": _vegan,
                  "vegetarian": _vegeterian,
                  "lactose": _lactoseFree,
                };
                widget.saveFilters(selectedFilters);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  title: "Gluten free",
                  description: "Only include gluten-free meals",
                  currentValue: _glutenFree,
                  updateValue: (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                      print(_glutenFree);
                    });
                  },
                ),
                _buildSwitchListTile(
                  title: "Lactose free",
                  description: "Only include lactose-free meals",
                  currentValue: _lactoseFree,
                  updateValue: (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                      print(_lactoseFree);
                    });
                  },
                ),
                _buildSwitchListTile(
                  title: "Vegetarian",
                  description: "Only include vegeterian meals",
                  currentValue: _vegeterian,
                  updateValue: (newValue) {
                    setState(() {
                      _vegeterian = newValue;
                      print(_vegeterian);
                    });
                  },
                ),
                _buildSwitchListTile(
                  title: "Vegan",
                  description: "Only include vegan meals",
                  currentValue: _vegan,
                  updateValue: (newValue) {
                    setState(() {
                      _vegan = newValue;
                      print(_vegan);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
