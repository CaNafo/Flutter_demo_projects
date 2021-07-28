import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_screen_provider.dart';
import '../widgets/custom_dialog_box.dart';
import '../widgets/info_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _flutterChosen = false;
  var _reactChosen = false;
  var _springChosen = false;

  var questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(
        new FocusNode(),
      ),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 70,
                        child: const Image(
                          image:
                              const AssetImage("assets/images/react_logo.png"),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const SizedBox(
                        height: 70,
                        child: const Image(
                          image:
                              const AssetImage("assets/images/spring_logo.png"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                    child: const Image(
                      image: const AssetImage("assets/images/flutter_logo.png"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: questionController,
                decoration: const InputDecoration(
                  labelText: "Unesite pitanje",
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => CustomDialogBox(
                          title: "Lista tehnologija",
                          descriptions:
                              "Odaberite tehnologije za koje postavljate pitanje.",
                          text: "ОK",
                          initValueFlutter: _flutterChosen,
                          initValueReact: _reactChosen,
                          initValueSpring: _springChosen,
                        ),
                      ).then(
                        (value) {
                          setState(() {
                            _flutterChosen = value[0];
                            _reactChosen = value[1];
                            _springChosen = value[2];
                          });
                        },
                      );
                    },
                    icon: (_flutterChosen || _reactChosen || _springChosen)
                        ? const Icon(Icons.check)
                        : const Icon(Icons.more_vert),
                    label: const Text("Odaberi tehnologiju"),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor: MaterialStateProperty.all(
                        (_flutterChosen || _reactChosen || _springChosen)
                            ? Colors.orange[500]
                            : Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    List technologiesList = [];
                    if (_flutterChosen) technologiesList.add("Flutter");
                    if (_reactChosen) technologiesList.add("React");
                    if (_springChosen) technologiesList.add("Spring");

                    if (questionController.text.length > 0 &&
                        technologiesList.length > 0) {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ));
                      homeProvider
                          .addQuestion(
                              questionController.text, technologiesList)
                          .then(
                            (value) => showDialog(
                                context: context,
                                builder: (ctx) {
                                  questionController.text = "";
                                  _flutterChosen = false;
                                  _reactChosen = false;
                                  _springChosen = false;
                                  return InfoDialog(
                                    title: "Čestitamo",
                                    descriptions:
                                        "Uspješno ste poslali pitanje. Listu svih pitanja sa odgovorima možete pogledati na ekranu Q&A.",
                                    text: "OK",
                                  );
                                }),
                          );
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) => InfoDialog(
                          title: "Pažnja",
                          descriptions:
                              "Molimo vas da unesete pitanje i odaberete tehnologiju.",
                          text: "OK",
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Pošalji",
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).buttonColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
