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
   * Voltando o código
   */

  /*
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
  */

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
          backgroundColor: Theme.of(context).colorScheme.primary,
          // backgroundColor: _backgroundColor,
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
