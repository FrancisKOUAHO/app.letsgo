import 'package:flutter/material.dart';

class NotAvailableYet extends StatelessWidget {
  const NotAvailableYet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Container(
          height: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color.fromARGB(51, 138, 138, 138),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/not_available.gif',
                width: 200,
                fit: BoxFit.cover,
              ),
              const Text("Patience... Ça arrive très bientôt 🤫",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}
