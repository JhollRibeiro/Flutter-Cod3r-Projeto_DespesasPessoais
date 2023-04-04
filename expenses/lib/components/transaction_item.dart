import 'dart:math';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactioItem extends StatefulWidget {
  final Transaction tr;
  final void Function(String trId) onRemove;

  const TransactioItem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  @override
  State<TransactioItem> createState() => _TransactioItemState();
}

class _TransactioItemState extends State<TransactioItem> {

  /*
   * O problema ocorre quando se usa um componente do tipo Lista em uma classe 'StatefulWidget'
   * Como a atualização do estado da aplicação não ocorre no componente, desde que eles sejam 
   * os mesmos, após a mudança do estado, então nada além dos dados será atualizado (apenas para List)
   * 
   * No momento em que excluir o item, apenas os dados serão atualizado, porém o _backgroundColor
   * não sofrerá alteração, pois o componente da lista nao mudou e a cor do item que ficou 
   * passará a ser a cor do item que está imediatemente anterior a ale, ou seja, o item de baixo 
   * assume a cor do item de cima q acabou de ser excuido. Bizarro, né?
   * 
   * Rode o código desse commit RESOLVER este problema (Resolução 2)
   *  - Solução mais "cara" em termos de perfomance.
   */
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();

    _backgroundColor = colors[Random().nextInt(5)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _backgroundColor, //Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${widget.tr.value.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat('d MMM y').format(widget.tr.date)),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => widget.onRemove(widget.tr.id),
                label: const Text(
                  'Excluir',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            : IconButton(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
      ),
    );
  }
}
