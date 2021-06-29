import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  var _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        final product = Provider.of<ProductsProvider>(context, listen: false)
            .findByID(productId);
        _editedProduct = product;
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': '${_editedProduct.price}',
          'imageUrl': _editedProduct.imageUrl,
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<Null> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id == null) {
      await Provider.of<ProductsProvider>(
        context,
        listen: false,
      ).addProduct(_editedProduct).catchError((error) {
        return showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("An error occurred"),
            content: Text("Something went wrong"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"))
            ],
          ),
        );
      });
    } else {
      await Provider.of<ProductsProvider>(
        context,
        listen: false,
      ).updateProduct(_editedProduct.id, _editedProduct);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                      initialValue: _initValues['title'],
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) return "Please provide a item title";
                        return null;
                      },
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_priceFocusNode),
                      onSaved: (newValue) => _editedProduct = Product(
                        id: _editedProduct.id,
                        title: newValue,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Price"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      initialValue: _initValues['price'],
                      validator: (value) {
                        if (value.isEmpty) return "Please provide a item price";
                        return null;
                      },
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode),
                      onSaved: (newValue) => _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(newValue),
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Description"),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      initialValue: _initValues['description'],
                      validator: (value) {
                        if (value.isEmpty)
                          return "Please provide a item description";
                        return null;
                      },
                      focusNode: _descriptionFocusNode,
                      onSaved: (newValue) => _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: newValue,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Text("Enter a url")
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Image url",
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value.isEmpty)
                                return "Please provide a item image url";
                              return null;
                            },
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) => _saveForm(),
                            onSaved: (newValue) => _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: newValue,
                                isFavorite: _editedProduct.isFavorite),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
