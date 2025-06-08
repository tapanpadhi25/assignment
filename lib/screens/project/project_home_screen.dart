import 'package:assignment_application/screens/auth/login_screen.dart';
import 'package:assignment_application/screens/project/project_details_screen.dart';
import 'package:assignment_application/utils/shared_pref_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/projects_model.dart';

class ProjectHomeScreen extends StatefulWidget {
  const ProjectHomeScreen({super.key});

  @override
  State<ProjectHomeScreen> createState() => _ProjectHomeScreenState();
}

class _ProjectHomeScreenState extends State<ProjectHomeScreen> {
  List<Project> _allProjects = [];
  List<Project> _filteredProjects = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProjects();
    _searchController.addListener(_filterProjects);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProjects() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('projects').get();

    setState(() {
      _allProjects =
          snapshot.docs.map((doc) => Project.fromJson(doc.data())).toList();
      _filteredProjects = _allProjects;
    });
  }

  void _filterProjects() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProjects = _allProjects
          .where((project) => project.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          "Projects",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPrefHelper.setBool("isLogin", false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 40,
              child: TextField(
                autofocus: false,
                style: Theme.of(context).textTheme.titleSmall,
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search projects by name',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredProjects.isEmpty
                ? const Center(child: Text('No matching projects found.'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _filteredProjects.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final project = _filteredProjects[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProjectDetailsScreen(
                                        title: project.name,
                                        project: project,
                                        allProjects: _filteredProjects,
                                      )));
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(project.name),
                            subtitle: Text('Amount: ₹${project.amount}'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
