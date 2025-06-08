import 'dart:io';

import 'package:assignment_application/providers/project_providers.dart';
import 'package:assignment_application/screens/project/map_screen.dart';
import 'package:assignment_application/utils/global_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';

import '../../models/projects_model.dart';
import 'chat_screen.dart';

class ProjectDetailsScreen extends ConsumerStatefulWidget {
  final String title;
  final Project project;
  final List<Project> allProjects;
  const ProjectDetailsScreen(
      {super.key, required this.title, required this.project, required this.allProjects, });

  @override
  ConsumerState<ProjectDetailsScreen> createState() =>
      _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends ConsumerState<ProjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var projectState = ref.watch(projectProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(widget.project.description)),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MapScreen(
                               allProjects: widget.allProjects,
                              )));
                },
                child: const Icon(Icons.map, color: Colors.purple),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            project: widget.project,
                          )));
                },
                child: const Icon(Icons.add_chart, color: Colors.purple),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.purple,
                elevation: 3,
              ),
              onPressed: () => _showUploadBottomSheet(context, projectState),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  "Upload",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              )),
          projectState.documentLists.isEmpty
              ? const SizedBox()
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 12),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.purple)),
                      padding: const EdgeInsets.all(6),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(projectState.documentLists
                                  .elementAt(index)
                                  .path
                                  .split("/")
                                  .last)),
                          const SizedBox(width: 10),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  OpenFilex.open(projectState.documentLists
                                      .elementAt(index)
                                      .path);
                                });
                              },
                              child: const Icon(
                                Icons.visibility,
                                color: Colors.purple,
                              )),
                          const SizedBox(width: 16),
                          // GestureDetector(
                          //     onTap: () async {
                          //       await downloadFileFromUrl(projectState
                          //           .documentLists
                          //           .elementAt(index)
                          //           .path);
                          //     },
                          //     child: const Icon(
                          //       Icons.download,
                          //       color: Colors.purple,
                          //     )),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: projectState.documentLists.length)
        ],
      ),
    );
  }

  void _showUploadBottomSheet(
      BuildContext context, ProjectProviders projectProvider) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Upload from Camera"),
                onTap: () async {
                  final picked =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (picked != null) {
                    projectProvider.setDocument(File(picked.path));
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Upload from Gallery"),
                onTap: () async {
                  final picked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    projectProvider.setDocument(File(picked.path));
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text("Upload from File"),
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'png', 'mp4', 'mov'],
                  );
                  if (result != null && result.files.single.path != null) {
                    projectProvider
                        .setDocument(File(result.files.single.path!));
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
