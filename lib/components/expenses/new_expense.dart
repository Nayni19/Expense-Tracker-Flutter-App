import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final Function onAdd;
  const NewExpense({super.key, required this.onAdd});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _pickedDate = 'select a date';

  void _showPicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final res = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _pickedDate = formatter.format(res!);
    });
  }

  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _submitExpenseHandler() {
    final amountIsInvalid = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid == null ||
        _pickedDate == 'select a date') {
      // Return error dialog
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please enter the correct values for date, amount and title'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Okay'))
                ],
              ));
      return;
    }

    final expenseToBeAdded = Expense(
        date: formatter.parse(_pickedDate),
        title: _titleController.text,
        amount: amountIsInvalid,
        category: _selectedCategory);

    widget.onAdd(expenseToBeAdded);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      var width = constraints.maxWidth;
      var height = constraints.maxHeight;

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(children: [
            if (width > height)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      maxLength: 50,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(label: Text('Title')),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        prefixText: 'Rs ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                ],
              )
            else
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.black),
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Title')),
              ),
            if (width > height)
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toString().toUpperCase(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                  Text(
                    _pickedDate.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  IconButton(
                      onPressed: _showPicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          prefixText: 'Rs ', label: Text('Amount')),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        _pickedDate.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      IconButton(
                          onPressed: _showPicker,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  )
                ],
              ),
            const SizedBox(
              height: 16,
            ),
            if (width > height)
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: _submitExpenseHandler,
                      child: const Text("Save Expense")),
                ],
              )
            else
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toString().toUpperCase(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: _submitExpenseHandler,
                      child: const Text("Save Expense")),
                ],
              )
          ]),
        ),
      );
    });
  }
}
