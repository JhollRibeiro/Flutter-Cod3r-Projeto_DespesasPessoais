import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/models/transaction.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    // showModalBottomSheet(
    //   context: context,
    //   builder: (_) {
    //     return TransactionForm(onSubmit: onSubmit)
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 5,
                color: Colors.blue,
                child: Text('Gráfico'),
              ),
            ),
            Column(
              children: <Widget>[
                TransactionList(
                  transactions: _transactions,
                ),
                TransactionForm(
                  onSubmit: _addTransaction,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
