import 'dart:io';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
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
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta antiga - Adicionando um texto muito grande',
      value: 410.98,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Cartão Crédito',
      value: 1583.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Lanche',
      value: 557.98,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't5',
      title: 'Conta1',
      value: 330.98,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't6',
      title: 'Conta2',
      value: 410.98,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't7',
      title: 'Conta3',
      value: 658.98,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't8',
      title: 'Conta4',
      value: 330.98,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Transaction(
      id: 't9',
      title: 'Conta4',
      value: 839.87,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  bool _showChart = false;

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

  Widget _getIconButton(
      IconData icon, Function() fn, MediaQueryData mediaQuery) {
    final ico = Icon(icon, size: 35 * mediaQuery.textScaleFactor);

    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: ico)
        : IconButton(onPressed: fn, icon: ico);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final isIOS = Platform
        .isIOS; // Através do 'Platform i(mport 'dart:io')' é possível detectar a plataforma em que o App está rodadno

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart
              ? isIOS
                  ? CupertinoIcons.list_bullet
                  : Icons.list
              : isIOS
                  ? CupertinoIcons.chart_bar_square
                  : Icons.bar_chart_rounded,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
          mediaQuery,
        ),
      _getIconButton(
        isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
        mediaQuery,
      ),
    ];

    final appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: actions,
    );

    // Pegandop a altura disponível da tela dinamicamente.
    //
    // Observe que foi necessário colocar o Widget 'AppBar'
    // numa constante para utilizar o valor de sua altura.
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    var bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text('Exibir Gráfico'),
            //       Switch.adaptive( // usar o 'Switch.adaptive' para se adaptar à plataforma que está rodadno, ao invés de usar somente o 'Switch'
            //                        // Com isso, será motrado no IOS o toogle padrão do IOS e nao o do Android
            //                        // Ver commit 'Seção 5 - App Despesas Pessoais - Aula 148. Modo Paisagem #04'
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = !_showChart;
            //           });
            //         },
            //       )
            //     ],
            //   ),
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (_showChart ? 1 : 0.3),
                child: Chart(
                  recentTransaction: _recentTransactions,
                ),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height:
                    availableHeight * (!_showChart && isLandscape ? 1 : 0.7),
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
          ],
        ),
      ),
    );

    if (!isLandscape) {
      _showChart = false;
    }

    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                middle: const Text('Despesas Pessoais'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions,
                )),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: isIOS
                ? Container() // Caso seja IOS não exibir um 'floatingActionButton' que é um componente "estranho" ao IOS
                : FloatingActionButton(
                    elevation: 10,
                    child: const Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
