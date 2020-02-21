import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo/models/parent_user_model.dart';
import 'package:demo/screens/home/home_bloc.dart';
import 'package:demo/utils/color_define.dart';
import 'package:demo/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc();
  PageController controller = new PageController(
    initialPage: 100,
    keepPage: false,
    viewportFraction: 0.8,
  );
  int page = 100;

  @override
  void initState() {
    super.initState();
    bloc.getListUsers(context);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.loading.stream,
      builder: (context, AsyncSnapshot<bool> data) {
        var isLoad = data.data;
        if (isLoad == null) {
          isLoad = false;
        }
        return Stack(
          children: <Widget>[
            StreamBuilder(
                stream: bloc.listUserBloc.stream,
                builder: (context, AsyncSnapshot<List<ParentUserModel>> data) {
                  var list = data.data;
                  return list == null
                      ? Scaffold(
                          backgroundColor: Colors.white,
                          body: Container(),
                        )
                      : _buildBody(context, list);
                }),
            Utils.buildLoading(isLoad)
          ],
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, List<ParentUserModel> users) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          child: new PageView.builder(
              onPageChanged: (value) {
                if (page > value) {
                  //Swift left call API
                  bloc.getListUsers(context);
                  bloc.swiftRight(false);
                } else {
                  //Swift right
                  bloc.swiftRight(true);
                }
                page = value;
              },
              controller: controller,
              itemBuilder: (context, index) {
                return _buildItem(context, index, users[0]);
              }),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, ParentUserModel user) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page - index;
          value = (1 - (value.abs() * .4)).clamp(0.0, 1.0);
        }
        return new Center(
          child: new SizedBox(
            height: Curves.easeOut.transform(value) * 375,
            width: Curves.easeOut.transform(value) * 375,
            child: new Container(
              margin: const EdgeInsets.all(8.0),
              child: _buildUIItem(context, index, user, 375),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUIItem(
      BuildContext context, int index, ParentUserModel user, double height) {
    return Container(
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10.0,
            spreadRadius: 0.1,
            offset: Offset(
              1.0,
              5.0,
            ),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(child: _buildAvatar(context, user, height)),
          _buildUserName(context, user),
          _buildIconOption(context, user, height),
        ],
      ),
    );
  }

  _buildAvatar(BuildContext context, ParentUserModel user, double height) {
    var value = height - 252;
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 0, left: 0, right: 0),
          decoration: new BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: value,
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 32.0, bottom: 20, left: 0, right: 0),
            width: value,
            height: value,
            child: Material(
              shape: CircleBorder(),
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.all(0.0),
                decoration: new BoxDecoration(
                    color: ColorDefine.colorBlack,
                    borderRadius: BorderRadius.all(Radius.circular(value / 2))),
                child: CachedNetworkImage(
                  imageUrl: user.user.picture,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildUserName(BuildContext context, ParentUserModel user) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 0, right: 0),
      height: 100,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            'My address is',
            style: TextStyle(
                fontSize: 17,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.grey),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
            child: Text(
              ((user?.user?.location?.street ?? "") +
                  ", " +
                  (user?.user?.location?.city ?? "") +
                  ", " +
                  (user?.user?.location?.state ?? "") +
                  ", " +
                  (user?.user?.location?.zip ?? "")),
              style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  _buildIconOption(BuildContext context, ParentUserModel user, double width) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 0, right: 0),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildIconWith(
              context, Icons.supervised_user_circle, user, width, false),
          _buildIconWith(
              context, Icons.perm_contact_calendar, user, width, false),
          StreamBuilder(
              stream: bloc.isSwiftRightBloc.stream,
              builder: (context, AsyncSnapshot<bool> data) {
                return _buildIconWith(context, Icons.add_location, user, width,
                    data.data ?? false);
              }),
          _buildIconWith(context, Icons.phone, user, width, false),
          _buildIconLastWith(context, Icons.lock_outline, user, width),
        ],
      ),
    );
  }

  _buildIconWith(BuildContext context, IconData icon, ParentUserModel user,
      double width, bool isRight) {
    return Container(
      margin: EdgeInsets.only(top: 0, bottom: 0, left: 0),
      width: width / 6,
      height: width / 6,
      child: IconButton(
        icon: Icon(icon),
        onPressed: () {},
        color: isRight ? Colors.green : Colors.grey,
      ),
    );
  }

  _buildIconLastWith(
      BuildContext context, IconData icon, ParentUserModel user, double width) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
        child: IconButton(
          icon: Icon(icon),
          onPressed: () {},
          color: Colors.grey,
        ),
      ),
    );
  }
}
