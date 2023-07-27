import 'package:flutter/material.dart';
import 'package:iventas_challenge/src/common/models/iv_user.dart';
import 'package:iventas_challenge/src/presentation/users_list/iv_label_widget.dart';

final class IVUserWidget extends StatelessWidget {
  final IVUser user;
  const IVUserWidget(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  Row(children: [
                    Image.network(user.image, height: 50, width: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.name} ${user.lastname}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    )
                  ]),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: user.labels.length,
                            itemBuilder: (context, index) => Row(
                                  children: [
                                    IVLabelWidget(user.labels[index]),
                                    const SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ))
                      ],
                    ),
                  )
                ]),
              )),
        ));
  }
}
