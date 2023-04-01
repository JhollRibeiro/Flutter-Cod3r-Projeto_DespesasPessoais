import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/chart.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(
        // brightness: Brightness.dark,
        );

    return MaterialApp(
      theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'Quicksand',
              // Para considerar a responsividade/adaptabilidade em textos
              // é necessário definir o produto do 'textScaleFactor'.
              // Essa propriedade é definida nas configurações do aparelho,
              // logo, se o usuário definir um tamnaho de fonte para seu dispositivo
              // os textos do seu app que usam tal propriedade serão adaptados automaticamente.
              //
              // Em nosso exemplo abaixo, o texto do appBar aplica e, portanto, seguirá
              // as configurações do usuário.
              //
              // Vale lembrar que essa "configuração" será soproposta caso
              // o fontSize seja definido dentro do Widget.
              fontSize: 25 * MediaQuery.of(context).textScaleFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.grey[900],
                fontWeight: FontWeight.bold,
              ),
              bodyMedium: const TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.black,
              ))),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            size: 35 * MediaQuery.of(context).textScaleFactor,
          ),
          onPressed: () => _openTransactionFormModal(context),
        )
      ],
    );

    // Pegandop a altura disponível da tela dinamicamente.
    //
    // Observe que foi necessário colocar o Widget 'AppBar'
    // numa constante para utilizar o valor de sua altura.
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: availableHeight * 0.3,
              child: Chart(
                recentTransaction: _recentTransactions,
              ),
            ),
            SizedBox(
              height: availableHeight * 0.7,
              child: TransactionList(
                transactions: _transactions,
                onRemove: _removeTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
