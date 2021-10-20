import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_users_list/models/user.dart';

class UserScreen extends StatefulWidget {
  User user;
  UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: "Назад",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.user.username,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Image.network(
              widget.user.picture.large,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20,),
            Center(
              child: Text(
                "${widget.user.name.first} ${widget.user.name.last}",
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Почтовый индекс: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white54,
                      ),
                    ),
                    Text(
                      widget.user.location.postcode,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Штат: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white54,
                      ),
                    ),
                    Text(
                      widget.user.location.state,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Город: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white54,
                      ),
                    ),
                    Text(
                      widget.user.location.city,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Улица: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white54,
                      ),
                    ),
                    Text(
                      widget.user.location.street,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}