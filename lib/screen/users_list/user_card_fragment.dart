import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_users_list/models/user.dart';

class UserCardFragment extends StatefulWidget {
  User user;
  UserCardFragment({Key? key, required this.user}) : super(key: key);

  @override
  State<UserCardFragment> createState() => _UserCardFragmentState();
}

class _UserCardFragmentState extends State<UserCardFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade700,
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 15,),
            Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    image: DecorationImage(
                      image: NetworkImage(widget.user.picture.thumbnail),
                    ),
                  ),
                ),
            const SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.user.name.title} ${widget.user.name.first}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  widget.user.username,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}