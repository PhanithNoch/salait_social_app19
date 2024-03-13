import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salait_social_app/constant/constant.dart';

import '../../controllers/posts/create_post_controller.dart';
import '../../controllers/posts/post_controller.dart';
import 'create_post_screen.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(PostController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreatePostScreen());
            },
            icon: Icon(Icons.camera_alt_rounded),
          ),
        ],
      ),
      body: GetBuilder<PostController>(builder: (_) {
        if (_controller.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final post = _controller.post!.posts;
        if (post == null) {
          return Center(
            child: Text("No Post Found"),
          );
        }
        return ListView.builder(
          itemCount: post.data != null ? post.data!.length : 0,
          itemBuilder: (context, index) {
            final ps = post.data![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ps.user!.profilePic != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                "${kBaseUrl}/" + ps.user!.profilePic!),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(kDefaultProfilePic),
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(ps.user!.name!),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("${ps.caption}"),
                SizedBox(
                  height: 10,
                ),
                Image.network("${kBaseUrlPost}/${ps.image}"),
              ],
            );
          },
        );
      }),
    );
  }
}
