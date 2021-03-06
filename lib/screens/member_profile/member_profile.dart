import 'package:flutter/material.dart';
import 'package:mentorship_client/remote/models/user.dart';
import 'package:mentorship_client/remote/repositories/user_repository.dart';
import 'package:mentorship_client/screens/member_profile/user_data_list.dart';
import 'package:mentorship_client/screens/send_request/send_request_screen.dart';

class MemberProfileScreen extends StatelessWidget {
  final User user;

  const MemberProfileScreen({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Member Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Hero(
              tag: user.id,
              child: Icon(
                Icons.person,
                size: 96,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Hero(
              tag: user.username,
              child: Material(
                type: MaterialType.transparency,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      user.name,
                      textScaleFactor: 2,
                    ),
                  ),
                ),
              ),
            ),
            UserDataList(user: user),
            Center(
              child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text(
                    "Send request",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    var currentUser = await UserRepository.instance.getCurrentUser();

                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (c, anim1, anim2) => SendRequestScreen(
                          otherUser: user,
                          currentUser: currentUser,
                        ),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
