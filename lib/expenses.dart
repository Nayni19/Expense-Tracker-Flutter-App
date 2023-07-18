import 'package:expense_tracker_app/components/chart/chart.dart';
import 'package:expense_tracker_app/components/expenses/expense_list.dart';
import 'package:expense_tracker_app/components/expenses/new_expense.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        date: DateTime.now(),
        title: 'Flutter Course',
        amount: 499.0,
        category: Category.work),
    Expense(
        date: DateTime.now(),
        title: 'Groceries',
        amount: 800.0,
        category: Category.food),
    Expense(
        date: DateTime.now(),
        title: 'Cinema',
        amount: 1499.0,
        category: Category.leisure),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void onAddExpense(Expense expense) {
    _addExpense(expense);
  }

  void onRemoveExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(
            () {
              _registeredExpenses.insert(expenseIndex, expense);
            },
          ),
        ),
      ),
    );
  }

  void _showModal() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAdd: onAddExpense));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          title: Text('Expense Tracker'),
          actions: [IconButton(onPressed: _showModal, icon: Icon(Icons.add))]),
      body: SafeArea(
          child: width < height
              ? Column(
                  children: [
                    Chart(expenses: _registeredExpenses),
                    Expanded(
                        child: _registeredExpenses.isEmpty
                            ? const Center(
                                child:
                                    Text('No expenses added. Try adding some!'),
                              )
                            : ExpenseList(
                                expenses: _registeredExpenses,
                                onRemove: onRemoveExpense,
                              ))
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: Chart(expenses: _registeredExpenses)),
                    Expanded(
                      child: _registeredExpenses.isEmpty
                          ? const Center(
                              child:
                                  Text('No expenses added. Try adding some!'),
                            )
                          : ExpenseList(
                              expenses: _registeredExpenses,
                              onRemove: onRemoveExpense,
                            ),
                    ),
                  ],
                )),
    );
  }
}
