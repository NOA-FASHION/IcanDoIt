import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeActivation extends StatefulWidget {
  CodeActivation({Key key}) : super(key: key);

  @override
  State<CodeActivation> createState() => _CodeActivationState();
}

class _CodeActivationState extends State<CodeActivation> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100, left: 20, right: 20),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Card(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[Colors.orange, Colors.pink])),
              child: Column(
                children: [
                  SizedBox(height: 14),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 15,
                    borderOnForeground: true,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.18,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.production_quantity_limits,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Rentrer votre code d'activation  ",
                                  style: GoogleFonts.playfairDisplay(),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Rentrer votre adresse Email.",
                                  style: GoogleFonts.playfairDisplay(),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.lightbulb_rounded,
                                    color: Colors.blue),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Activation effective dans moins de 48h",
                                  style: GoogleFonts.playfairDisplay(),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            // Row(
                            //   children: [
                            //     Icon(Icons.contacts, color: Colors.blue),
                            //     SizedBox(
                            //       width: 6,
                            //     ),
                            //     Text(
                            //       "Easytodo972@gmail.com.",
                            //       style: GoogleFonts.playfairDisplay(),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      onSaved: (value) {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Merci d'entrer une adresse Email valide";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          helperText: "Exemple : george.todolist@gmail.com",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(15.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(15.0)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          labelText: "Adresse Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0, left: 30),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      onSaved: (value) {},
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Merci d'entrer le code d'activation";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          helperText: "Exemple : 'GPA.0386-2774-2650-645745'",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(15.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(15.0)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          labelText: "Nom de la mission",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            primary: Colors.amber,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            primary: Colors.amber,
                          ),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              {
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: const Text(
                            'Validé',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
