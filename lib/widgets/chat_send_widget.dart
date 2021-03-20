import 'package:cached_network_image/cached_network_image.dart';
import 'package:elgam3a/models/message_model.dart';
import 'package:elgam3a/utilities/loading.dart';
import 'package:elgam3a/widgets/show_picture_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatSendWidget extends StatelessWidget {
  final MessageModel message;

  ChatSendWidget({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              'you',
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          if (message.imageUrl != null) ...[
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                      opaque: false,
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      pageBuilder: (BuildContext context, _, __) {
                        return ShowPicturePopUp(
                          image: message.imageUrl,
                          tag: 'message/image/${message.id}',
                        );
                      })),
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: 186,
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Hero(
                  tag: 'message/image/${message.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: '${message.imageUrl}',
                      height: 186,
                      width: MediaQuery.of(context).size.width * 0.5,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => LoadingWidget(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            )
          ] else ...[
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              margin: EdgeInsets.only(bottom: 4.0),
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                '${message.message}',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            )
          ],
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              '${DateFormat('HH:mm').format(message.time)}',
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          SizedBox(height: 32.0),
        ],
      ),
    );
  }
}
