import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_course/logic/logic.dart';

import 'package:my_flutter_course/ui/screens/product_list/product_list.dart';


class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _acceptTerms = true;
  final Map _formData = <String, String>{
    'email': 'test@domain.com',
    'password': 'password',
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'E-Mail',
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      initialValue: _formData['email'],
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter an email address';
        } else if (!Email.isAddressValid(value)) {
          return 'Please enter a valid address name';
        }
      },
      onSaved: (value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      initialValue: _formData['password'],
      validator: (value) {
        if (value.isEmpty) {
          return 'Password invalid';
        }
      },
      onSaved: (value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _acceptTerms,
      onChanged: (value) {
        setState(() {
          _acceptTerms = value;
        });
      },
      title: const Text('Accept Terms'),
    );
  }

  void _submitForm(_authBlock, context) {
    if (!_formKey.currentState.validate() || !_acceptTerms) {
      return;
    }
    _formKey.currentState.save();

    _authBlock.dispatch(
      LoggingdIn(
        password: _formData['password'],
        email: Email(
          _formData['email'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    final _authBlock = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
            image: const AssetImage('assets/images/background.jpg'),
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: _buildForm(_authBlock, context),
            ),
          ),
        ),
      ),
    );
  }

  BlocListener _buildForm(AuthBloc _authBlock, BuildContext context) {
    return BlocListener(
      bloc: _authBlock,
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacementNamed(context, ProductsList.routeName);
        }
        SnackBar snackBar;
        switch (state.runtimeType) {
          case Loading:
            snackBar = SnackBar(content: Text('loading'));
            break;
          case Unauthenticated:
            if (state.hasError) {
              String error;
              if (state.error is WrongCredentiaException) {
                error = 'Check email and password';
              }
              snackBar = SnackBar(
                content: Text('Error: $error'),
                backgroundColor: Colors.redAccent,
              );
            }
        }
        if (snackBar != null) {
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildEmailTextField(),
            const SizedBox(
              height: 10.0,
            ),
            _buildPasswordTextField(),
            _buildAcceptSwitch(),
            const SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              textColor: Colors.white,
              child: const Text('LOGIN'),
              onPressed: () => _submitForm(_authBlock, context),
            )
          ],
        ),
      ),
    );
  }
}
