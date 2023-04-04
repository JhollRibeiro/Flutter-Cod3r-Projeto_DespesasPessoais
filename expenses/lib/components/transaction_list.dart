import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList({
    required this.transactions,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (cxt, constraints) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: constraints.maxHeight * 0.1,
                      bottom: constraints.maxHeight * 0.1,
                    ),
                    child: SizedBox(
                      height: constraints.maxHeight * 0.1,
                      child: Text(
                        'Nenhuma Transação Cadastrada.',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        :
        /**
         * Resolvendo o problema utilizando um 'ListView.builder.builder'
         * 
         * Por algum motivo o ValueKey(tr.id) não funciona neste contexto 'ListView.builder'
         * por esse motivo vamos utilizar o 'GlobalObjectKey(tr)', uma solução mais "cara" 
         * em termos de perfomance, pois o 'GlobalObjectKey' roda a árcore de componetes interia
         * em busca da chave (key) até encontrá-la.
         * 
         * Por esse motivo a 'ValueKey' deve ser a solução preferencial.
         */
        ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactioItem(
                key: GlobalObjectKey(tr),
                tr: tr,
                onRemove: onRemove,
              );
            },
          );

    // ListView(
    //     children: transactions.map((tr) {
    //       return TransactioItem(
    //         key: ValueKey(tr.id),
    //         tr: tr,
    //         onRemove: onRemove,
    //       );
    //     }).toList(),
    //   );
  }
}
