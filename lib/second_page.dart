import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osj_flutter/model/list_model.dart';
import 'package:osj_flutter/view_model/get_status.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Stream<OsjList>? stream;

  @override
  void initState() {
    super.initState();
    stream = getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<OsjList>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.dry_cleaning,
                    size: 50.0.r,
                  ),
                  Icon(
                    Icons.dry_cleaning,
                    size: 50.0.r,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,
                  ),
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,
                  ),
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,

                  ),
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,
                  ),
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,
                  ),
                  Icon(
                    Icons.local_laundry_service_outlined,
                    size: 50.0.r,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.dry_cleaning,
                    size: 50.0.r,
                  ),
                  Icon(
                    Icons.dry_cleaning,
                    size: 50.0.r,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.dry_cleaning,
                    size: 50.0.r,
                  ),
                  SizedBox(
                    width: 50.0.w,
                    height: 50.0.h,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
