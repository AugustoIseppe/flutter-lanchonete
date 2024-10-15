import 'package:flutter/material.dart';



class DialogDemo extends StatefulWidget {
  @override
  _DialogDemoState createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> {
  bool _showDialog = false;
  String _title = "Categoria atualizada com sucesso!";
  Icon _content = Icon(Icons.check_circle, color: Colors.green);
  bool _isSuccess = true;

  void _toggleDialog() {
    setState(() {
      _showDialog = !_showDialog;
    });
  }

  void _showCustomDialog(String title, String content, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          backgroundColor: const Color(0xfffff9e6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          titleTextStyle: const TextStyle(
            color: Color(0xff6f1610),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: const TextStyle(
            color: Color(0xff6f1610),
            fontSize: 16,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) _clearFields(); // Limpa os campos se for sucesso
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff6f1610),
                foregroundColor: Colors.white,
              ),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _clearFields() {
    // Implement your field clearing logic here
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _toggleDialog,
            child: Text(_showDialog ? 'Hide Dialog' : 'Show Dialog'),
          ),
          if (_showDialog)
            AlertDialog(
              title: Text(_title),
              content: Icon(_content.icon, color: _content.color),
              backgroundColor: const Color(0xfffff9e6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              titleTextStyle: const TextStyle(
                color: Color(0xff6f1610),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              contentTextStyle: const TextStyle(
                color: Color(0xff6f1610),
                fontSize: 16,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _toggleDialog();
                    if (_isSuccess) _clearFields(); // Limpa os campos se for sucesso
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff6f1610),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Ok'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
