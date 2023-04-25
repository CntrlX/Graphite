import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginState extends State {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _password;
  bool loginPage = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: loginPage ? Text('Login Page') : Text('Register Page'),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 400.0,
              maxHeight: 700.0,
            ),
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        if (loginPage == true) {
                          try {
                            setState(() {
                              loading = true;
                            });
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _username, password: _password);
                            setState(() {
                              loading = false;
                            });

                            Navigator.pushNamed(context, '/NNmodelSystem');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              setState(() {
                                loading = false;
                              });

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey[900],
                                    title: Text(
                                      'Error',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      'User not found',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (e.code == 'wrong-password') {
                              setState(() {
                                loading = false;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey[900],
                                    title: Text(
                                      'Error',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      'Invalid username or password',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        } else {
                          try {
                            setState(() {
                              loading = true;
                            });
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _username, password: _password);
                            setState(() {
                              loading = false;
                            });

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  title: Text(
                                    'Success',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    'You have been successfully registered',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          loginPage = !loginPage;
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              setState(() {
                                loading = false;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey[900],
                                    title: Text(
                                      'Error',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      'The password provided is too weak.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (e.code == 'email-already-in-use') {
                              setState(() {
                                loading = false;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey[900],
                                    title: Text(
                                      'Error',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      'The account already exists for that email.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } catch (e) {
                            setState(() {
                              loading = false;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  title: Text(
                                    'Error',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    '${e}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      }
                    },
                    child: loading
                        ? SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 5,
                            ),
                          )
                        : (loginPage ? Text('Login') : Text('Register')),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      textStyle: TextStyle(fontSize: 18.0),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 200.0),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          loginPage = !loginPage;
                        });
                      },
                      child: loginPage ? Text('Register') : Text('Login'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
