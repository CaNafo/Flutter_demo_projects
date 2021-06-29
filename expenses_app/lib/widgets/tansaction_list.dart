import 'package:expneses_app/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  TransactionList(this._userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  "No transactons added yet",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              var tx = _userTransactions[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(child: Text('\$${tx.amount}'))),
                  ),
                  title: Text(
                    tx.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          onPressed: () {
                            _deleteTransaction(tx.id);
                          },
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).errorColor),
                          label: Text('Delete'))
                      : IconButton(
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).errorColor),
                          onPressed: () {
                            _deleteTransaction(tx.id);
                          },
                        ),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
