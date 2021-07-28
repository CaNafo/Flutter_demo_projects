import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home-screen";
  @override
  Widget build(BuildContext context) {
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
              const TextField(
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
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                    label: const Text("Odaberi tehnologiju"),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).buttonColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Pošalji"),
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
